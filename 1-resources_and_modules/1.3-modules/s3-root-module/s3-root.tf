provider "aws" {
  region = var.region
  default_tags {
    tags = var.tags
  }
}

module "s3" {
  source = "../s3-child-module"

  project = var.project
  region  = var.region
}
