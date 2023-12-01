provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      terraform-workshop = "expressions"
    }
  }
}


data "aws_iam_policy_document" "workshop_policy" {

  statement {
    actions   = var.policy_actions
    effect    = var.policy_effect
    resources = var.policy_resources
  }
}


resource "aws_iam_policy" "workshop_policy" {
  name   = var.policy_name
  policy = data.aws_iam_policy_document.workshop_policy.json
}


output "data" {
  value = aws_iam_policy.workshop_policy
}
