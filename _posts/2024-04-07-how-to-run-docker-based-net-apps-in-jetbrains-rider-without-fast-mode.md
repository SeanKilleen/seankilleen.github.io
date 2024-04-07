---
title: How to Run Docker-based .NET apps in JetBrains Rider Without "Fast Mode"
comments: true
tags:
  - .NET
  - dotnet
  - docker
  - JetBrains
  - rider
  - IDEs
date: 2024-04-07 15:28 -0400
---
In most cases, containerized .NET apps run just fine "out of the box". IDEs such as Visual Studio and JetBrains Rider provide a helpful experience called "Fast mode" that uses some magic to put your files where they need to be inside of the container, rather than rebuilding it each time you start up. This is helpful!

However, in some cases -- such as one I experienced recently -- a container is not well-suited for "fast mode". There are ways to disable this in Visual Studio, but our team needed a little extra help to get it working with JetBrains Rider (which we also love!)

So, here's the `Docker.run.xml` that worked for us in Rider, including a breakdown on each line, and one additional step we had to take.

Note: in the sample below, you'll want to check everywhere I use "Redacted" instead of the name of our app.

## The `Docker.run.xml` File, With Comments

```xml
<component name="ProjectRunConfigurationManager">
  <configuration default="false" name="Docker" type="docker-deploy" factoryName="dockerfile" server-name="Docker">
    <deployment type="dockerfile">
      <settings>
        <option name="imageTag" value="REDACTED:dev" />
        <option name="attachToContainerNeeded" value="true" />
        <option name="buildArgs">
          <list>
            <DockerEnvVarImpl>
              <! -- This is specific to our container/company. You can disregard it. -->
              <option name="name" value="DotNetConfig" />
              <option name="value" value="Debug" />
            </DockerEnvVarImpl>
          </list>
        </option>
        <option name="containerName" value="REDACTED" />
        <option name="envVars">
          <list>
            <DockerEnvVarImpl>
              <!-- Required for User secrets access -->
              <option name="name" value="ASPNETCORE_ENVIRONMENT" />
              <option name="value" value="Development" />
            </DockerEnvVarImpl>
            <DockerEnvVarImpl>
              <!-- Ports must correspond to opened ports -->
              <option name="name" value="ASPNETCORE_HTTP_PORTS" />
              <option name="value" value="8080" />
            </DockerEnvVarImpl>
            <DockerEnvVarImpl>
              <option name="name" value="ASPNETCORE_HTTPS_PORTS" />
              <option name="value" value="443" />
            </DockerEnvVarImpl>
            <DockerEnvVarImpl>
              <!-- Not sure if this was required but saw VS did it and figured it couldn't hurt -->
              <option name="name" value="ASPNETCORE_LOGGING__CONSOLE__DISABLECOLORS" />
              <option name="value" value="true" />
            </DockerEnvVarImpl>
            <!-- Removed Akka.NET, Serilog/Seq configuration, etc. since it was specific to our project -->
          </list>
        </option>
        <option name="portBindings">
          <list>
            <DockerPortBindingImpl>
              <option name="containerPort" value="8080" />
              <!-- hostIp of 127.0.0.1 was required for us, but this may have to do with how we're using Akka .NET -->
              <option name="hostIp" value="127.0.0.1" />
              <option name="hostPort" value="5083" />
            </DockerPortBindingImpl>
            <DockerPortBindingImpl>
              <option name="containerPort" value="443" />
              <!-- hostIp of 127.0.0.1 was required for us, but this may have to do with how we're using Akka .NET -->
              <option name="hostIp" value="127.0.0.1" />
              <option name="hostPort" value="7280" />
            </DockerPortBindingImpl>
          </list>
        </option>
        <option name="commandLineOptions" value="--network=&quot;REDACTED&quot;" />
        <option name="sourceFilePath" value="Dockerfile" />
        <option name="volumeBindings">
          <list>
            <DockerVolumeBindingImpl>
              <!-- Note directory of /home/app to match the user we're running as -->            
              <option name="containerPath" value="/home/app/.microsoft/usersecrets" />
              <!-- NOTE: We make C:\REDACTEDAppData a symlink to the user-specific appdata folder. Our devs run a onetime command of, for example, "mklink /D C:\REDACTEDAppData C:\Users\SeanK\AppData\Roaming" from an admin command prompt -->
              <option name="hostPath" value="C:\REDACTEDAppData\Microsoft\UserSecrets" />
              <option name="readOnly" value="true" />
            </DockerVolumeBindingImpl>
            <DockerVolumeBindingImpl>
              <!-- Noticed that VS copied it here too, figured it couldn't hurt. -->            
              <option name="containerPath" value="/root/.microsoft/usersecrets" />
              <option name="hostPath" value="C:\REDACTEDAppData\Microsoft\UserSecrets" />
              <option name="readOnly" value="true" />
            </DockerVolumeBindingImpl>
            <DockerVolumeBindingImpl>
              <!-- Noticed that VS copied it here too, figured it couldn't hurt. -->            
              <option name="containerPath" value="/root/.aspnet/https" />
              <option name="hostPath" value="C:\REDACTEDAppData\ASP.NET\Https" />
              <option name="readOnly" value="true" />
            </DockerVolumeBindingImpl>
            <DockerVolumeBindingImpl>
              <!-- Note directory of /home/app to match the user we're running as -->            
              <option name="containerPath" value="/home/app/.aspnet/https" />
              <option name="hostPath" value="C:\REDACTEDAppData\ASP.NET\Https" />
              <option name="readOnly" value="true" />
            </DockerVolumeBindingImpl>
          </list>
        </option>
      </settings>
    </deployment>
    <!-- With the above setup, we can disable fast mode and SSL sharing -->            
    <EXTENSION ID="com.jetbrains.rider.docker.debug" isFastModeEnabled="false" isSslEnabled="false" />
    <method v="2" />
  </configuration>
</component>
```

## One more Step: A Symlink

One gap in Rider's Docker support currently is that it can't use environment variables etc. in Docker's volume mounting. But our user secrets folders are in our account folders on Windows. We don't want to have to change directories every time we check out the code. Symlinks to the rescue!

We now perform a one-time symlink when on-boarding to the project.

* Open a command prompt as administrator (NOTE: not PowerShell)
* Run `mklink /D C:\RedactedAppData C:\Users\[Your Username]\AppData\Roaming` (Replacing "Redacted" with your app's name.)


Rider's `Docker.run.xml` file references `C:\RedactedAppData` so once you make the link, things will work.
