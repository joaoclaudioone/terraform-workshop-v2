# terraform-workshop

The primary goal of this repository is to offer an introduction to Terraform. Each folder contains exercises illustrating fundamental concepts.

## Prerequisites

- Terraform 1.6.x
- An AWS account with permission to create some resources.

## Installation

Terraform can be installed on both Windows and Unix-like systems. Detailed instructions for each operating system can be found on the official [website](https://www.terraform.io/downloads).

## Introduction

Terraform is a tool that enables the creation and management of infrastructure, service platforms, and services within a given platform.

Using a declarative language, Terraform requires users to describe their objectives, and then it generates an execution plan to achieve those objectives. This approach differs from imperative languages, where users must explicitly outline all the steps to reach the final objective.

## Usage

You don't need to take note of these commands now; they will be repeated later. The initial step before creating anything is to execute the command `terraform init`. This command initializes the code within the directory. Following that, you can review the execution plan of Terraform using `terraform plan`. It's important to note that this command doesn't inspect the existing infrastructure; instead, it only lists the changes.

Finally, the code can be applied using `terraform apply`, initiating the creation process for the infrastructure. Alternatively, all created infrastructure can be destroyed using `terraform destroy`.

These are the fundamental commands; additional advanced commands can be found [here](https://www.terraform.io/cli/commands).

## Index

[1 - Resources and modules](./1-resources_and_modules/README.md)

> [1.1 - Resources](./1-resources_and_modules/1.1-resources/RESOURCES.md)

> [1.2 - Variables](1-resources_and_modules/1.2-variables/VARIABLES.md)

> [1.3 - Module](./1-resources_and_modules/1.3-modules/MODULE.md)
