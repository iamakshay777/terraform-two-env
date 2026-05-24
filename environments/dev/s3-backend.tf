# ============================================================================
#  DEV state backend infra - S3 bucket + DynamoDB lock table
# ============================================================================
#  Created ONCE with local state (Phase 1).
#  After this is applied, uncomment backend.tf and run:
#      terraform init -migrate-state
# ============================================================================

module "state_bucket" {
  source = "../../modules/s3"

  bucket_name = "akshay-tfstate-dev"
  environment = "dev"
}

resource "aws_dynamodb_table" "lock" {
  name         = "terraform-state-lock-dev"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = "dev"
    Purpose     = "terraform-state-lock"
  }
}
