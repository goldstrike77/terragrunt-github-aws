generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "azurerm" {
    environment = "public"
    resource_group_name = "terraform-state"
    storage_account_name = "satfstate01ssaz"
    container_name = "tfstat"
    key = "terragrunt-github-aws/${path_relative_to_include()}/terraform.tfstate"
    subscription_id = "b971283c-e0b7-46a4-9496-9cbfb850ebe5"
    tenant_id = "e824e20c-c5d7-4a69-adb1-3494404763a5"
  }
}

provider "aws" {
  region = "ap-south-1"
}
EOF
}