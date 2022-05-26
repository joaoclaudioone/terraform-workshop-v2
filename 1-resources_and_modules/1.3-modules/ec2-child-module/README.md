# EC2 child module
This module creates EC2 instances with security group. This is module has just an educational objective and this is not a productive terraform module. 

This module has the following file structure: 
- data.tf = contains all data sources used for this module
- ec2-module.tf = resource configuration file
- output.tf = output variables of the module
- variables.tf = input variables of the module

Bellow has the list of the resources, variables and outputs. 

## Resources

| Name | Type |
|------|------|
| [aws_instance.ec2_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.sg_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.latest_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnets.subnet_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| egress_list | Default rules for security group egress | `list(any)` | ```[ { "cidr_blocks": [ "0.0.0.0/0" ], "from_port": 0, "protocol": -1, "to_port": 0 } ]``` | no |
| ingress_list | Default riles for security group ingress | `list(any)` | n/a | yes |
| instance_type | Instance type | `string` | `"t3.large"` | no |
| project | Project Name. Will be used to name the resources | `string` | n/a | yes |
| public_key | Public key path | `string` | `"~/.ssh/id_rsa.pub"` | no |
| qtd_instances | Quantity of instances that will be created | `number` | `1` | no |
| query_ami | Default values for the latest Amazon Linux 2 AMI | `map(any)` | ```{ "name": [ "amzn2-ami-hvm-2.0.*-x86_64-gp2" ], "owners": [ "amazon", "801119661308" ] }``` | no |
| vpc_name | VPC Name | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ami | AMI Id |
| private_dns | List of private dns |
| subnet_id | list of subnets |


###### Documentation created with terraform-docs: https://github.com/terraform-docs/terraform-docs