/*
Variables
*/
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
/*
  Here we have the region defined
*/

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}
/*
 This variable has no default value, this value will be received from other source.
 */

variable "acl" {
  description = "Bucket acl"
  type        = string
}