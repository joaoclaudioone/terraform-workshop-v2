variable "project" {
  description = "Project Name. Will be used to name the resources"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.large"
}

variable "public_key" {
  description = "Public key path"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "qtd_instances" {
  description = "Quantity of instances that will be created"
  type        = number
  default     = 1
}

variable "ingress_list" {
  description = "Default rules for security group ingress"
  type        = list(any)
}

variable "egress_list" {
  description = "Default rules for security group egress"
  type        = list(any)
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "query_ami" {
  description = "Default values for the latest Amazon Linux 2 AMI"
  type        = map(any)
  default = {
    owners = ["amazon", "801119661308"]
    name   = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
}

variable "vpc_name" {
  description = "VPC Name"
}