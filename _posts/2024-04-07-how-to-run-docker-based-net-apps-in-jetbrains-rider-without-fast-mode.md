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

So, here's the `Docker.run.xml` that worked for us, including a breakdown on each line
