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
In most cases, containerized .NET apps run just fine "out of the box". IDEs such as Visual Studio and JetBrains Rider provide a helpful experience called "Fast mode" that uses some magic to put your files where they need to be inside of a container, rather than rebuilding it each time you start up. This is helpful!

However, in some cases -- such as one I experienced recently -- a container is not well-suited for "fast mode". There are ways to disable this in Visual Studio, but our team needed a little extra help to get it working with JetBrains Rider (which we also love!)

So, here's the `Docker.run.xml` that worked for us, including a breakdown on each line, and one additional step we had to take.

## The `Docker.run.xml` File, With Comments

```xml
```

## One more Step: A Symlink

One gap in Rider's Docker support currently is that it can't use environment variables etc. in Docker's volume mounting. But our user secrets folders are in our account folders on Windows. We don't want to have to change directories every time we check out the code. Symlinks to the rescue!

We now perform a one-time symlink when on-boarding to the project:

```
```

Then, we reference the symlinked directory in our `Docker.run.xml` file.
