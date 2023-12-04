variable "aws_region" {
  default = "eu-west-1"
}

variable "policy_actions" {
  type    = list(string)
  default = ["s3:Get*", "s3:List*", "s3:Describe*", "s3-object-lambda:Get*", "s3-object-lambda:List*"]
}

variable "policy_effect" {
  default = "Allow"
}

variable "policy_resources" {
  type    = list(string)
  default = ["*"]
}

variable "policy_name" {
  default = ""
}
