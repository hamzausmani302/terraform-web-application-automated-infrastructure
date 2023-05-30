terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"

    }
  }

}

provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = var.credentials_file_path
  profile                 = var.aws_user
}


data "aws_availability_zones" "available" {
  state = "available"
}


