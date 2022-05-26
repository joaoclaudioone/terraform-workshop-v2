# terraform-workshop
The main objective of this repository is to provide an introduction to Terraform. Inside each folder have some exercises that show some basic concepts.
### Prerequisites
- Terraform 1.1.8
- An AWS account with permission to create some resources. 
### Installation
Terraform could be installed on Windows or Unix like systems, at the official page you could find detailed instructions for each operational system. https://www.terraform.io/downloads

### Introduction
Terraform is an open source tool that allows us to create and manage infrastructure, services platforms and services running into a platforms. 

Terraform uses a declarative language, this means that the user has to describe to objective and terraform will create an execution plan to reach this objective. It is different from an imperative language, where the user has to describe all the steps to reach the final objective.

### Usage
You do not need to take note of these commands now, they will be repeated later. 
The first step before we create anything is to run the command `terraform init`. This command will initialize the code inside the directory. After that we could run see the execution plan of terraform using `terraform plan`. This command does not check the existing infrastructure, it will only list the changes. 
And finally we could apply our code using `terraform apply`. This will start the creation process of our infrastructure. Another option is to destroy all the infrastructure that was created with `terraform destroy`. 

These are the basic commands, we have more advanced commands that could che checked here https://www.terraform.io/cli/commands 

### Index
[1 - Resources and modules](./1-resources_and_modules/README.md)
 
> [1.1 - Resources](./1-resources_and_modules/1.1-resources/RESOURCES.md)
 
> [1.2 - Variables](1-resources_and_modules/1.2-variables/VARIABLES.md)
 
> [1.3 - Module](./1-resources_and_modules/1.3-modules/MODULE.md)

