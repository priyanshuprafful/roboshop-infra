#module "ec2" {
#  for_each = var.instances
#  source = "./ec2"
#  component = each.value["name"]
#  instance_type = each.value["type"]
#  env = var.env
#  monitor = try(each.value["monitor"] , false)
#  // password = try(each.value["password"] , null)
#}

module "vpc" {
  source = "git::https://github.com/priyanshuprafful/tf-module-vpc.git"

  env = var.env
  tags = var.tags
  default_route_table = var.default_route_table
  default_vpc_id = var.default_vpc_id
  for_each = var.vpc
  vpc_cidr = each.value["vpc_cidr"]
  public_subnets = each.value["public_subnets"]
  private_subnets = each.value["private_subnets"]

}
// /*
module "docdb" {

  source = "git::https://github.com/priyanshuprafful/tf-module-docdb.git"

  env = var.env
  tags = var.tags
  subnet_ids = local.db_subnet_ids
  vpc_id              = module.vpc["main"].vpc_id

  for_each = var.docdb
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot = each.value["skip_final_snapshot"]
  no_of_instances = each.value["no_of_instances"]
  instance_class = each.value["instance_class"]
  allow_subnets       = lookup(local.subnet_cidr, each.value["allow_subnets"] , null)


}

module "rds" {

  source = "git::https://github.com/priyanshuprafful/tf-module-rds.git"

  env = var.env
  tags = var.tags
  subnet_ids = local.db_subnet_ids
  vpc_id     = module.vpc["main"].vpc_id


  for_each                = var.rds
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  instance_class          = each.value["instance_class"]
  no_of_instances         = each.value["no_of_instances"]
  allow_subnets       = lookup(local.subnet_cidr, each.value["allow_subnets"] , null)


}


module "elasticache" {

  source = "git::https://github.com/priyanshuprafful/tf-module-elasticache.git"

  env = var.env
  tags = var.tags
  subnet_ids = local.db_subnet_ids
  vpc_id              = module.vpc["main"].vpc_id

  for_each                = var.elasticache
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  num_cache_nodes         = each.value["num_cache_nodes"]
  node_type               = each.value["node_type"]
  port                    = each.value["port"]
  allow_subnets       = lookup(local.subnet_cidr, each.value["allow_subnets"] , null)
#  backup_retention_period = each.value["backup_retention_period"]
#  preferred_backup_window = each.value["preferred_backup_window"]
#  instance_class          = each.value["instance_class"]
#  no_of_instances         = each.value["no_of_instances"]

}

module "rabbitmq" {

  depends_on = [module.vpc]
  source = "git::https://github.com/priyanshuprafful/tf-module-rabbitmq.git"

  env = var.env
  tags = var.tags

  bastion_cidr = var.bastion_cidr
  dns_domain = var.dns_domain

  subnet_ids = local.db_subnet_ids
  vpc_id     = module.vpc["main"].vpc_id
  for_each = var.rabbitmq
  instance_type = each.value["instance_type"]
  allow_subnets       = lookup(local.subnet_cidr, each.value["allow_subnets"] , null)


}

// */

module "alb" {
  source = "git::https://github.com/priyanshuprafful/tf-module-alb.git"
  env = var.env
  tags = var.tags
  vpc_id = module.vpc["main"].vpc_id
  allow_cidr = each.value["allow_cidr"]


  for_each = var.alb
  name = each.value["name"]
  internal = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]
  subnets = lookup(local.subnet_ids , each.value["subnet_name"] , null )


}

#output "vpc" {
#  value = local.db_subnet_ids
#}




# in order to access these variables we have to define them in tf-module-vpc / vars.tf file
# that is why there vpc_cidr , public_subnets , env are defined

module "app" {


  depends_on = [module.vpc , module.alb , module.docdb , module.elasticache , module.rds , module.rabbitmq]

  source = "git::https://github.com/priyanshuprafful/tf-module-app.git"

  env = var.env
  tags = var.tags
  vpc_id = module.vpc["main"].vpc_id
  bastion_cidr = var.bastion_cidr
  monitoring_nodes = var.monitoring_nodes
  dns_domain = var.dns_domain

  for_each = var.app
  component = each.value["component"]
  instance_type = each.value["instance_type"]
  desired_capacity = each.value["desired_capacity"]
  max_size = each.value["max_size"]
  min_size = each.value["min_size"]
  subnets = lookup(local.subnet_ids , each.value["subnet_name"] , null )
  port    = each.value["port"]
  listener_priority = each.value["listener_priority"]
  parameters = each.value["parameters"]
  allow_app_to = lookup(local.subnet_cidr , each.value["allow_app_to"] , null )
  alb_dns_name  = lookup(lookup(lookup(module.alb , each.value["alb"] , null ) , "alb" , null) , "dns_name" , null)
  # actually dns_name output of alb ka part hai to hum wo use kar rahe hai

  listener_arn  = lookup(lookup(lookup(module.alb , each.value["alb"] , null ) , "listener" , null) , "arn" , null)


}

#output "redis" {
#  value = module.elasticache
#}
# each.value ["alb"] actually alb can be public or private that is why we used like that





## Load Runner creation with spot instance

#
#resource "aws_spot_instance_request" "load-runner" {
#  ami = data.aws_ami.ami.id
#  instance_type = "t3.medium"
#  wait_for_fulfillment = true
#  vpc_security_group_ids = ["sg-017c17be83f3872d4"] # our created security id in default vpc allow-all
#
#  tags = merge(
#    var.tags,
#    { Name = "load-runner" }
#  )
#}
#
#resource "aws_ec2_tag" "name_tag" {
#  key         = "Name"
#  resource_id = aws_spot_instance_request.load-runner.spot_instance_id
#  value       = "Load-runner"
#}
#
#resource "null_resource" "load-gen" {
#
#  triggers = {
#    id = aws_spot_instance_request.load-runner.public_ip
#  }
## triggers is used to trigger provisioner and if there is no change in value then it is not going to execute provisioner
#  # and if there is a change in id ( triggers ) then it will execute that value .
#  provisioner "remote-exec" {
#    connection {
#      host = aws_spot_instance_request.load-runner.public_ip
#      user = "root"
#      password = data.aws_ssm_parameter.ssh_pass.value
#    }
#    inline = [
#      "set-hostname load-runner",
#      "curl -s -L https://get.docker.com | bash",
#      "systemctl enable docker",
#      "systemctl start docker",
#      "docker pull robotshop/rs-load"
#    ]
#  }
#}

/*
### Load Runner
resource "aws_spot_instance_request" "load-runner" {
  ami                    = data.aws_ami.ami.id
  instance_type          = "t3.medium"
  wait_for_fulfillment   = true
  vpc_security_group_ids = ["sg-017c17be83f3872d4"]

  tags = merge(
    var.tags,
    { Name = "load-runner" }
  )
}

resource "aws_ec2_tag" "name-tag" {
  key         = "Name"
  resource_id = aws_spot_instance_request.load-runner.spot_instance_id
  value       = "load-runner"
}

resource "null_resource" "load-gen" {
  triggers = {
    abc = aws_spot_instance_request.load-runner.public_ip
  }
  provisioner "remote-exec" {
    connection {
      host     = aws_spot_instance_request.load-runner.public_ip
      user     = "root"
      password = data.aws_ssm_parameter.ssh_pass.value
    }
    inline = [
      "set -hostname load-runner",
      "curl -s -L https://get.docker.com | bash",
      "systemctl enable docker",
      "systemctl start docker",
      "docker pull robotshop/rs-load"
    ]
  }
}

*/