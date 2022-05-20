# Variables
Variables allow us to parametrize out code, and having the code more reusable. The values could be assigned as a command block, command lone, modules and configuration files. 

Exist two types of variables: input and output
 
### Input
These variables are used as parameters for terraform modules, this allow that these modules coudl be customized withoud changed the source code of the module.

Terraform has support for three variable type: string, number and bool. And also support structures as list, set, map, object and tuple. 
 
```hcl
variable "ami_id" {
   description = "Amazon Linux 2 from region us-east-1"
   type = string
   default = "ami-09d95fab7fff3776c"
}
```
Terraform loads the variables using that order, the last variables overrides the first one. 

- Environment variables
- file `terraform.tfvars`
- file `terraform.tfvars.json`
- any file `*.auto.tfvars` or *.auto.tfvars.json` in alphabetical order.
- The options -var e -var-file from command line
 
### Output

These are the values from the output of terraform apply. These values have multiple uses. 

- Reference of resources created at a child module
- A report of the resource created after a `terraform apply`
- Return of the command `terraform output`
- Reuse these values when access a remote state. Example: We have a terraform module that creates a VPC and another module that query this data ant use as parameter for resource creation. 

```hcl
output "private_ip" {
  description = "Ip privado da instância"
  value = aws_instance.ec2_instance.private_ip
}
```

### Exercise
We will continue manipulating our S3 bucket creation code. 