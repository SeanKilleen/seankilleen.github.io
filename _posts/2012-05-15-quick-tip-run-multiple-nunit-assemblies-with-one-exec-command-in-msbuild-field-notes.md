---
 
title: 'Quick Tip: Run Multiple NUnit Assemblies with one Exec Command in MSBuild
  [Field Notes]'
date: 2012-05-15 10:52:00.000000000 -04:00

redirect_from:
 - /2012/05/quick-tip-run-multiple-nunit-assemblies.html
references: 
 - title: MultiAssembly
   url: http://www.nunit.org/index.php?p=multiAssembly&amp;r=2.2.10
   parenttitle: NUnit 
   parenturl: http://www.nunit.org/
 
---
This is mostly a reference post for me, but I figured somebody else might find it useful.

### Problem:

I have a .build file in MSBuild. I'd like to to execute my NUnit tests, but I have multiple test projects and thus multiple DLLs. NUnit requires one assembly to be passed to the nunit-console.exe application that MSBuild calls.

### Solution

Create a ".nunit" file, a specially understood file by NUnit that contains XML for referencing your test assemblies under each configuration.

I recommend putting this at the same folder level as your solution file and calling it `[SolutionName].nunit`. **NOTE:** the file *must* be a .nunit file; I tried with ".NUnitProjects" and it failed on the name alone.

It will look something like this:

```xml
<NUnitProject>
    <Settings activeconfig="Dev"/>
    <Config name="Dev">
        <assembly path=".\buildartifacts\MyProject.Core.Tests.dll"/>
        <assembly path=".\buildartifacts\MyProject.Web.Tests.dll"/>
        <assembly path=".\buildartifacts\MyProject.Web.SpecTests.dll"/>
    </Config>
    <Config name="Test">
        <assembly path=".\buildartifacts\MyProject.Core.Tests.dll"/>
        <assembly path=".\buildartifacts\MyProject.Web.Tests.dll"/>
        <assembly path=".\buildartifacts\MyProject.Web.SpecTests.dll"/>
    </Config>
</NUnitProject>
```

Note that I create one of these references for every configuration. (Debug and Release are the defaults). I'm not sure that this is necessary, but my bet is that it probably helps later when specifying the Configuration to MSBuild for an automated integration.

Lastly, add the appropriate variable to your .build file that references the .nunit file, and call that variable instead of the DLL. All assemblies will then be passed.
