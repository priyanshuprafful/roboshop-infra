locals {
  private_subnet_ids = {for k, v in module.vpc.private_subnets["main"] : k => v.id}
}