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

* Install the azure cli (on Windows like me? I suggest using [Chocolatey](https://chocolatey.org): `choco install azure-cli`)
* Login to the azure cli: `az login`
* List your subscriptions: `az account list`. Note the Guid ID of the subscription you care about.
* Choose the subscription you want to create resources within: `az account set --subscription YOUR_SUBSCRIPTION_ID`
* Install Terraform (again, with chocolatey: `choco install terraform`)
* Create a file for your terraform script, e.g. `environment-setup.tf`, and open it.
* Add the provider to your terraform file:

```hcl
provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.7.0"

  subscription_id = "SECRET_SUB_ID"
  tenant_id       = "SECRET_TENANT_ID"
  features {} # This is required so that it doesn't throw an error.
}
```

* Add the setup for the azure resources that you'll use for your back-end:

```hcl
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

* Add a variables file or section, e.g. `myvars.tfvars` and add the following variables to it:

```hcl
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

* Add the file where you fill out the variables, e.g. `thesecrets.tf`

```hcl
AzureSubscriptionId="MY_SECRET_SUB"
AzureTenantId="MY_SECRET_TENANT"
```

* Run `terraform init` which will create your state locally.
* Run `terraform apply` to create the infrastructure

That's great, but now all our state is stored locally. This is Not A Good Idea (TM).

So, add the backend:

```hcl
terraform {
    backend "azurerm" {
        resource_group_name  = "TestTFProject"
        storage_account_name = "terraformmetadata"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
        subscription_id = "YOUR_AZURE_SUBSCRIPTION_ID" # TODO: Variable somehow?
        tenant_id       = "YOUR_AZURE_TENANT_ID" # TODO: Variable somehow?
    }
}
```

* Run `terraform apply` and notice that it tells you the back-end changed.
* Now tun `terraform init` again. It will prompt you on whether to add your state to the new back-end. Say yes!

Now Terraform is ready to rock and roll -- you've got the basics for your IaC setup.

Happy Terraforming!
