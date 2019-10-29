---
title: NTLM pass-through authentication with ChromeDriver
comments: true
tags:
  - chromedriver
  - selenium
  - testing
  - registry
  - authentication
  - ntlm
date: '2019-10-29 09:37 -0400'
---
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome]
"AuthNegotiateDelegateWhitelist"="*.nreca.org,*.nreca.coop"
"AuthSchemes"="basic,digest,ntlm,negotiate"
"AuthServerWhitelist"="*.nreca.org,*.nreca.coop"
