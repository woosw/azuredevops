terraform {
  required_version = ">= 1.9, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
  }
}

provider "azurerm" {
#   skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

variable "subscription_id" {
  description = "The Azure subscription ID to use for the resources."
  type        = string
  nullable = false
  default = "8fd0c826-a1e4-4e12-a572-37ecd955cca4"
}