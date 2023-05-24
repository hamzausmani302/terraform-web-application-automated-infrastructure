terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"

    }
  }

}

provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "C:\\Users\\Asus\\.aws\\credentials"
  profile                 = "hamza"
}


data "aws_availability_zones" "available" {
  state = "available"
}


