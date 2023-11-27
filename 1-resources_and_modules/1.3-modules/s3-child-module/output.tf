/*
Outputs
The outputs values are provided by the values that the module use.
*/
output "bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.workshop_s3_bucket.arn
}
