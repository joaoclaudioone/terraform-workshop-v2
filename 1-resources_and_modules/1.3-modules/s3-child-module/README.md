# S3 child module

This Terraform configuration sets up an AWS S3 bucket and associated resources. It's part of a workshop exercise and illustrates key Terraform concepts, including modules, provider configuration, resources, and data sources. The configuration is designed for customization through input variables, providing flexibility and demonstrating best practices in Terraform usage. Please ensure AWS credentials and access are configured before running this code. For detailed information on Terraform functions and resources, refer to the [Terraform documentation](https://www.terraform.io/docs/language/index.html).

## Provider Section

The AWS provider is defined with optional parameters, including the region where infrastructure
will be created. It also demonstrates the use of default tags for resources.

## Resources[^1]

Each resource allows customization through input variables, providing flexibility in configuration.
Documentation links are included for further reference.

| Name | Type |
|------|------|
| [aws_kms_key.workshop_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.workshop_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_logging.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_policy.s3_policy_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.workshop_block_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.workshop_bucket_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.workshop_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_block_public_acl | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `true` | no |
| bucket_block_public_buckets | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `true` | no |
| bucket_block_public_policy | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `true` | no |
| bucket_encription_algorithm | Server-side encryption algorithm to use. Valid values are AES256, aws:kms, and aws:kms:dsse | `string` | `"aws:kms"` | no |
| bucket_ignore_public_acls | Whether Amazon S3 should ignore public ACLs for this bucket. | `bool` | `true` | no |
| bucket_versioning | Bucket versioning parameter | `string` | `"Enabled"` | no |
| kms_deletion_window | The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. | `number` | `10` | no |
| kms_description | The description of the key as viewed in AWS console. | `string` | `"This key is used to encrypt bucket objects"` | no |
| kms_key_rotation | Specifies whether key rotation is enabled. | `bool` | `true` | no |
| logging_bucket_prefix | Prefix for all log object keys. | `string` | `"log/"` | no |
| project | Project Name. Will be used to name the resources | `string` | n/a | yes |
| region | AWS Region | `string` | n/a | yes |
| tags | Default tags for resources | `map` | ```{ "terraform": "true" }``` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_arn | S3 bucket ARN |

***
[^1]: Documentation created with terraform-docs: <https://github.com/terraform-docs/terraform-docs>
