/*
Outputs
The outputs values are provided by the values that the module use.
*/
output "bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.my_s3_bucket.arn
}

output "bucket_acl" {
  description = "S3 bucket ACL"
  value       = aws_s3_bucket_acl.my_bucket_acl.acl
}

output "aws_region" {
  description = "The AWS region used for the resource creation"
  value = var.region
}