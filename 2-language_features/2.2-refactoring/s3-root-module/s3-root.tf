provider "aws" {
  region = var.region
  default_tags {
    tags = var.tags
  }
}

/*
 * Creating multiple buckets with for_each
 * 
 */
module "s3" {
  source = "../s3-child-module"

  for_each = { for config in var.s3_buckets : config.project => config }

  project = each.value.project
  region  = var.region
}