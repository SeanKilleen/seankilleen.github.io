---
title: "How to: Use AzureSignTool to sign files with Azure DevOps using a
  certificate in Azure KeyVault"
comments: true
tags:
  - azure
  - azure devops
  - azure keyvault
  - ci
  - cd
  - build process
  - security
  - digital signatures
  - signing.
date: 2020-05-17 15:55 -0400
---

Phew! That title is a mouthful.

I have a small office add-in product that I'm building to scratch an itch in actually delivering a product to market. I've found the local version quite useful and it's time to get it into others' hands.

To ensure users can trust my application, I need to digitally sign it. That was ...a pain, so I figured I'd write up how I did it for others' benefit.

A huge thanks here goes to [Kevin Jones](https://twitter.com/vcsjones) for the [AzureSignTool](https://github.com/vcsjones/AzureSignTool) utility, which is the only thing that makes this possible in a way I feel confident about.

## Obtaining the Certificate

This was probably the most involved part of the process. I bit the bullet and paid roughly $80/year for an Authenticode signing certificate under the name of my LLC. Once I purchased the certificate, I was contacted by a company named Sectigo. I provided documents to prove that my LLC existed, such as tax records and pointer to us on a state registration web site. However, they also needed to validate my phone number. This led me to register with Dun & Bradstreet for a DUNS number and listing on their site. After a phone interview and a short wait (it can take up to 30 business days; mine took 2, I believe), I had a DUNS number and a listing on their site. This allowed Sectigo to give me the green light on verification and approve the certificate, which I could then download and export.

While the process is unnecessarily cumbersome and annoying, I had to remind myself that certificates are about trust. At the end of the day, I'd much prefer certificate authorities who do their due diligence to those who are lax. So, it is what it is. 

TODO: JKSimmons_Shrugging_Farmers.gif

## Setting up the Azure Pieces

A lightweight guide on how to use this tool in context.

* Obtain a certificate.
* Within your Azure subscription, create an Azure KeyVault. Note the URL of the KeyVault; this will be your input to `-kvu` later.
* Upload your certificate into the KeyVault, giving it a name.
* Within your Azure AD, register an application with a name (no need to worry about the redirect URL).
* In the overview screen for the application, note the Application ID -- this will be the client ID input into the `-kvi` parameter later.
* Create a client secret for the application and give it a description (e.g. "Access to KeyVault certificate for signing"). Be sure to copy the secret somewhere temporarily, as you won't be able to see it after initially creating it. This secret will be passed into the `-kvs` parameter later.
* Return to your KeyVault's settings, and go to the `Access Policies` section.
* Create an access policy that applies to your registered application, e.g. if the app you registered in AD was called `MyApp`, this policy should apply to the `MyApp` user.
* For the access policy, set the below permissions:

| Area | Permissions |
| ---- | ----------- |
| Key | Verify, Sign, Get, List |
| Secret | Get, List |
| Certificate | Get, List |

* In your Azure DevOps build configuration, add a step to install the global tool:

```yml
- task: DotNetCoreCLI@2
  inputs:
    command: 'custom'
    custom: 'tool'
    arguments: 'install --global azuresigntool'
  displayName: Install AzureSignTool
```

* In your Azure DevOps build configuration, add a step to use the tool, with the values we captured earlier in the bracketed placeholders:

```yml
- task: CmdLine@2
  displayName: 'Sign outputted .exe with global AzureSignTool'
  inputs:
    script: AzureSignTool sign -du "[YOUR_URL]" -kvu "https://[VAULT_ID].vault.azure.net" -kvi "[REDACTED_APPLICATION_ID]" -kvs "[REDACTED_APPLICATION_CLIENT_SECRET" -kvc "[REDACTED_CERT_NAME]" -v [FILES_YOU_WANT_TO_SIGN]
```

At this point, the build should be able to run and sign the files you have listed.

Happy signing!