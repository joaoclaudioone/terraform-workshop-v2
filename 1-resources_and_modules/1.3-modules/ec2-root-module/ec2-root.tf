provider "aws" {
  region = var.region
  default_tags {
    tags = var.tags
  }
}

module "ec2" {
  source = "../ec2-child-module"

  qtd_instances = var.qtd_instances
  project       = var.project
  instance_type = var.instance_type
  ingress_list  = var.ingress_list
  vpc_name      = var.vpc_name
}
