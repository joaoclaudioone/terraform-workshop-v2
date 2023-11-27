# Resources and Modules

The primary purpose of the language is resource declaration. All other features exist to enhance the convenience and flexibility of this definition.

## Architecture

Terraform architecture is made of two components

- Terraform Core:
  - TF-Config: resources described by the user
  - State: state file of the infrastructure
- Providers:
  - Are the configurations of the service provider where the infrastructure will be created (AWS, Azure, Google, etc...)

Terraform utilizes these components to formulate an execution plan for creating the infrastructure. It achieves this by comparing what the user has written in the TF-Config with the state file. Subsequently, an execution plan is generated outlining the necessary actions, such as creating, modifying, or destroying resources.

The providers will inform which resources could be created. For example, using AWS provider we could create EC2s, IAM users, S3 buckets etc. Terraform has many providers, and it is possible to write your own providers, in the case this was not listed. The complete list could be read on [Terraform Providers](https://registry.terraform.io/browse/providers).

## Syntax

The syntax consist in some basic elements:

```hcl
resource "aws_vpc" "main" {
    cidr_block = var.base_cidr_block
}
```

```hcl
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
    # Block body
    <IDENTIFIER> = <EXPRESSION> # Argument
}
```

- Block type is the type of resource structure that is being declared, **resource**, **module** and **provider** are some examples.
- Block label are the identifiers of what is being created. They are always declared using double quotes, the first is the resource that will be created. This is defined by the provider that was declared. Some examples of AWS provider: aws_instances and aws_vpc. The second is defined by the user, it will help to identify the resource that is being created.
- Block body, inside the body we have the parameters required for the resource creation. The identifier is the name defined by the provider and expression are the arguments provided by the user.

### Code Organization

The configuration files have the extension .tf, and it is also possible to use a JSON-based format. More information about the JSON format can be found at [Json configuration syntax](https://www.terraform.io/docs/configuration/syntax-json.html).

### Terraform State

Terraform stores the created infrastructure in a file called `terraform.tfstate`. By default, this file is stored on the local disk, but it is strongly recommended to store it remotely. This file is created or updated with each Terraform execution.

While it is possible to open and inspect the state, manual changes are not recommended. Making direct edits to the state file can lead to inconsistencies and issues in managing the infrastructure. It's best to use Terraform commands for any changes to ensure proper tracking and synchronization.
