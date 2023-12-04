// This section will define a default bucket policy.

/*
 * Use this data source to get the access to the effective Account ID, User ID, and ARN in which Terraform is authorized.
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
 */
data "aws_caller_identity" "current" {}

/*
 * Attaches a policy to an S3 bucket resource.
 * Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
 */
resource "aws_s3_bucket_policy" "s3_policy_default" {
  bucket = aws_s3_bucket.workshop_s3_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowAllS3Actions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.id}:root"
        }
        Action = ["s3:*"]
        Resource = [
          "${aws_s3_bucket.workshop_s3_bucket.arn}/*",
          "${aws_s3_bucket.workshop_s3_bucket.arn}"
        ]
      }
    ]
  })
}

