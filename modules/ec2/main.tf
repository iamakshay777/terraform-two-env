# ============================================================================
#  Module: ec2
# ============================================================================
#  Self-contained EC2 module. Uses the account's DEFAULT VPC + a default
#  subnet so callers don't have to pass vpc_id / subnet_id. Great for demos
#  and small projects; for prod you'd usually pass an explicit VPC + subnet.
#
#  NOTE: This module does NOT create or use any SSH key. The instance is
#  reachable on HTTP (port 80) only. To access the OS, use AWS Systems
#  Manager Session Manager or the EC2 Instance Connect console.
# ============================================================================

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "this" {
  name        = "${var.environment}-web-sg"
  description = "Web SG for ${var.environment} - HTTP only"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-web-sg"
    Environment = var.environment
  }
}

resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx
              echo "<h1>Hello from ${var.environment}!</h1>" > /var/www/html/index.html
              systemctl restart nginx
              EOF

  tags = {
    Name        = "${var.environment}-web"
    Environment = var.environment
  }
}
