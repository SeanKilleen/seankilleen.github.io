---
title: "Solved: Blazor IdentityServer 500.30 Error (ANCM Issue)"
comments: true
tags:
  - blazor
  - azure
  - ssl
  - certificate
  - security
  - powershell
  - identityserver
date: 2020-06-07 14:31 -0400
---
Ran into this this issue while hacking on a problem with my Dad, [Jim Killeen](https://twitter.com/JimK_). (Side note: looking at tech stuff with my Dad remains one of my great joys in life.) 

## Context

My Dad is building a client-side Blazor app, because he's more hip with technology than I am.

## Problem

When publishing / deploying the app, upon it attempting to start up and communicate with a Web API, we see an error of `HTTP Error 500.30 - ANCM In-Process Start Failure`.

## Solution

This is caused because the client-side web app cannot communicate securely with the Web API, which is fair. We want to make sure there's trust there. So to get that trust in place, we'll need to generate a self-signed certificate and set up the IdentityServer configuration to use it.

### Creating the Self-Signed Certificate

Modify the variables in the below powershell to create a self-signed certificate.

```powershell
$AzureWebsiteName = "mywebsite.azurewebsites.net"
$CertPassword = "MyPassword!123" # Pick a better password than this. Please.
$PfxOutputLocation = "C:\temp\cert.pfx" # Folder must already exist

#### You shouldn't need to modify anything below this line.

$cert = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname $AzureWebsiteName
	
$pwd = ConvertTo-SecureString -String $CertPassword -Force -AsPlainText

$path = 'cert:\localMachine\my\' + $cert.thumbprint 
Export-PfxCertificate -cert $path -FilePath $PfxOutputLocation -Password $pwd
```

At this point, you should have a `.pfx` file with the appropriate password that you specified.

### Uploading the Certificate into Azure

* Open the Azure portal and navigate to your web site
* On the left-hand settings menu, select `TLS/SSL Settings`

> ![TLS SSL Menu]({{site.post-images}}/2020-06_BlazorANCM/01_TlsSslSettings.png)

* In the top menu, select `Private Key Certificates (.pfx)`

> ![Private certificates menu]({{site.post-images}}/2020-06_BlazorANCM/02_PrivateCertificates.png)

* From the sub-menu, select upload.

> ![Upload menu button]({{site.post-images}}/2020-06_BlazorANCM/03_Upload.png)

* Select the cert location and enter the password you previously chose for it.

> ![Certificte upload dialog]({{site.post-images}}/2020-06_BlazorANCM/04_CertificateInfo.png)

* Upload the cert. You will now see it in the certificates list.

### Updating the IdentityServer Settings

Okay, so there's one more part to go. In your `appSettings.json` or wherever that is being transformed, add or edit IdentityServer configuration as follows:

```json
"IdentityServer": {
  "Key": {
    "Type": "Store",
    "StoreName": "My",
    "StoreLocation": "CurrentUser",
    "Name": "CN=MyApplication"
  }
}
```

Replacing `CN=MyApplication` with your site name, e.g. `CN=mywebsite.azurewebsites.net`.

### Give it a spin!

Open up the application in Azure, annnd success. :) 

I hope this helps someone out. Happy coding!