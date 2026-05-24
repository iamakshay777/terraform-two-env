variable "environment" {
  description = "Environment name (dev / prod)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID (region-specific). Ubuntu 22.04 us-east-1 = ami-0c7217cdde317cfec"
  type        = string
}

variable "instance_type" {
  description = "EC2 size (t2.micro / t3.small etc.)"
  type        = string
  default     = "t2.micro"
}
