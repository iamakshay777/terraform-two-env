# ============================================================================
#  PROD remote state backend - DO NOT enable until Phase 1 is applied
# ============================================================================
#  Phase 1: keep this block commented. Run `terraform apply` with LOCAL state
#           to create the S3 bucket + DynamoDB lock table from s3-backend.tf.
#
#  Phase 2: uncomment the block below, then run:
#               terraform init -migrate-state
#           Answer "yes" to copy your local terraform.tfstate up to S3.
#
#  IMPORTANT: backend "s3" config CANNOT reference variables. Bucket and
#  table names must be HARD-CODED strings.
# ============================================================================

# terraform {
#   backend "s3" {
#     bucket         = "akshay-tfstate-prod"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-state-lock-prod"
#     encrypt        = true
#   }
# }
