terraform {
  required_version = ">= 1.4.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"         # 버전 고정(중요)
    }
  }
  # (선택) 원격 상태 백엔드: 미리 만든 스토리지 필요
  # backend "azurerm" {
  #   resource_group_name  = "rg-tfstate"
  #   storage_account_name = "tfstatekrc1234"
  #   container_name       = "state"
  #   key                  = "dev.tfstate"
  # }
}
provider "azurerm" { 
    features {} 
    }