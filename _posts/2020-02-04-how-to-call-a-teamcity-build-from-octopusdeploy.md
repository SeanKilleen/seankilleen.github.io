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
\`\``powershell

$parsedUrlString = "$TeamCityServerURL" + "/app/rest/buildQueue" $parsedXmlBody = '<build><buildType id="' + $TeamCityBuildConfigID + '"/></build>'

$HeaderFields = @{} $HeaderFields.add("Authorization", "Bearer $TeamCityAccessToken")
$HeaderFields.add("Origin", "$TeamCityServerURL")

Write-Host "Attempting to run the $TeamCityBuildConfigID build" Write-Host "Connecting to $parsedUrlString"

Invoke-WebRequest -UseBasicParsing $parsedUrlString -ContentType "application/xml" -Method POST -Body $parsedXmlBody -Headers $HeaderFields

\`\``
