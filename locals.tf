locals {
 # private_subnet_ids = { for k , v in module.vpc["main"].private_subnets : k => v.id }
# private_subnet_idds = [ for k , v in module.vpc["main"].private_subnets : v.id ]
 # private_subnet_idds = [ for k , v in module.vpc["main"].private_subnets["db-az1"] : v.id ]
  db_subnet_ids = tolist([module.vpc["main"].private_subnets["db-az1"].id , module.vpc["main"].private_subnets["db-az2"].id ])

}