/*
 * This is the provider section. We can seed some parameters as example. All parameters are optional.
 */
provider "aws" {
  # The region where your infrastructure will be created. In the next exercise we will see how to add some variables here
  region = "eu-central-1"
  # This provide some default tags for each resource. This could save some work and defining global tags.
    default_tags {
      tags = merge(var.tags, {
        Name        = var.project
      },)
    }
}

/*
 * This resource will create the s3 bucket
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
 */
resource "aws_s3_bucket" "my_s3_bucket" {
  # bucket_prefix will be useful if you do not want to be worried if the bucket name already exist. But it is possible to use bucket_name instead.
  bucket_prefix = var.project
}

/*
 * Securing the bucket with an acl. Noticed that the parameter bucket will have the value of the bucket label and the parameter id.
 * https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
 */
resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  acl    = "private"
}