# Define a variable representing environments
variable "environments" {
  type    = map
  default = {
    prod = { region = "us-east-1", bucket_name = "prod-bucket" }
    dev  = { region = "us-west-2", bucket_name = "dev-bucket" }
  }
}


provider "aws" {
  region = var.environments[terraform.workspace].region
}

resource "aws_s3_bucket" "example" {
  bucket = var.environments[terraform.workspace].bucket_name
}

