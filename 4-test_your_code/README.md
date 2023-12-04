# Test your code

Terraform testing is a crucial aspect of Infrastructure as Code (IaC) development that ensures the reliability and stability of your infrastructure configurations. Testing in Terraform involves validating your code against various scenarios to catch errors early in the development process and guarantee the desired state of your infrastructure.

## Static checks

We could run our tests using the tools that Terraform offers or external tools

### Built in tests

- terraform fmt -> With the option --check we can run a test that verify if all the files has the right indentation.
- terraform validate -> this searches for syntax problems.
- terraform plan -> running a plan from time to time in a existing infrastructure will generate a report with changes not applied.
- custom validation rules -> we could take advantage of some validation like variables, locals and meta arguments. To validate input data.

### External tools

- [tflint](https://github.com/terraform-linters/tflint) -> is a tool that can fund possible error, warn about deprecated syntax and enforce best practices.
- [checkov](https://www.checkov.io/) -> this tool can check for security issues. Other tools like that are [tfsec](https://aquasecurity.github.io) and [tfscan](https://github.com/wils0ns/tfscan).
- Terraform Sentinel -> feature of terraform cloud, available for the enterprise account. This tool help to enforce policies.

## Running tests

We can run this tests manually our in a automatic way. These tests can be run by bash scripts for example. Another way to run tests is using [terratest](https://terratest.gruntwork.io/). Terratest run Go scripts that can execute tests against the code.
