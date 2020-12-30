---
title: 'Solved: .NET 5 "SEC_ERROR_INADEQUATE_KEY_USAGE" in Firefox'
comments: true
tags:
  - .net
  - .net 5
  - .net core
  - firefox
  - certificate
date: 2020-12-30 12:00 -0500
---
Ran across an issue I had to fix where a .NET 5 application, which happened to be running in a Docker container (this ended up being irrelevant), couldn't start up in Firefox due to a certificate error, even though I'd accepted the .NET certificate at the root. I saw a `SEC_ERROR_INADEQUATE_KEY_USAGE` error in the browser.

## Solution

This is because Firefox is not utilizing the Windows certificatee store, so I have to force it to do so.

* Open the Firefox settings by going to `about:config`
* Search for `security.enterprise_roots.enabled`
* Ensure that the setting is set to `true`.

This will tell Firefox to use the Windows Cert store, which allows the certificate to be seen and the site trusted for local development.