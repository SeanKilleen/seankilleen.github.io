---
 
title: 'Building a Build Process, Part 6b: MSBuild Integration With Cassini and Visual
  Studio'
date: 2012-05-02 22:39:00.000000000 -04:00
comments: true
series: building-a-build-process
redirect_from: 
 - /2012/05/building-build-process-part-6b-msbuild.html
references: 
 - title: Pluralsight Continuous Integration Course
   url:  http://www.pluralsight-training.net/microsoft/courses/TableOfContents?courseName=continuous-integration&amp;highlight=james-kovacs_ci-part1*3!james-kovacs_ci-part3*2!james-kovacs_ci-part2*2!james-kovacs_ci-part6*4,12#ci-part1
 - title: MSBuild Extension Pack web site
   url: http://msbuildextensionpack.codeplex.com/
 - title: MsBuild Extension Pack AsyncExec Reference 
   url: http://www.msbuildextensionpack.com/help/4.0.6.0/html/68cdc023-8926-4ac9-9e7c-0297592fec29.htm

---

### This Time…
In this round, we’re going to discuss:

* How to Start the Cassini Web Server Asynchronously 
* How to Stop the Cassini Web Server  
* How to (not quite) get Visual Studio to seemlessly Follow the Same directions that your MSBuild file follows.


### Starting the Web Server (Asynchronously!)
Visual Studio has a built-in web server – no doubt you’re familiar with it. It’s what runs whenever you hit F5 on a web server and see a web site come up. This server is called Cassini, and you can start it up through an MS Build Task.

*[**A little background**: Rather than show here, I’m going to tell. You can use the Exec task normally to run an executable, but the catch is that MSBuild will usually wait for the task to finish. We’re going to use the AsyncExec task in order to ensure that MSBuild will start the web server and continue performing next commands without waiting for Cassini to exit, since waiting on Cassini would be undesirable behavior here.]*

We’re going to take advantage of an excellent set of extensions called the MSBuild Community Tasks to accomplish our mission here.

### Get the MSBuild Extension Pack
You should visit the [MSBuild Extension Pack web site] for an excellent overview of the capabilities of these tools. You can just click the download button on the right-hand side to get the latest version in ZIP format..

* Unzip the download (anywhere is fine).
* Go one level deeper and extract the `.NET 4.0` zip file.
* Create a folder in the `thirdpartytools` folder of your solution called `MSBuildExtensionPack`.
* Copy the contents of the `Build` folder from the zip file (the .dlls, etc.) into this directory.
### Updating Your Build File to be AsyncExec Ready
We’ll have to update the build file to bring in the new task library (a great feature of MSBuild, by the way). To do this, we’ll add an import directive to the Extension Pack’s Task Files (this should go just inside of the `<project>` tag):

```xml
<Import Project=".thirdpartytoolsMSBuildExtensionPackMSBuild.ExtensionPack.tasks">`
```

Next up, we have to make a slight modification. The Extension Pack attempts to do some nice work for us to include all the tasks, but we need to override it. Find the following section at the top of the `MSBuild.ExtensionPack.Tasks` file and comment it out (in the lines below, I’ve done that already for you):

```xml
<!--    
<PropertyGroup>
        <BuildPath Condition="'$(BuildPath)' == ''">$(MSBuildProjectDirectory)</BuildPath>
        <ExtensionTasksPath Condition="Exists('$(BuildPath)....BuildBinariesMSBuild.ExtensionPack.dll')">$(BuildPath)....BuildBinaries</ExtensionTasksPath>
        <ExtensionTasksPath Condition="'$(ExtensionTasksPath)' == ''">$(MSBuildExtensionsPath)ExtensionPack4.0</ExtensionTasksPath>
    </PropertyGroup>
-->
```

Since the Extension Pack is no longer figuring out what its path is, we need to set an item in our `<ItemGroup` to point it to the right place: 

```xml
<ExtensionTasksPath Include=".thirdpartytoolsMSBuildExtensionPack"/>
```

Now we’re ready to add the command to start the web server.

### Adding a Target to Start the Web Site

First thing’s first – we have to add an item to the `<ItemGroup>` section to tell MSBuild where Cassini resides, and an item to tell it where our published web site will reside once it’s been spat out by our build process. I took the guesswork out of it for you in the lines below: 

```xml
<Cassini Include="$(CommonProgramFiles)microsoft sharedDevServer10.0WebDev.WebServer40.exe"/>
<Website Include=".buildartifacts_PublishedWebsitesTestProject.Web"/>
```

Next, we use the AsyncExec task from the Extension Pack to run the web server without hanging up our build process:

```xml
<Target Name="StartWebsite" DependsOnTargets="Compile">         
    <AsyncExec Command='"@(Cassini)" /port:9999 /path:"%(WebSite.FullPath)" /vpath:'/>     
