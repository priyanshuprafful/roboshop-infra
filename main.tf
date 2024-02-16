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
  subnet_ids = local.db_subnet_ids

  for_each = var.docdb
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot = each.value["skip_final_snapshot"]
  no_of_instances = each.value["no_of_instances"]
  instance_class = each.value["instance_class"]

}

module "rds" {

  source = "git::https://github.com/priyanshuprafful/tf-module-rds.git"

  env = var.env
  tags = var.tags
  subnet_ids = local.db_subnet_ids

  for_each = var.rds
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]

}
#output "vpc" {
#  value = local.db_subnet_ids
#}




# in order to access these variables we have to define them in tf-module-vpc / vars.tf file
# that is why there vpc_cidr , public_subnets , env are defined