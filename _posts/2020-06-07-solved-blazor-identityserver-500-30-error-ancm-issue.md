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

### Updating the IdentityServer Settings



Annnd success. :) 