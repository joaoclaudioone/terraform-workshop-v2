## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| s3 | ../s3-child-module | n/a |

## Resources

No resources.

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
