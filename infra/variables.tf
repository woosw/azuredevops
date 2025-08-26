variable "env" {
  description = "환경 (예: dev, qa, prod)"
  type        = string
}

variable "service" {
  description = "서비스/시스템 명칭"
  type        = string
}

variable "location"      { 
    type = string 
    }
variable "tags"          { 
    type = map(string) 
    default = {} 
    }
variable "rg_name"       { 
    type = string 
    }
variable "vnet_name"     { 
    type = string 
    }
variable "address_space" { 
    type = list(string) 
    }
variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}