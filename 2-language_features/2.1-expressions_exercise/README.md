# Expressions Exercise

In this exercise we are going to create some simple functions to validate our code.

## Conditional

In this configuration, we want to make sure that the variable `policy-name` is not empty. Create a condition that set a default name for this case.

<details>
  <summary>Answer</summary>

### This resource will generate a random id to be used as the policy_name

```hcl
resource "random_id" "id" {
  byte_length = 8
}

resource "aws_iam_policy" "workshop_policy" {
  name   = (var.policy-name != "" ? var.policy-name : random_id.id.hex)
  policy = data.aws_iam_policy_document.workshop_policy.json
}

```
</details>

## Conditional Count

Open variables.tf and add a new boolean variable. This variable should control if the resource will be created or not. Use the meta argument [count](https://developer.hashicorp.com/terraform/language/meta-arguments/count).

```hcl
variable "create_policy" {
  type        = bool
  description = "If this is set as `true` the policy will be created"
  default     = true
}
```


<details>
  <summary>Answer</summary>


```hcl
resource "aws_iam_policy" "workshop_policy" {
  count  = (var.create_policy ==true ? 1 : 0)
   
  name   = var.policy_name
  policy = data.aws_iam_policy_document.workshop_policy.json
}

```

</details>