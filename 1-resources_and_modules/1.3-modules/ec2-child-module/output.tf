output "private_dns" {
  value       = aws_instance.ec2_instance.*.private_dns
  description = "List of private dns"
}

output "subnet_id" {
  value       = data.aws_subnets.subnet_id.ids
  description = "list of subnets"
}

output "ami" {
  value       = data.aws_ami.latest_ami.id
  description = "AMI Id"
}