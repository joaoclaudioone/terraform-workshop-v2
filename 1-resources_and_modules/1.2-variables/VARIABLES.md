# Variables

Variables enable us to parameterize our code, enhancing its reusability. Values for variables can be assigned within a block, on the command line, within modules, or in configuration files.

Terraform provides two types of variables: Input and Output.

## Input

These variables serve as parameters for Terraform modules, enabling customization without the need for modifications to the module's source code. Terraform supports three variable types: string, number, and bool. Additionally, it provides support for complex data structures such as lists, sets, maps, objects, and tuples.

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

## Output

These are the values from the output of terraform apply. These values have multiple uses.

- Reference of resources created at a child module
- A report of the resource created after a `terraform apply`
- Return of the command `terraform output`
- Reuse these values when access a remote state. Example: We have one terraform module that creates a VPC and another module that query this data and use as parameter for resource creation.

```hcl
output "private_ip" {
  description = "Private ip of the instance"
  value = aws_instance.ec2_instance.private_ip
}
```

## Exercise

We will continue manipulating our S3 bucket creation code. We will use the same code, but now with variables. Input and output variables will be used.
In this exercise to help the understanding, we have some files. There is no rule of where to declare your variables, this could be done inside the same file. If you are using a *.tfvars file, this file needs to be a separated file from the*.tf files.

- s3_bucket_variables => This is the file where the resources and the provider could be found.
- variables.tf => Inside this file we have the input variables declaration.
- output.tf => And finally the output variables.
- terraform.tfvars => This file will set some input variable values

After inspecting the content of each file we can go through the same steps of the last exercise.

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
