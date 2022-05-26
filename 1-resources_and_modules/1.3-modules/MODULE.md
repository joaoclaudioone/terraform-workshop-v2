# Code reuse
In this section we will check the concept of modules, remote state and data souces. 

## Module
For terraform module is a directory that creates some resources.

Every terraform configuration has at least one module, which will be called **root module**. These are the resources created with tf files stored in the current directory. 
 
A module can execute another modules, with that we can include child modules in the configuration. Modules also can be executed multiple times, with the same oor different configuration. This allows that resources could be package and reused. 

https://www.terraform.io/language/modules

### Running a module
The structure modules allows the execution of another modules. here the block label identifies the local module, this is defined by the user. The parameter source is required and will inform where are the other module. The rest of the parameter are the input variables of the child module.  

```hcl
module "servers" {
  source = "./app-cluster"
 
  servers = 5
}
```
A child module could be located at the local file system, terraform registry, github, bitbucket, http url or some cloud bucket (S3, GCP).

The returns of a child module are encapsulated, and if we want  to access these returns it is necessary to declare output variables. 

## Remote State
The default location of terraform state file is the local disk. But if we need to share, store and consume output variables, existe an option to set a remote storage for the remote state file. This file could be stored at Terrafomr Cloud, Consul, S3, Alibaba Cloud and other places.

```hcl
terraform {
    backend "s3" {
        region = "us-east-1"
        bucket = "terraform-workshop"
        key = "states/2_1_remote_state.tfstate"
    }
}
```

### Initialization
When a backend is defined, this is the first initialized structure. Terraform will not load variables declared inside the modules, but there are some ways for set these values.
* Interactively: terraform will ask for the values
* File: configuration file can be set with the `init`, this format is a key=value format. E.g.: `terraform init -backend-config=PATH`
* Command line: the values can b defined with this format: `terraform init -backend-config="KEY=VALUE"`
* Hardcoded: the kind of configuration used in this example.

## Data source
This is a structure that allows us to search information that could be used inside terraform configuration. We could use information of sources outside terraform or generated with another configurations.

Here an example of how to get information about the latest version of an AMI

```hcl
data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners = ["amazon"]

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
 }
}
```

## Exercise
In this exercise we will check the concept of module. We have a root module, where our parameters will be set and a child module that will receive all the parameters 