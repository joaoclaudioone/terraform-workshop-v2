# Organize your code

Terraform is a powerful tool for defining and managing infrastructure as code (IaC). When working in a collaborative environment with professionals of varying skills and responsibilities, it's crucial to organize Terraform code in a way that fosters collaboration, reusability, and maintainability.

## Modules

Leverage Terraform modules to encapsulate and abstract specific functionalities. Modules allow infrastructure teams to define reusable components that encapsulate best practices and share them with other teams.

### What makes a Good Module?

1. **Modularity:** Modules can range from large to small, but it's crucial that each module abstracts underlying resources, promoting encapsulation.

2. **Input Customization:** Expose input variables to facilitate customization, allowing users to tailor the module to specific requirements.

3. **Defaults for Convenience:** Provide thoughtful default values for input variables, enhancing user experience by minimizing the need for extensive customization.

4. **Output Integration:** Return outputs from the module to enable seamless integration with other components, fostering extensibility and interoperability.

## Variable Definitions

Use variable definitions to parameterize your configurations. Clearly document variables and their purposes to facilitate collaboration among team members.

```hcl
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
```

## Different environments

There are two different approaches to deal with that. One is using terraform workspaces and another is organizing using directory structure.

### Terraform workspaces

Terraform starts with a single, default workspace named default that you cannot delete. If you have not created a new workspace, you are using the default workspace in your Terraform working directory.

When you run terraform plan in a new workspace, Terraform does not access existing resources in other workspaces. These resources still physically exist, but you must switch workspaces to manage them.

To create a new environment we need to execute the command `terraform workspace new <environment_name>`. This is create and change the new environment. To select an existing environment `terraform workspace select <environment_name>`.

Here an example of bucket creation in different environments.

```hcl
# Define a variable representing environments
variable "environments" {
  type    = map
  default = {
    prod = { region = "us-east-1", bucket_name = "prod-bucket" }
    dev  = { region = "us-west-2", bucket_name = "dev-bucket" }
  }
}


provider "aws" {
  region = var.environments[terraform.workspace].region
}

resource "aws_s3_bucket" "example" {
  bucket = var.environments[terraform.workspace].bucket_name
}
```

| Pros                | Cons                    |
|:-------------------:|:-----------------------:|
| Easy to get started | Prone to human error |
| Convenient `terraform.workspace` expression | State stored within same backend |
| Minimizes code duplication | Codebase doesn't show deployment configurations |

### File structure

Another option is organize your code using a file structure. In this solution we have the environments in each folder with their variables.

```tree
├── environments
│   ├── dev
|   |   ├── main.tf
│   |   └── variables.tf
│   ├── staging
|   |   ├── main.tf
│   |   └── variables.tf
│   └── prod
|       ├── main.tf
│       └── variables.tf
└── modules
    ├── module-1
    |   ├── main.tf
    |   └── variables.tf
    └── module-2
        ├── main.tf
        └── variables.tf
```

| Pros                | Cons                    |
|:-------------------:|:-----------------------:|
| Backend isolation | More code duplication |
| Codebase fully represents deployed state | Multiple terraform apply |

## Documentation

Include comprehensive documentation, README files, and inline comments. Clearly explain the purpose, usage, and variables of each module and environment. This helps bridge the knowledge gap between different teams.

A helpful tool is [terraform-docs](https://terraform-docs.io/). This tool will read your module and create a documentation with the variables, resources and providers defined in your code.

## Version Control

Use a version control system (e.g., Git) to track changes, collaborate effectively, and manage the evolution of your infrastructure code. Specify a fixed version for your modules to mitigate compatibility issues.

```hcl
module "example" {
  source = "git::https://github.com/example/module.git?ref=v1.2.3"
  # other module configurations...
}
```
