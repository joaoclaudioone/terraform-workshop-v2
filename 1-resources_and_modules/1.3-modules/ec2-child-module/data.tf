/*
  This data source will return the VPC information, for that will use a filter with the tag:Name and value.
  For this use case we are only interested in the VPC ID.
  Remember that data sources are information structures. They will not create or delete anything.
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
 */
data "aws_vpc" "main" {
  state = "available"

  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}
/*
  This data source will return a list of all the subnets of the VPC.
  For that it will receive the vpc-id from the data source aws_vpc.main.
  When we need to make a reference to a data source, we must add data before the resource label.
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets
 */
data "aws_subnets" "subnet_id" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}
/*
  This data source will return the latest AMI from the received parameters.
  The parameters are a list of the AMI owner and the AMI name.
  The AMI name could contain wildcards like * and ?
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
 */
data "aws_ami" "latest_ami" {
  most_recent = true
  owners      = var.query_ami.owners

  filter {
    name   = "name"
    values = var.query_ami.name
  }
}