locals {
    common_tags = {
        EAICODE         = var.infrastructure.EAICODE
        Environment     = var.infrastructure.env_name
        ProvisionedBy   = "Terraform" # NotTerraform
  }
}