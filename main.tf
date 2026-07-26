terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source = "./modules/ec2"

  count = var.instance_count

    ami_id        = var.ami_id
    instance_type = var.instance_type
    instance_name = "${var.instance_name}-${count.index + 1}"
    environment   = var.environment

}

module "s3" {
  source = "./modules/s3"

  for_each = var.bucket_names

  bucket_name = each.value
  environment = var.environment
}

 