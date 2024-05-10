terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.22.0"
    }
    skopeo2 = {
      source  = "bsquare-corp/skopeo2"
      version = "1.1.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

#https://registry.terraform.io/providers/bsquare-corp/skopeo2/latest
provider "skopeo2" {

  destination {
    login_username = data.aws_ecr_authorization_token.ecr_token.user_name
    login_password = data.aws_ecr_authorization_token.ecr_token.password
  }
}

data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "ecr_token" {
  provider = aws
}




