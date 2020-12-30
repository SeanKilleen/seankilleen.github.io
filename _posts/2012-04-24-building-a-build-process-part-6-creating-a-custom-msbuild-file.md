---
 
title: 'Building a Build Process: Creating a Custom MSBuild File'
date: 2012-04-24 23:35:00.000000000 -04:00
comments: true
series: building-a-build-process
redirect_from: 
 - /2012/05/building-build-process-part-6a-msbuild.html
references: 
 - title: Pluralsight CI Course
   url: https://www.pluralsight.com/courses/continuous-integration
---
{% include _buildseries-intro.md %}

**Ed. Note**: I cannot give enough praise to the [Pluralsight.com Continuous Integration course][PS CI Course] it helped me put a lot of these pieces together, and this part in the series could not have happened without it. A lot of the content for this post ended up being a pretty direct port of what is talked about there, but there are only so many ways to personalize a best practice while keeping it simple, and so I hope you’ll [sign up for a Pluralsight subscription][PS Sub], and that their lawyers will take kindly to this series. :smile:

So, now that we have our initial project structure created and under source control, we have to find a way to build it. “Oh, I know!” you say. “We’ll hit F5!” well, while that might work for local development, your build server can’t hit F5.

Lucky for us, the process of hitting F5 and turning your code into a DLL isn’t all magic. In fact, it’s a highly documented tool called MSBuild, by the Microsoft team, that ships with the .NET Framework.

In today’s installment, we’re going to do the following:

* Add MSBuild to the Path line and test it using Powershell  
* Create an XML file that will build our application using MSBuild Tasks  
* Examine variables in MSBuild XML files  
* Create tasks for cleaning the build, initializing the build, and compiling the build  
* Put it all together to create build targets.  
* Use PowerShell to execute those build targets.

### Find the Location of MSBuild on Your Machine

The good news is, if you have the .NET Framework, you have it. If you have the .NET 4.0 Framework (and really, you should), you should be able to find it in `%WinDir%Microsoft.NETFrameworkv4.0.30319`

### Add MSBuild to the System Path

* Click Start  
* Right-click `Computer` and select `Properties`
* Click `Advanced System Settings`
* Click `Environment Variables`
* In the second section, `System Variables`, look for the PATH variable, and click edit.  
* Ensure that a semi-colon is after the last entry, and then past in the path to your MSBuild.exe, leaving off a trailing slash (e.g. mine was `C:\Windows\Microsoft.NET\Framework\v4.0.30319` without quotes.)

### Run PowerShell and Test Access to MSBuild

* Click the start menu, begin to type “PowerShell”, and bring up the PowerShell console *by right-clicking and choosing “Run as Administrator”*. You must do this in order to run MSBuild the way it is necessary to run it. (you may also want to pin the icon to your taskbar at this point).  
* When the console is open, type MSBuild.  
* You should see an error about not specifying a project or solution file. If you see any red text, such as “command not found”, etc., then something went wrong and powershell can’t see your MSBuild location. (try running as admin or checking your path variable setup).

### Create a New, Empty .build XML File

* Open the TestProject solution in Visual Studio  
* Right-click on the solution and select `Add > New Item`.  
* Select XML File as the type, and name it `TestProject.build`. Now you’ll have a .build file at the root of your solution. This is what we want.

### Adding the Schema for an MSBuild XML file

After the first line of the XML file, you’ll need to add the root node and give it the schema reference for its XML namespace (xmlns). After you do this, it should look like the following:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="4.0">
</Project>
```

Note that I also added a ToolsVersion attribute, with “4.0” denoting the version of the .NET Framework we’re using.

### Add Some Properties

Instead of going back and refactoring after showing you a full examples, I’m going to save some precious keystrokes and tell you that at some point, it will be easier and more flexible to use variables. To do this:

* Create an `<ItemGroup> </ItemGroup>` node within the Project section.  
* The format under this will essentially be: `<PropertyName Include=”PropertyTextToInclude”/>`  
* Add references to your BuildArtifacts folder, and also to your solution file, like so:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="4.0">

    <ItemGroup>
        <BuildArtifacts Include=".\buildartifacts\"/>
        <SolutionFile Include=".\TestProject.sln"/>
    </ItemGroup>
</Project>
```

