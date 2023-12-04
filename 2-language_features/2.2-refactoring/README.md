# S3 bucket

Do you think that we could refactor the code that was presented in the [Modules chapter](../../1-resources_and_modules/1.3-modules/MODULE.md)?
What changes could be done? Below just an example of one of the improvements that could be done.

<details>
  <summary>Answer</summary>

```hcl
# Define a list of S3 bucket configurations
variable "s3_buckets" {
  type = list(object({}))
  default = [
    {
      project = "bucket1"
      region  = "us-east-1"

    },
    {
      project = "bucket2"
      region  = "us-west-2"
    }
  ]
}

# Create S3 buckets dynamically

module "s3" {
  source = "../s3-child-module"

  for_each = { for config in var.s3_buckets : config.project => config }

  project = each.value.project
  region  = each.value.region
}

# output.tf
output "s3_bucket_ids" {
  value = [for bucket_config in var.s3_buckets : module.s3[bucket_config.project].s3_bucket_id]
}
```
</details>