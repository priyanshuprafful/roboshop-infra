locals {
 # private_subnet_ids = { for k , v in module.vpc["main"].private_subnets : k => v.id }
# private_subnet_idds = [ for k , v in module.vpc["main"].private_subnets : v.id ]
 # private_subnet_idds = [ for k , v in module.vpc["main"].private_subnets["db-az1"] : v.id ]
  subnet_ids = {
    web = tolist([module.vpc["main"].private_subnets["web-az1"].id , module.vpc["main"].private_subnets["web-az2"].id ])
    app = tolist([module.vpc["main"].private_subnets["app-az1"].id , module.vpc["main"].private_subnets["app-az2"].id ])
    db = tolist([module.vpc["main"].private_subnets["db-az1"].id , module.vpc["main"].private_subnets["db-az2"].id ])
    public = tolist([module.vpc["main"].public_subnets["public-az1"].id , module.vpc["main"].public_subnets["public-az2"].id ])

  }

  subnet_cidr = {
    web = tolist([module.vpc["main"].private_subnets["web-az1"].cidr_block , module.vpc["main"].private_subnets["web-az2"].cidr_block ])
    app = tolist([module.vpc["main"].private_subnets["app-az1"].cidr_block , module.vpc["main"].private_subnets["app-az2"].cidr_block ])
    db = tolist([module.vpc["main"].private_subnets["db-az1"].cidr_block , module.vpc["main"].private_subnets["db-az2"].cidr_block ])
    public = tolist([module.vpc["main"].public_subnets["public-az1"].cidr_block , module.vpc["main"].public_subnets["public-az2"].cidr_block ])

  }

  db_subnet_ids = tolist([module.vpc["main"].private_subnets["db-az1"].id , module.vpc["main"].private_subnets["db-az2"].id ])
  web_subnet_ids = tolist([module.vpc["main"].private_subnets["web-az1"].id , module.vpc["main"].private_subnets["web-az2"].id ])
  app_subnet_ids = tolist([module.vpc["main"].private_subnets["app-az1"].id , module.vpc["main"].private_subnets["app-az2"].id ])
}

# we are able to use it because we have defined outputs in tf-module-vpc and over there we have given subnets as output