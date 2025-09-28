generate "provider" {
    path = "provider.tf"
        if_exists = "overwrite_terragrunt"
        contents  = <<EOF
        terraform {
        required_providers {
            aws = {
                source = "hashicorp/aws"
                    version = "~> 6.0"
            }
            awsutils = {
                source = "cloudposse/awsutils"
                    version = "~> 0.20"
            }
        }
        backend "oss" {
            bucket = "terraform-remote-backends"
                prefix = "terragrunt-github-aws-hub"
                key = "${path_relative_to_include()}/terraform.tfstate"
                acl = "private"
                region = "cn-shanghai"
                encrypt = "false"
        }
    }
    provider "aws" {
        region = "${basename(get_terragrunt_dir())}"
    }
    provider "awsutils" {
        region = "${basename(get_terragrunt_dir())}"
    }
    EOF
}