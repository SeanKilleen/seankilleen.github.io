---
layout: post
title: 'CruiseControl .NET Gotcha: Moving Microsoft.WebApplications.Targets to the
  server [Field Notes]'
date: 2012-05-01 12:17:00.000000000 -04:00
comments: true
redirect_from: 
 - /2012/05/cruisecontrol-net-gotcha-moving.html
---
### Problem
When attempting an automated build, CruiseControl.NET (running on Server 2008 R2 with .NET Framework 4.0 Installed) gives the following error in its log:


>error MSB4019: The imported project "C:\Program Files (x86)\MSBuild\Microsoft\VisualStudio\v10.0\WebApplications\Microsoft.WebApplication.targets" was not found. Confirm that the path in the `<Import>` declaration is correct, and that the file exists on disk.

### Solution
This is ridiculous, but you have to copy the two files from your machine to the Build Server.

Copy the directory `C:\Program Files (x86)\MSBuild\Microsoft\VisualStudio\*.*` to the same location on the build server. 
