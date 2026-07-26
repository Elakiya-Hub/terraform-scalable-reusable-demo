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

resource "aws_security_group" "web_sg" {

  name        = "web-security-group"
  description = "Security Group for EC2 instances"

  dynamic "ingress" {

    for_each = var.ingress_ports

    content {

      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }

  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name        = "web-security-group"
    Environment = var.environment

  }

} 