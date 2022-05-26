# Resources and modules
The main objective of the language is the resource declaration. All other feature exists just to make this definition more convenient and flexible.
 
### Architecture 
Terraform architecture is made of two components 

- Terraform Core:
  - TF-Config: resources described by the user
  - State: state file of the infrastructure 
- Providers:
  - Are the configurations of the service provider where the infrastructure will be created (AWS, Azure, Google, etc...)

Terraform uses these components to define an execution plan of how the infrastructure will be created. It does that  comparing what was writen by the user (TF-Config) and comparing with the state file. From that point an execution plan is created with what has to be done (create, modify or destroy).

The providers will inform which resources could be created. For example, using AWS provider we could create EC2s, IAM users, S3 buckets etc. Terraform has many providers, and it is possible to write your own providers, in the case this was not listed. The complete list could be read on https://registry.terraform.io/browse/providers. 
 
### Syntax
The syntax consist in some basic elements: 

```hcl
resource "aws_vpc" "main" {
    cidr_block = var.base_cidr_block
}
```
```
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
    # Block body
    <IDENTIFIER> = <EXPRESSION> # Argument
}
```
* Block type is the type of resource structure that is being declared, **resource**, **module** and **provider** are some examples.
* Block label are the identifiers of what is being created. They are always declared using double quotes, the first is the resource that will be created. This is defined by the provider that was declared. Some examples of AWS provider: aws_instances and aws_vpc. The second is defined by the user, it will help to identify the resource that is being created. 
* Block body, inside the body we have the parameters required for the resource creation. The identifier is the name defined by the provider and expression are the arguments provided by the user.

### Code Organization 
The configuration files has the extension .tf. It is possible to use a json based format. https://www.terraform.io/docs/configuration/syntax-json.html

### Terraform State
Terraform stores the created infrastructure inside a file called `terraform.tfstate`. The default is to store this file at the local disk, but it is strong recommended that this file be stored remotely. This file is create/updated at each terraform execution. 

We could open anc check the state, but manual changes are not recommended. 
