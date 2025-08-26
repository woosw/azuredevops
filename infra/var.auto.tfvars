env       = "dev"    # dev, prod 등
service   = "demo"   # 서비스명, 프로젝트명 등

location  = "Korea Central"
tags      = { 
    env = "dev", 
    owner = "wsw" 
    }

rg_name       = locals.rg_name
vnet_name     = locals.vnet_name
address_space = ["10.9.0.0/20"]
subnets = [
  { name = "snet-app", address_prefixes = ["10.9.0.0/27"] },
  { name = "snet-db",  address_prefixes = ["10.9.0.32/27"] }
]