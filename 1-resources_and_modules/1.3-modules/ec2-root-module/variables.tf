variable "tags" {
  description = "Default tags for resources"
  default = {
    terraform  = "true"
    repository = "https://code.cocus.com/jcsilva/terraform-workshop"
  }
}

variable "project" {
  description = "Project Name. Will be used to name the resources"
  type        = string
  default     = "workshop"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "PORSCHE-HYDRA-DEV V1"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}

variable "qtd_instances" {
  description = "Quantity of instances that will be created"
  type        = number
  default     = 3
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "ingress_list" {
  description = "Rules for the security group creation"
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}