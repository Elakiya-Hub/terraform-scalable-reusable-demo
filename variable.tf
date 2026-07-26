variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 3
}

variable "instance_name" {
  description = "Base name for the EC2 instances"
  type        = string
  default     = "web-server"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t3.micro"
  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "Invalid instance type. Allowed values are: t3.micro, t3.small, t3.medium."
  }
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-004f790b835b26145" 
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Invalid environment. Allowed values are: dev, staging, prod."
  }
}

variable "bucket_names" {
  description = "Names of S3 buckets"

  type = set(string)

  default = [
    "elakiya-devops-demo-001",
    "elakiya-devops-demo-002",
    "elakiya-devops-demo-003"
  ]
}

variable "ingress_ports" {
  description = "List of ports to allow"
  type        = list(number)

  default = [
    22,
    80,
    443,
    8080
  ]
}