/*
Variaveis
*/
variable "tags" {
  description = "Default tags for resources"
  default = {
    terraform      = "true"
    repository    = "https://code.cocus.com/jcsilva/terraform-workshop"
  }
}

variable "project" {
    description = "Name of the project"
    type        = string
    default     = "Workshop"
}

variable "region" {
    description = "AWS Region"
    type        = string
    default     = "eu-central-1"
}

variable "acl" {
    description = "Bucket acl"
    type = string
}