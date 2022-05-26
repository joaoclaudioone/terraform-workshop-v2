# Resource
This is the most import element of the language. Each resource describe one or more objects from the infrastructure. 
A resource generate output values, that can be access making reference to block labels and the parameter. This is useful when we are creating complex infrastructures. T 
 
Example:
```
resource "aws_vpc" "my_vpc_base" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc_base.id
}
```

### Provider
Provider is the necessary structure where we define which cloud service we will use and every configuration for this provider. In this workshop we will only create AWS infrastructures. And we will assume that the credentials are located inside the aws configuration folder or inside environment variables. For safety reasons defining the access keys inside the code is not recommended. The parameters are optional

Example:
```
provider "aws" {
  version = "~> 2.0" 
  region  = "us-central-1"
}
``` 

version = version of the AWS framework
region = AWS region

It is a possibility to have more than one provider, even for the same service. For more details, check the documentation https://www.terraform.io/language/providers/configuration 

### Exercise 
In this example we will create a S3 bucket, demonstrating a simple usage. The mandatory steps are the `init` and the `apply`. All the others could be skipped, but I encourage you to try all the steps. 

- Inspect the code and then initialize the directory.
  ```shell  
  terraform init
  ```
- After that a useful command is `validate`. This command test the integrity of your code. 
   ````shell
  terrform validate
  ````
- If everything is fine you could create an execution plan.
  ```shell
   terraform plan
    ```
- Now we could apply the code using. Do not forget to confirm
  ````shell
   terraform apply
  ````
- After checking that your resource was created you could delete it. A confirmation is required
    ````shell
    terraform destroy
    ````
  
