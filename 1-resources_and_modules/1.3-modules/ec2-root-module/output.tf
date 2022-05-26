output "ami" {
  description = "AMI Id"
  value       = module.ec2.ami
}

output "private_dns" {
  description = "Instance private DNS"
  value       = module.ec2.private_dns
}