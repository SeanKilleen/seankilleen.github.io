---
title: "How To: Use Azure AD Powershell to Work With Extension Properties (User
  Attributes)"
comments: true
tags:
  - azure-ad
  - azure-ad-b2c
  - powershell
date: 2021-02-19 23:32 -0500
---
Recently I worked on a project that involved working with Azure Active Directory B2C. As part of the Azure AD set up, we had created some extension properties for users. Our counterparts on another team needed to be able to retrieve and set them, and had PowerShell at their disposal.

Here are the steps I provided to walk them through the process.

* Open an admin PowerShell window
* Run `Install-Module AzureAD` and follow steps to install the PowerShell module for working with Azure AD
* Open a new window
* Run `Import-Module AzureAD` to make the Azure AD cmdlets available.
* Run `$AzCred = Get-Credential`, which will prompt you for a user/password in the terminal. Use your Azure credentials that have access to the subscription you care about.
* `Connect-AzureAD -Credential $AzureAdCred -TenantId $tenant`
  * Note, this is the tenant that has the Azure B2C directory, which is normally its own tenant.

Once you're connected to the tenant, you can run some helpful commands using the `objectId`s of the application or of a user.

* Get all registered properties: `Get-AzureADApplicationExtensionProperty -ObjectId $applicationObjectId | Select Name, DataType`
* Get properties for a user: `Get-AzureADUser -ObjectId $UserObjectId | Select -ExpandProperty ExtensionProperty`
* Set a Property: `Set-AzureADUserExtension -ObjectId $UserId -ExtensionName $PropertyName -ExtensionValue "MyNewValue"`

## More Over at the Azure AD Docs

You can check out more docs on working with Azure AD in PowerShell at
<https://docs.microsoft.com/en-us/powershell/azure/active-directory/using-extension-attributes-sample?view=azureadps-2.0>

Happy scripting!
