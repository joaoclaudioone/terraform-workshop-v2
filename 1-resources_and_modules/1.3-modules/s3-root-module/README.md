# EC2 root module exercise

In this exercise, we will explore the concept of modules. The directory contains our root module, a simple configuration designed to pass parameters to a child module. The objective is to create instances with a basic security group configuration. Inside the child module, we will leverage data sources to retrieve necessary VPC information and the latest Amazon Linux AMI.

## Module Information

| File                | Description                                                   |
| ------------------- | ------------------------------------------------------------- |
| main.tf             | Root module configuration that sends parameters to the child module. |
| variables.tf        | Variable declarations for the root module.                     |
| outputs.tf          | Output declarations for the root module.                       |
| ../child_module/       | Directory containing the child module configurations.         |
|   ├── main.tf       | Child module configuration utilizing data sources.            |
|   ├── variables.tf  | Variable declarations for the child module.                    |
|   ├── outputs.tf    | Output declarations for the child module.                      |

## Generated Documentation

The tables with module information were generated using [terraform-docs](https://github.com/terraform-docs/terraform-docs), an open-source tool that reads the content of the directory and generates basic documentation.

## Instructions

1. Inspect the content of each file to understand the module configurations.
2. Proceed with the same steps as the previous exercise, applying Terraform commands to create and manage resources.

**Note:** Ensure that AWS credentials and access are configured before running the code.
For detailed information on Terraform concepts and commands, refer to the [Terraform documentation](https://www.terraform.io/docs/language/index.html).

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

## Modules

| Name | Source | Version |
|------|--------|---------|
| s3 | ../s3-child-module | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | Project Name. Will be used to name the resources | `string` | `"workshop-bucket"` | no |
| qtd_instances | Quantity of instances that will be created | `number` | `3` | no |
| region | AWS Region | `string` | `"eu-west-1"` | no |
| tags | Default tags for resources | `map` | ```{ "repository": "https://code.cocus.com/jcsilva/terraform-workshop", "terraform": "true" }``` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_arn | S3 bucket ARN |
