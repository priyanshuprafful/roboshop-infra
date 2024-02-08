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
  for_each = var.vpc
  vpc_cidr = each.value["vpc_cidr"]

} 