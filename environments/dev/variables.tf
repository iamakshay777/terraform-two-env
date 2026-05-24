variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "ami_id" {
  description = "AMI ID for the EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 size"
  type        = string
  default     = "t2.micro"
}
