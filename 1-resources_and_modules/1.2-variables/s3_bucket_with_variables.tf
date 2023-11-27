/*
 * This is the provider section. We can see some parameters as example. All parameters are optional.
 */
provider "aws" {
  # The region where your infrastructure will be created. Th
  region = var.region
  # This provide some default tags for each resource. This could save some work and defining global tags.
  default_tags {
    /*
     Here we have merge that is a terraform function. Terraform has some function, that helps us to achieve some goals.
     Merge is a function that receives N of maps of objects and return a single map with a set of elements.
     The goal here is create a map of objects from the variable tags with the map {Name = var.project}.
     Here the result will be a map with this format
     {
        terraform  = "true"
        repository = "https://code.cocus.com/jcsilva/terraform-workshop"
        Name       = "workshop-bucket"
     }
     https://www.terraform.io/language/functions/merge
    */
    tags = merge(var.tags, {
      Name = var.project
    }, )
  }
}

/*
  This resource will create the s3 bucket
  Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
 */
resource "aws_s3_bucket" "workshop_s3_bucket" {
  # bucket_prefix will be useful if you do not want to be worried if the bucket name already exist. But it is possible to use bucket_name instead.
  bucket_prefix = var.project
}

/*
 * Manages a single-Region or multi-Region primary KMS key.
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key
 */
resource "aws_kms_key" "workshop_kms_key" {
  description             = var.kms_description
  deletion_window_in_days = var.kms_deletion_window
  enable_key_rotation     = var.kms_key_rotation
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
      sse_algorithm     = var.bucket_encription_algorithm
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
    status = var.bucket_versioning
  }
}
/*
 * Manages S3 bucket-level Public Access Block configuration.
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
 */
resource "aws_s3_bucket_public_access_block" "workshop_block_public_access" {
  bucket                  = aws_s3_bucket.workshop_s3_bucket.id
  block_public_acls       = var.bucket_block_public_acl
  block_public_policy     = var.bucket_block_public_policy
  restrict_public_buckets = var.bucket_block_public_buckets
  ignore_public_acls      = var.bucket_ignore_public_acls
}
/*
 * Provides an S3 bucket (server access) logging resource. 
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging
 */
resource "aws_s3_bucket_logging" "workshop_logging" {
  bucket        = aws_s3_bucket.workshop_s3_bucket.id
  target_bucket = aws_s3_bucket.workshop_s3_bucket.id # Writes logs in the same bucket it is not a good practice. :(
  target_prefix = var.logging_bucket_prefix
}