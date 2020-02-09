---
title: 'How to: "warm up" an environment using PowerShell and TeamCity'
comments: true
tags:
  - ci
  - cd
  - powershell
  - teamcity
  - deployments
date: '2020-02-18 10:00 -0500'
---
Prior to running some tests on a .NET web application, we wanted to send a request to the environment to "warm it up" -- so that the initial start of the application pool would be completed before the tests started running.

## Solution

* Select a URL that you can reasonably expect to hit as a smoke test
* Create a TeamCity build configuration
* Add a build step to the configuration of type "Powershell Script"
* Select an in-line script
* Add the following powershell: 

```powershell
Invoke-WebRequest -Uri http://theURLToHit -UseDefaultCredentials
```

Now the build step will hit the URI using the build agent's credentials, and the command will return when the result does (with a 200 after the app pool has started up).

Happy deployments!
