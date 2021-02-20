---
title: "How To: Use Azure AD Powershell to Work With Extension Properties (User
  Attributes)"
comments: true
tags:
  - azure-ad
  - azure-ad-b2c
date: 2021-02-19 23:32 -0500
---
* Open admin powershell window
* Run `Install-Module AzureAD` and follow steps
* Open new window
* Run `Import-Module AzureAD`
the* `$AzCred = Get-Credential`, which will prompt you for a user/password securely in the terminal. User your Azure credentials that have access to the subscription you care about.
* `Connect-AzureAD -Credential $AzureAdCred -TenantId $tenant`
  * Note, this is the tenant that has the Azure B2C directory.

Once you’re connected to the tenant, you can run some helpful commands using the objectIds of the application or of a user.

* Get all registered properties: `Get-AzureADApplicationExtensionProperty -ObjectId $applicationObjectId | Select Name, DataType`
* Get properties for a user: `Get-AzureADUser -ObjectId $UserObjectId | Select -ExpandProperty ExtensionProperty`
* Set a Property: `Set-AzureADUserExtension -ObjectId $UserId -ExtensionName $PropertyName -ExtensionValue "MyNewValue"`

More docs: https://docs.microsoft.com/en-us/powershell/azure/active-directory/using-extension-attributes-sample?view=azureadps-2.0
