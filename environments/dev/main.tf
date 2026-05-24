# ============================================================================
#  DEV environment — calls the ec2 module with dev-specific inputs
# ============================================================================

module "ec2" {
  source = "../../modules/ec2"

  environment   = var.environment
  ami_id        = var.ami_id
  instance_type = var.instance_type
}

# ─── Outputs ────────────────────────────────────────────────────────────────

output "web_url" {
  description = "Open this in your browser after apply"
  value       = "http://${module.ec2.public_ip}"
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}