### The Basics: Cleaning and Initializing Our Directory

Next, we create two targets. One, “Clean”, will delete the `.buildartifacts` folder. The second, “Init”, will recreate it. Pretty simple. The XML to accomplish this is below:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="4.0">
    <ItemGroup>
        <BuildArtifacts Include=".\buildartifacts\"/>
        <SolutionFile Include=".\TestProject.sln"/>
    </ItemGroup>

    <Target Name ="Clean">
        <RemoveDir Directories="@(BuildArtifacts)"/>
    </Target>

    <Target Name="Init" DependsOnTargets="Clean">
        <MakeDir Directories ="@(BuildArtifacts)"/>
    </Target>
</Project>
```

You’ll notice that I have the “Init” target depend on the “Clean” target via DependsOnTargets. This means that any time we create the folder, we’ll first delete it to make sure we’re starting fresh.

Also notice that instead of putting a path to the `buildartifacts` folder directly, I’m using `@(BuildArtifacts)`, which tells MSBuild to refer to the ItemGroup variable we created earlier.

### Trying our “Clean” and “Init” Targets in PowerShell

* Open PowerShell in Admin mode  
* Navigate to the Solution folder (e.g. `cd Users\Sean\Projects\TestProject` for me)  
* Also open this folder in Windows Explorer. See the `buildartifacts` folder there?  
* In PowerShell, run: `MSBuild TestProject.build /Target:Clean`  
* Note that in Windows Explorer, the `buildartifacts` folder is gone.  
* In PowerShell, run: `MSBuild TestProject.build /Target:Init`  
* Note that the folder has reappeared. Add a file to the folder – a text file or something small.  
* In PowerShell, run: `MSBuild TestProject.build /Target:Init`  
* Note that the folder has been deleted and recreated, and thus no longer contains the item you put there.

### Getting to the Good Stuff: Compiling our App

Up until this point, we haven’t compiled our code. Since that’s what gets us paid, in a manner of speaking, we should create an MSBuild task to compile the code. We can do this via the following additional target:

```xml
    <Target Name="Compile" DependsOnTargets="Init">
        <MSBuild Projects="@(SolutionFile)" Targets="Rebuild" Properties="OutDir=%(BuildArtifacts.FullPath)"/>
    </Target>
```

This calls the MSBuild exe from within MSBuild (I know…*whoa, dude*), passes it the solution, and compiles the program by passing it in our solution file variable. It also specifies that the Output Directory should be buildartifacts. **Tip:** See the `.FullPath`? Our variables are also objects, and so MSBuild will know that `%(BuildArtifacts)` is an object and thus will pick up on the FullPath property of it.
Note that we’ve made “Compile” dependent on “Init”, so that every time we compile, the `buildartifacts` folder will be blown away and re-created.
**Try it out**: In PowerShell, run `MSBuild TestProject.build /Target:Compile` and watch our solution be compiled to the buildartifacts directory. Pretty sweet, huh?

### Telling MSBuild What to do by Default

Passing a Target every time is pretty lame, especially when we usually just want to compile the code.

Luckily, by adding the DefaultTarget attribute to the Project node, we can tell MSBuild what to compile by default. Let’s try that now. Modify the Project node XML to make the default target “Compile”, like so:

```xml
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="4.0" DefaultTargets="Compile">
```

Save the file, and run `MSBuild TestProject.build` (without a target attribute). The project should compile.

### Next Time…

In the next article, we’ll explore how to start and stop the Cassini Web Server asynchronously, and how to run Visual Studio builds through common output directories.

{% include _buildseries-footer.md %}

[PS CI Course]: https://www.pluralsight.com/courses/continuous-integration

[PS Sub]: https://help.pluralsight.com/help/sign-in-sign-up
