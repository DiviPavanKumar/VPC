terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
  }
  backend "s3" {
    bucket = "remote-state-file-practice"
    key    = "VPC-Demo"
    region = "us-east-1"
    dynamodb_table = "remote-state-file-lock"
    # apply-lock = false
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  default_tags {
    tags = {
            Environment = "Testing"
            By = "Pavan Kumar Divi"
            Source = "Terraform"
            Project_Name = "VPC_DEMO"
        }
    }
  }