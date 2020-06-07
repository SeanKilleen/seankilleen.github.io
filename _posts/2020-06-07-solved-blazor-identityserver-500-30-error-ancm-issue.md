---
title: "Solved: Blazor IdentityServer 500.30 Error (ANCM issue)"
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
Ran into this with my Dad, Jim Killeen.

Solution:

* Create self-signed cert in powershell
* Upload pfx into Azure
* Add the IdentityServer settings with the CN being your app name.

Annnd success. :) 