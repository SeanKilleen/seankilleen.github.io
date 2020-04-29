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
* Login to the azure cli `az login`
* Install Terraform `choco install terraform`
* Add the provider:

```
provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.7.0"

  subscription_id = "SECRET_SUB_ID"
  tenant_id       = "SECRET_TENANT_ID"
  features {} # This is required so that it doesn't throw an error.
}
```

* Setup the azure resources that you'll use for your back-end:

```
resource "azurerm_resource_group" "backendrg" {
    name     = "TestTFProject"
    location = var.DeploymentRegion
}

resource "azurerm_storage_account" "backendstorageacct" {
    name                     = "terraformmetadata"
    resource_group_name      = azurerm_resource_group.backendrg.name
    location                 = azurerm_resource_group.backendrg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
}

resource "azurerm_storage_container" "backendstoragecontainer" {
    name                  = "tfstate"
    storage_account_name  = azurerm_storage_account.backendstorageacct.name
    container_access_type = "private"
}
```

* Add a variables file or section

```
variable "AzureSubscriptionId" {
    description = "The subscription in which you are trying to set up this Terraform config"
    type = string
}

variable "AzureTenantId" {
    description = "The tenant in which you are trying to set up this Terraform config"
    type = string
}

variable "DeploymentRegion" {
    default="eastus2"
    description="The region you want to create resources in."
    type = string
}
```

* Add the file where you fill out the variables

```
AzureSubscriptionId="MY_SECRET_SUB
AzureTenantId="MYY_SECRET_TENANT"
```

* Run `terraform init` which will create your state locally.
* Run `terraform apply` to create the infrastructure

That's great, but now all our state is stored locally. This is Not A Good Idea (TM).

So, add the backend:

```
terraform {
    backend "azurerm" {
        resource_group_name  = "TestTFProject"
        storage_account_name = "terraformmetadata"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
        subscription_id = "d10f1412-44d2-4a88-9740-aa87e164b172" # TODO: Variable somehow?
        tenant_id       = "cf8f1ebd-81a2-49c8-a1e0-12bde7964425" # TODO: Variable somehow?
    }
}
```

* Run `terraform apply` and notice that it tells you the back-end changed.
* Now tun `terraform init` again. It will prompt you on whether to add your state to the new back-end. Say yes!

Now Terraform is ready to rock and roll -- you've got the basics for your 