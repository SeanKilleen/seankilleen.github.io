---
title: 'How to: Call a TeamCity build from OctopusDeploy'
comments: true
tags:
  - ci
  - cd
  - octopusdeploy
  - teamcity
date: '2020-02-04 12:16 -0500'
---
## Background / Challenge

* We have an OctopusDeploy deployment that deploys our code to an automated acceptance test environment
* We have a TeamCity build that executes our automated acceptance tests

The problem is: the TeamCity build kicked off after our code was merged, not after the deployment was finished. We wanted the tests to kick off only after the environment was ready.

## Solution

I created an OctopusDeploy step template to kick off a TeamCity build, and then utilized that step template in the Octopus deployment.

It works via crafting an `HTTP POST` request against the TeamCity API. 

### Step Template Contents

I created a PowerShell script that utilizes some parameters

```powershell
$parsedUrlString = "$TeamCityServerURL" + "/app/rest/buildQueue" $parsedXmlBody = '<build><buildType id="' + $TeamCityBuildConfigID + '"/></build>'

$HeaderFields = @{} $HeaderFields.add("Authorization", "Bearer $TeamCityAccessToken")
$HeaderFields.add("Origin", "$TeamCityServerURL")

Write-Host "Attempting to run the $TeamCityBuildConfigID build" Write-Host "Connecting to $parsedUrlString"

Invoke-WebRequest -UseBasicParsing $parsedUrlString -ContentType "application/xml" -Method POST -Body $parsedXmlBody -Headers $HeaderFields
```

### The Parameters

From the variables in the script, Octopus will generate step templates:

![Script parameters shown visually]({{site.post-images}}/teamcity_from_octopus/ScriptParameters.png)

### Generating the TeamCity Access Token

* Open TeamCity and head to the settings menu:

![The settings menu]({{site.post-images}}/teamcity_from_octopus/SettingsMenu.png)

* Click to create the access token:

![the menu for creating an ccess token]({{site.post-images}}/teamcity_from_octopus/CreateAccessToken.png)

* Give the access token a name:

![Name entry for access token]({{site.post-images}}/teamcity_from_octopus/AccessTokenName.png)

* Copy the access token

![Access token text for copying]({{site.post-images}}/teamcity_from_octopus/AccessTokenCopy.png)

### Adding the build step

* In OctopusDeploy, open the deployment in question
* Add a deployment step, and select the step template
* Add the applicable parameters

## The Result

Now, when we commit code:

* The build finishes
* The Octopus deployment kicks off
* After the deployment, the last step calls the other TeamCity build
* The TeamCity build kicks off to run our automated acceptance tests

Happy deploying!
