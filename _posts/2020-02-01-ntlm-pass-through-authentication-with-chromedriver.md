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
date: '2020-02-01 00:08 -0500'
---
```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome]
"AuthNegotiateDelegateWhitelist"="*.companydomain.org,*.companydomain.coop"
"AuthSchemes"="basic,digest,ntlm,negotiate"
"AuthServerWhitelist"="*.companydomain.org,*.companydomain.coop"
```
