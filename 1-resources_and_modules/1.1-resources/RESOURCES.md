# Resource

This is the most important element of the language. Each resource describes one or more objects in the infrastructure. A resource generates output values that can be accessed by referencing block labels and parameters. This functionality proves especially useful when creating complex infrastructures.

Example:

```hcl
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket_prefix = "workshop-bucket"
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  acl    = "private"
}
```

## Provider

The provider is a crucial structure where we specify the cloud service to be used along with its configurations. In this workshop, we will exclusively create AWS infrastructures, assuming that the credentials are either located inside the AWS configuration folder or within environment variables. For security reasons, it is not recommended to define access keys directly within the code. Note that these parameters are optional.

Example:

```hcl
provider "aws" {
  version = "~> 2.0" 
  region  = "us-central-1"
}
```

version = version of the AWS framework
region = AWS region

It is a possibility to have more than one provider, even for the same service. For more details, check the [documentation](https://www.terraform.io/language/providers/configuration).

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
