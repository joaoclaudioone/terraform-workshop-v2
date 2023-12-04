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
  default     = "workshop-bucket"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-1"
}
