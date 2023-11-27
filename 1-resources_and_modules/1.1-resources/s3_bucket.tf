/*
 * This is the provider section. We can see some parameters as example. All parameters are optional.
 */
provider "aws" {
  # The region where your infrastructure will be created. In the next exercise we will see how to add some variables here
  region = "eu-central-1"
  # This provide some default tags for each resource. This could save some work and defining global tags.
  default_tags {
    tags = {
      Project    = "Terraform workshop",
      Terraform  = "True",
      One        = "Two",
      Repository = "https://code.cocus.com/jcsilva/terraform-workshop"
    }
  }
}

/*
 * Provides a S3 bucket resource.
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
 */
resource "aws_s3_bucket" "workshop_s3_bucket" {
  # bucket_prefix will be useful if you do not want to be worried if the bucket name already exist. But it is possible to use bucket_name instead.
  bucket_prefix = "workshop-bucket"
}

/*
 * Manages a single-Region or multi-Region primary KMS key.
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key
 */
resource "aws_kms_key" "workshop_kms_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}
/*
 * Provides a S3 bucket server-side encryption configuration resource.
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
 */
resource "aws_s3_bucket_server_side_encryption_configuration" "workshop_bucket_encryption" {
  bucket = aws_s3_bucket.workshop_s3_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.workshop_kms_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

/*
 * Provides a resource for controlling versioning on an S3 bucket. 
 * Deleting this resource will either suspend versioning on the associated S3 bucket  
 * or simply remove the resource from Terraform state if the associated S3 bucket is unversioned.
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
 */
resource "aws_s3_bucket_versioning" "workshop_bucket_versioning" {
  bucket = aws_s3_bucket.workshop_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
/*
 * Manages S3 bucket-level Public Access Block configuration.
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
 */
resource "aws_s3_bucket_public_access_block" "workshop_block_public_access" {
  bucket                  = aws_s3_bucket.workshop_s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}
/*
 * Provides an S3 bucket (server access) logging resource. 
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging
 */
resource "aws_s3_bucket_logging" "example" {
  bucket        = aws_s3_bucket.workshop_s3_bucket.id
  target_bucket = aws_s3_bucket.workshop_s3_bucket.id # Writes logs in the same bucket it is not a good practice. :(
  target_prefix = "log/"
}