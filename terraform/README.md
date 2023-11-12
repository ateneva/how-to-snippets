# Terraform

## What is Terraform?

Terraform is a tool that allows us to build infrastructure as code

## Why is Infrastrcture as code important?

Building infrastructure in a controlled way makes it:

- possible to version control
- easy to replicate

## Setting up Terraform

- setup terraform locally

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

- verify installation

```bash
terraform -version
terraform -help
```

### Terraform comes pre-imnstalled in Google Cloud Shell

## USEFUL CLI

 - automatically download and install any provider binary for the providers to use within the configuration

```bash
terraform init
```

- reformat your configuration in the standard style

```bash
# check if file format is according to standard style
terraform fmt -check

# apply standard style of formatting
terraform fmt

#Display diffs of formatting changes
terraform fmt -diff
```

- create an execution plan

```bash
terraform plan

# save an execution plan to apply later
terraform plan -out "my-bucket-config"
```

- apply the execution plan

```bash
terraform apply

# apply exectuion plan that has been saved
terraform apply "my-bucket-config"
```

- show the current state of infrastructure config

```bash
terraform show
```

- Mark a resource instance as not fully functional and to be destroyed and recreated on next apply

```bash
terraform taint
```

- destroy infrastructure

```bash
terraform destroy
```
