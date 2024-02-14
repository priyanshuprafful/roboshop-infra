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

module "docdb" {

  source = "git::https://github.com/priyanshuprafful/tf-module-docdb.git"

  env = var.env
  tags = var.tags
  for_each = var.docdb
  engine = each.value["engine"]

}
#output "vpc" {
#  value = module.vpc
#}

# in order to access these variables we have to define them in tf-module-vpc / vars.tf file
# that is why there vpc_cidr , public_subnets , env are defined