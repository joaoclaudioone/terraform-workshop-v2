/*
 * Variables
 */
variable "tags" {
  description = "Default tags for resources"
  default = {
    terraform = "true"
  }
}

variable "project" {
  description = "Project Name. Will be used to name the resources"
  type        = string
}
/*
 * Here we have the region defined
 */

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "kms_description" {
  description = "The description of the key as viewed in AWS console."
  type        = string
  default     = "This key is used to encrypt bucket objects"
}

variable "kms_deletion_window" {
  description = "The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive."
  type        = number
  default     = 10
}

variable "kms_key_rotation" {
  description = "Specifies whether key rotation is enabled."
  type        = bool
  default     = true
}

variable "bucket_encription_algorithm" {
  description = "Server-side encryption algorithm to use. Valid values are AES256, aws:kms, and aws:kms:dsse"
  type        = string
  default     = "aws:kms"
}

variable "bucket_versioning" {
  description = "Bucket versioning parameter"
  type        = string
  default     = "Enabled"
}

variable "bucket_block_public_acl" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "bucket_block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "bucket_block_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "bucket_ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "logging_bucket_prefix" {
  description = "Prefix for all log object keys."
  type        = string
  default     = "log/"
}