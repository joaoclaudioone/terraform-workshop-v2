# EC2 root module
In this exercise we will start the concept of module. Inside this directory we have our root module. This is a simple configuration that will send parameters to the child module. The objective is to create some simple instances with a basic security group configuration. Inside the child module we will take advantage of the data source structure, this data sources will get for the necessary VPC information and the latest Amazon Linux AMI. 

The tables with the information module information was generated using terraform-docs. This is an open source tool that read the content of the directory and generate a basic document. https://github.com/terraform-docs/terraform-docs

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

## Modules

| Name | Source | Version |
|------|--------|---------|
| ec2 | ../s3-child-module | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ingress_list | Rules for the security group creation | `list` | ```[ { "cidr_blocks": [ "0.0.0.0/0" ], "from_port": 22, "protocol": "tcp", "to_port": 22 }, { "cidr_blocks": [ "0.0.0.0/0" ], "from_port": 8080, "protocol": "tcp", "to_port": 8080 } ]``` | no |
| instance_type | Instance type | `string` | `"t3.micro"` | no |
| project | Project Name. Will be used to name the resources | `string` | `"workshop"` | no |
| qtd_instances | Quantity of instances that will be created | `number` | `3` | no |
| region | AWS Region | `string` | `"eu-central-1"` | no |
| tags | Default tags for resources | `map` | ```{ "repository": "https://code.cocus.com/jcsilva/terraform-workshop", "terraform": "true" }``` | no |
| vpc_name | VPC Name | `string` | `"PORSCHE-HYDRA-DEV V1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ami | AMI Id |
| private_dns | Instance private DNS |