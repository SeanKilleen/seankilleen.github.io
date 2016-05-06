---
layout: post
title: 'Workaround: MSBuild Error MSB3644: "The reference assemblies for framework
  ".NETFramework,Version=v4.0" were not found" [Field Notes]'
date: 2012-05-01 19:29:00.000000000 -04:00
comments: true
redirect_from:
 - /2012/05/workaround-msbuild-error-msb3644.html
 - /2012/05/workaround-msbuild-error-msb3644-the-reference-assemblies-for-framework-netframeworkversionv4-0-were-not-found-field-notes/
---
### Problem
When attempting to build a Continuous Integration solution with MSBuild on Windows Server 2008 R2 (With .NET Framework 4.0 installed) I receive the following error:

>c:\Windows\Microsoft\.NETFramework\v4.0.30319\Microsoft.Common.targets(847,9): warning MSB3644: The reference assemblies for framework ".NETFramework,Version=v4.0" were not found. To resolve this, install the SDK or Targeting Pack for this framework version or retarget your application to a version of the framework for which you have the SDK or Targeting Pack installed. Note that assemblies will be resolved from the Global Assembly Cache (GAC) and will be used in place of reference assemblies. Therefore your assembly may not be correctly targeted for the framework you intend.

### Solution
I'll be the first to admit there are probably more elegant ways, but I recommend the following:

#### Install .NET Framework 4.0 / Windows 7 SDK
You can download it from Microsoft. If you don't have access to do this, or if that doesn't work, you can do the following.

#### Copy the Reference Assemblies Folder to Your Build Server
Copy `C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\*.*` to a folder on your build server (for me, it was `E:\ContinuousIntegration_ReferenceAssemblies`)

#### Override the Reference Assemblies in Your Build Configuration
When you call MSBuild, pass it a parameter -`p:FrameworkOverride`, with the location of the build.

For example, my CruiseControl.NET config MSBuild section for this project now looks like:

```xml
<msbuild>
        <executable>C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe</executable>
        <buildArgs>PEApps.build -p:FrameworkPathOverride="E:\ContinuousIntegration\_ReferenceAssemblies\v4.0"</buildArgs>
        <targets>Compile</targets>
        <timeout>1800</timeout>
        <!--  30 minutes -->
        <logger>C:\Program Files (x86)\CruiseControl.NET\server\ThoughtWorks.CruiseControl.MSBuild.dll</logger>
</msbuild>
```

It's hack, for sure, but it got the solution to build, and it's reusable in future scenarios.

Probably easier to download the SDK and install it, though.
