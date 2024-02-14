locals {
 # private_subnet_ids = { for k , v in module.vpc["main"].private_subnets : k => v.id }
  private_subnet_idds = [ for k , v in module.vpc["main"].private_subnets : v.id ]

}