---
layout: post
title: 'Building a Build Process: Introduction'
date: 2011-12-09 23:15:00.000000000 -05:00
comments: true
series: building-a-build-process
---


***Under Construction:**The language in these posts may be a little terse at first, but I'll be fleshing it out over time -- be sure to check back!]*

###Why Undertake This (Plus: Look at my Presentation!)
I've seen too many instances in various jobs and projects where the build/integration process is not afforded due diligence (or *any* diligence, really).

I decided I needed to do something about it. Part experiment, part challenge, part reference guide. I'm going to see if I can put together an entire continuous integration / build process for .NET environments from scratch.

Below, you can find [some slides from a presentation I gave at work][SS Link] (and yes, the design ideas are at times ripped directly from [Zach Holman's article][Holman Link] as I tried to emulate his style. He's awesome, and I'm shameless. Credit was given.) This talk highlighted the benefits of inte"great"ion and what I was about to undertake.

<iframe src="http://www.slideshare.net/slideshow/embed_code/10484958?rel=0" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px 1px 0; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe>
###My Goal
In short, dear reader, my end desire is to have a completely integrated build process for .NET using (almost) free and/or open-source tools, and to share my process with you.

The build process so far will include the following:

* Subversion repository on CentOS VM
* An ASP.NET MVC Project Added to the Source control
* Trac web site connected to Subversion repository on CentOS VM
* Build Server VM (Windows Server 2008 R2)
* CruiseControl.NET running on the Build Server
* Building the Project with MSBuild via CCNet
* Building a Release build via CCNet; if successful, publishes to AppHarber via a cloned git repository
* NUnit Tests
* NCover code coverage metrics
* SpecFlow User Acceptance Test / Feature Test coverage
* Selenium Server as a web driver to execute specflow tests
* Selenium Grid executing tests on multiple OSes / platforms
* Adding FxCop to the mix to check my coding standards
* Adding StyleCop to the mix to make sure the code is consistently written.
* Utilizing Nuget packages and Octopus to transform releases for different environments.

###Hoo-boy, Here We Go
It's a lofty goal -- especially for someone who's not a pro developer -- but I'm excited for everything I'm about to learn during this process.

Onward and Upward!

[SS Link]: http://www.slideshare.net/SeanKilleen1/integreation
[Holman Link]: http://zachholman.com/posts/slide-design-for-developers/