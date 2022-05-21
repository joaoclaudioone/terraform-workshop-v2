/*
 * This is the provider section. We can see some parameters as example. All parameters are optional.
 */
provider "aws" {
  # The region where your infrastructure will be created. Th
  region = var.region
  # This provide some default tags for each resource. This could save some work and defining global tags.
  default_tags {
    /*
     Here we have merge that is a terraform function. Terraform has some function, that helps us to achieve some goals.
     Merge is a function that receives N of maps of objects and return a single map with a set of elements.
     The goal here is create a map of objects from the variable tags with the map {Name = var.project}.
     Here the result will be a map with this format
     {
        terraform  = "true"
        repository = "https://code.cocus.com/jcsilva/terraform-workshop"
        Name       = "workshop-bucket"
     }
     https://www.terraform.io/language/functions/merge
    */
    tags = merge(var.tags, {
      Name = var.project
    }, )
  }
}

/*
  This resource will create the s3 bucket
  Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
 */
resource "aws_s3_bucket" "my_s3_bucket" {
  # bucket_prefix will be useful if you do not want to be worried if the bucket name already exist. But it is possible to use bucket_name instead.
  bucket_prefix = var.project
}

/*
  Securing the bucket with an acl. Noticed that the parameter bucket will have the value of the bucket label and the parameter id.
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
 */
resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  acl    = var.acl
}