</Target>
```

Try running your build file with a target of `StartWebsite`. You should be able to navigate to http://localhost:9999/ and see the web site in action (though it may just show a directory’s contents if the site is empty).

However, you may have noticed something. What stops the website so we can start it again? Nothing, and so we’re going to build that target too.

### Adding a Target to Stop the Web Site and Updating Dependencies
You can use the handy built-into-windows `TaskKill` program to force a kill of program that has the same name as the WebServer. We just call it with an Exec Command, as shown below:

```xml
<Target Name="StopWebsite">         
    <Exec Command="taskkill /f /im WebDev.WebServer40.exe" IgnoreExitCode="true" IgnoreStandardErrorWarningFormat="true"/>     </Target>
```

After that, we add the `StopWebsite` Target as a dependency to `StartWebsite`, before compile, so we know the site will be down before MS Build erases the files and spits out new ones: 

```xml
<Target Name="StartWebsite" DependsOnTargets="StopWebsite;Compile">
...
</Target>
```

Go ahead and try running your build with the `StopWebsite` and `StartWebsite` targets. 

**NOTE:** You may receive an error upon starting Cassini about there only being one instance allowed on a port. If you do, try changing the port number from `9999` to something else in the StartWebsite task (try to pick a port that’s not being used!).

For reference, at this point, our build file looks like:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="4.0" DefaultTargets="Compile">
    <Import Project=".\thirdparty\tools\MSBuildExtensionPack\MSBuild.ExtensionPack.tasks"/>
 
 
    <ItemGroup>
        <ExtensionTasksPath Include=".\thirdparty\tools\MSBuildExtensionPack\"/>
        <BuildArtifacts Include=".\buildartifacts\"/>
        <SolutionFile Include=".\TestProject.sln"/>
        <Cassini Include="$(CommonProgramFiles)\microsoft shared\DevServer\10.0\WebDev.WebServer40.exe"/>
        <Website Include=".\buildartifacts\_PublishedWebsites\TestProject.Web"/>
 
    </ItemGroup>
   
   
    <Target Name ="Clean">
        <RemoveDir Directories="@(BuildArtifacts)"/>
    </Target>
 
    <Target Name="Init" DependsOnTargets="Clean">
        <MakeDir Directories ="@(BuildArtifacts)"/>
    </Target>
 
    <Target Name="Compile" DependsOnTargets="Init">
        <MSBuild Projects="@(SolutionFile)" Targets="Rebuild" Properties="OutDir=%(BuildArtifacts.FullPath)"/>
    </Target>
 
    <Target Name="StopWebsite">
        <Exec Command="taskkill /f /im WebDev.WebServer40.exe" IgnoreExitCode="true" IgnoreStandardErrorWarningFormat="true"/>
    </Target>
   
    <Target Name="StartWebsite" DependsOnTargets="StopWebsite;Compile">
        <AsyncExec Command='"@(Cassini)" /port:9999 /path:"%(WebSite.FullPath)" /vpath:'/>
    </Target>
 
</Project>
```

### Getting Visual Studio to Play Along: Help Needed!
Unfortunately, this is one area that this blog series will fall short. I’ve scoured the internet in an attempt to find out how I can output the bin and obj to another folder based on the $(SolutionDir) variable, but apparently unlike C++, Visual Studio for C# does not allow this and instead creates a strange Folder with “$(SolutionDir)” literally in the name. I thought it would be pretty straightforward, but boy was I wrong. If anyone has any suggestions, I’m all ears. I was told I could go the route of editing the .csproj file, but I really tend to be wary of that kind of text editing; I like Visual Studio to be able to own that file for its sake.

For now, I just recommend using TortoiseSVN to ignore those folders in your source control so that it doesn’t conflict with anyone else if you hit F5 and commit later. 

And by all means, if you know how to solve the mystery, sound off in the comments!

[MSBuild Extension Pack web site]:http://msbuildextensionpack.codeplex.com/

[MsBuild Extension Pack AsyncExec Reference]: http://www.msbuildextensionpack.com/help/4.0.6.0/html/68cdc023-8926-4ac9-9e7c-0297592fec29.htm

[Pluralsight Continuous Integration Course]: https://www.pluralsight.com/courses/continuous-integration

[PS Signup]: https://help.pluralsight.com/help/sign-in-sign-up