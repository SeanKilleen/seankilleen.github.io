---
title: >-
  Quick tip: NTLM / Windows pass-through authentication with Selenium and
  ChromeDriver
comments: true
tags:
  - chromedriver
  - selenium
  - testing
  - registry
  - authentication
  - ntlm
  - quick tips
date: '2020-02-02 09:58 -0500'
---
## Challenge 

I was on a project for a web application that used Windows Active Directory authentication for internal users.

We had some automated acceptance tests using Selenium and ChromeDriver. However, these tests would always fail on our build agents, and we couldn't figure out why. There were errors around authentication.

## Solution

After a hunch and some intense googling, we found that there are registry settings where you can enable Chrome to allow ChromeDriver to accept NTLM authentication negotiation by default. 

The key is to add the following to your registry, to ensure you're enabling the desired auth schemes for the desired domains.

An example `.reg` file is below that you can modify to use. After running applying these settings to our build agents, the problems were resolved.

```ini
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome]
"AuthNegotiateDelegateWhitelist"="*.companydomain.org,*.companydomain.coop"
"AuthSchemes"="basic,digest,ntlm,negotiate"
"AuthServerWhitelist"="*.companydomain.org,*.companydomain.coop"
```

Happy testing!
