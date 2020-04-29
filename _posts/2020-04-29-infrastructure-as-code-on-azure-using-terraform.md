---
title: Infrastructure as Code on Azure using Terraform
comments: true
tags:
  - infrastructure as code
  - iac
  - azure
  - terraform
date: 2020-04-29 09:48 -0400
---
* Create a resource group
* Create some storage for the terraform metadata (we'll use this as the TF backend)
* Install Terraform `choco install terraform`

* Add the provider

```
provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.7.0"

  subscription_id = "SECRET_SUB_ID"
  tenant_id       = "SECRET_TENANT_ID"
  features {}
}
```

* Setup the backend:

```
terraform {
      backend "azurerm" {
    resource_group_name  = "TerraFormMetadata"
    storage_account_name = "terraformmetadata"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }

}
```

* Run `terraform init` which will pull from the back-end storage and create the file.