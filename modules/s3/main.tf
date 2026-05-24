# ============================================================================
#  Module: s3 (minimal)
# ============================================================================
#  Creates: an S3 bucket with versioning enabled. Nothing else.
#  Intended use: storing Terraform remote state.
# ============================================================================

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  # DEMO ONLY: lets `terraform destroy` wipe the bucket even if it contains
  # state versions. Remove this in real prod use.
  force_destroy = true

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Purpose     = "terraform-state"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}
