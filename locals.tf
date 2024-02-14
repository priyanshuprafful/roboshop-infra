locals {
  private_subnet_ids = { for k , v in module.vpc["main"].private_subnets : k => v.id }
}