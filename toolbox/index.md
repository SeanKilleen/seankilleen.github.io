---
layout: page
title: My Toolbox
tags: [info, meta, tools]
modified: 2016-12-27T23:25:00.000000-05:00
image:
  feature: sample-image-2-short.jpg
  credit: WeGraphics
  creditlink: http://wegraphics.net/downloads/free-ultimate-blurred-background-pack/
---
There are so many great tools in this industry that I rely on on a regular basis. I thought it would be fitting to highlight them on a continuously updated page so that people can see what I recommend developers use and why.

The items below are links -- feel free to click and explore!

## Chrome Extensions
* **[ActiveInbox] [ActiveInbox]**: This is a great productivity web app that I use to enhance my GMail experience. They're the reason why I often have zero messages in my inbox and can find things quickly.
* **[CardCounter for Trello] [CardCounter for Trello]**: This extension is simple -- it adds a count of cards to every Trello List.
* **[CheckerPlus for Gmail] [CheckerPlus for Gmail]**: A fantastic extension to help me quickly see incoming e-mail from multiple Gmail accounts.
* **[Feedly] [Feedly]**: The best RSS Reader app, in my opinion.
* **[Github Selfies] [Github Selfies]**: Allows you to take selfie animations while commenting on issues or pull requests in Github.
* **[Instapaper] [Instapaper]**: Save articles and events for later reading.
* **[LastPass] [LastPass]**: My choice of password manager.
* **[XMarks] [XMarks]**: Bookmark synchronization across multiple browsers and devices. 
* **[ArtooJS] [ArtooJS]** (Scraping) - A bookmarklet that injects a javascript library into any page on command that will enable many scraping/parsing scenarios more easily.

## Editors
* **[Visual Studio 2015] [Visual Studio 2015]** - The quintessential editor for .NET-based applications.
* **[VSCode] [VSCode]** - A free, lightweight, open-source, cross-platform editor also supported by Microsoft. Great for web work and C#/F# work. Very extensible.
* **[Atom Editor] [Atom Editor]** - Another popular/free/public/cross-platform editor

## Visual Studio Extensions / Tools
* **[ReSharper] [ReSharper]** - The ultimate "second pair of eyes" for development using Visual Studio. Additional syntax highlighting, test running, recommendations, advanced search, and a slew of other features. An almost indispensable product for .NET Development. A commercial product from JetBrains.
* **[NDepend] [NDepend]** - A great static analysis toolset for .NET projects. Particularly for large legacy projects, this has a number of great warnings, and the ability to gain tons of different insights into how the code is currently situated. Includes the ability to spelunk code with custom queries and rules.
* **[SpecFlow] [SpecFlow]** - A helpful tool on .NET for doing BDD development. SpecFlow will generate specification files from human readable tests that can then be connected to a unit testing framework for execution. This helps ensure that the code is adhering to the requirements, and that acceptance tests are automated as much as possible.
* **[NCrunch] [NCrunch]** - An automated test runner that integrates with Visual Studio. NCrunch runs only the tests for code that's changed and provides immediate feedback in the IDE. Can greatly reduce development time, especially when taking a TDD approach.
* **[Storyteller] [Storyteller]** – Another form of automated acceptance test tooling that is gaining popularity. With Storyteller, developers can surface certain types of functionality to the tool, which will then allow business users to craft scenarios any way they choose. This can be hugely important in a collaborative environment where the dev team wants the users to explore their own testing.

## Nuget Packages Worth Knowing
* **[xUnit] [xUnit]** - a modern unit testing library for .NET. Used by the Microsoft team on the .NET framework itself, and fully compatible with .NET Core. Amazing tooling, fast execution, and a short learning curve. It's my testing framework of choice.
* **[FluentAssertions] [FluentAssertions]** - Sometimes, assertions are hard to read in tests and cause confusion. FluentAssertions provides an easily readable way. If a variable called "myValue" should be equal to 5, NUnit's assert syntax might be Assert.That(myValue, Is.EqualTo(5)). With FA, that becomes "myValue.Should().Be(5)". It also has great built-in assertions, such as "ShouldBeEquivalentTo", "ShouldContain()", and "ShouldNotBeEmpty()"
* **[Serilog] [Serilog]** - A structured logging library for .NET. Structured logging beats the pants off of regular text logging because you can surface more information about the structure of the log message itself.
* **[NBench] [NBench]** - Used to test highly asynchronous / concurrent systems such as Akka.NET, NBench is a great choice for performance profiling your code. Particularly for systems that will find themselves under heavy load, it's important to profile the code and set a baseline so that performance doesn't degrade over time.
* **[ElasticSearch & ElasticSearch.NET] [ElasticSearch & ElasticSearch.NET]** - If you need to surface complex queries across massive amounts of data and have the results be lightning-fast, this is a great place to begin.
* **[Akka.NET] [Akka.NET]** - A framework/library for building actor-based systems in .NET. The Actor model is a paradigm for creating distributed, clustered, massively-scalable, self-healing, and reactive systems. And it makes that all reasonably easy. If that sounds awesome, it's only because it is awesome.
* **[CsvHelper] [CsvHelper]** - A great tool for pulling in and processing data to/from CSV files.
* **[Squirrel] [Squirrel]** - "It's like ClickOnce but Works". A free/OSS way to package app installers in a Click-once way and handle things such as auto-updating software when new versions are released.
* **[MassTransit] [MassTransit]** - A free / OSS message bus platform for .NET that integrates with Azure ServiceBus, RabbitMQ, etc. For more reliable message handling and easier pub/sub.
* **[Toggler] [Toggler] (feature toggling)** - Feature toggling is important, especially when beta-testing features or in large software environments where enabling a feature may cause unwanted impact (or when a feature isn't yet fully complete). Feature toggling enables shorter branches because code paths can be committed that will not be executed unless the toggle is enabled. Toggler is  great .NET library for doing that.
* **[Github's Scientist.NET] [Github's Scientist.NET]** - A library for carefully refactoring critical paths. It basically creates A/B testing for paths through your code so that you can see if  certain paths begin failing after refactoring, or when you try a different approach. A way to know that live code will have an issue before fully flipping the switch on it.
* **[Moq] [Moq] / [FakeItEasy] [FakeItEasy]** - Unit testing projects need mocking libraries. Moq and FakeItEasy are two good ones.
* **[Autofac] [Autofac] / [Ninject] [Ninject] / [StructureMap] [StructureMap]** - Dependency injection can be a pain. These tools will enable you to do so much easier. They all have their various quirks but get the job done. 
* **[LiteGuard] [LiteGuard]** - Defensive programming is important. This includes guard clauses – pieces of code that run in the beginning of a method to make sure that the inputs are correct. LiteGuard is a nice, small, fast library that encapsulates a number of these common guard clauses and saves some repetition.
* **[FluentValidation] [FluentValidation]** - Validating complex data is hard. Like, really hard. And custom validation logic often fails at handling things like different contexts or testability without becoming incredibly bloated. FluentValidation is a great library that assists in validating business objects in different contexts in a friendly to use way.
* **[Humanizer] [Humanizer]** - A great tool for manipulating and displaying strings, enums, dates, times, numbers, and quantities. If you're wondering how to display pluralization, different cases, truncate text, etc. This library is hugely helpful.
* **[Selenium] [Selenium]** - A library for driving a web browser, hugely helpful in acceptance test scenarios. The website looks out of date, but the tool is rock solid. The selenium grid can also be used to test multiple browsers on multiple OSes at once.

## Favorite ReSharper Extensions
ReSharper is such a popular plugin that I have my own favorite extensions for it, sourceable from the ReSharper plugins menu:

* **ReSpeller** - Checks for typos in your code. Has saved me from a bad method name many a time.
* **Enhanced Tooltip** - Better visual tooltips when mousing over code.
* **Cyclomatic Complexity** - Shows when a method is growing too complex and should be refactored.
* **Heap Allocations viewer** - Helpful to surface when you're accidentally creating an object 1,000 times in a loop. :) 

## Design
* **[Pingendo] [Pingendo]** - An awesome free app if you plan on building a site with Bootstrap. Pingendo is an app for windows or Mac that allows you to visually layout mockups / sites using re-usable bootstrap components, and will then generate the HTML required to produce those components on a web page. A nice tool that makes getting started really quick & easy for a bootstrap-enabled web site.
* **[Balsamiq] [Balsamiq]** - A popular commercial tool for mockups & workflows 
* **[The Pencil Project] [The Pencil Project]** – A free/OSS wire-framing tool for all platforms. 

## Build & Deployment Tolls
* **[NCover] [NCover] / [dotCover] [dotCover]** - A code coverage tool to help determine how many of your code paths are actually covered by unit tests.
* **[TeamCity] [TeamCity]** - A build pipeline tool popular in many .NET shops, TeamCity is a great choice for continuous integration pipelines and ensuring a rigorous quality standard.
* **[Jenkins] [Jenkins]** – A worse version of TeamCity. :) No but seriously, while the UI is lacking, it's highly customizable. For example, the BlueOcean plugin for Jenkins is an incredibly promising way to visualize and parallelize build pipelines.
* **[OctopusDeploy] [OctopusDeploy]** - Takes over where TeamCity leaves off. When TeamCity produces a package of code, OctopusDeploy is the best tool for creating deployments, transforming configurations, and visualizing the process to promote your build through your various environments, all the way through to production.
* **[RoundhousE] [RoundhousE]** - A database migration utility for .NET using SQL Files and versioning based on source control. A popular alternative to EntityFramework code-first migrations.
* **[PayPal's AATT] [PayPal's AATT]** - A NodeJS baased toolkit for automating the accessibility testing of web pages.
* **[PhantomJS] [PhantomJS]** - A headless webkit-based browser that can be used to run acceptance tests quickly and output screenshots of the results.

## Infrastructure / Ecosystem Tools
* **[Seq] [Seq]** - A commercial tool for searching and visualizing sturcture logs such as those produced by Serilog. Makes it insanely easy to search logs to diagnose problems. Great price points for almost any business. I used this with great success on a commercial project a little while back.
* **[Terraform] [Terraform]** - Sometimes your app needs a lot of infrastructure, or you need to manage that across cloud providers. Terraform is a tool that allows you to write out your infrastructure (e.g. 3 servers, 2 network switches, some firewall rules, etc.) and then spin up a new environment or apply changes to an existing environment. A breakthrough for deploying application infrastructure in a reliable way without huge handoffs between the "dev" and "ops" pieces of DevOps.
* **[MiniProfiler] [MiniProfiler]** - A great profiler that shows you how long things take right within your web app, profiling database requests and surfacing common issues. Originally built by the folks at StackExchange, so it's battle-tested.
* **[Opserver] [Opserver]** - A monitoring system used by the folks at StackExchange. Could be very helpful for even a basic .NET shop. New monitoring pieces being added all the time.
* **[StackExchange's Blackbox] [StackExchange's Blackbox]** - A way to safely store secrets in source control without compromising security or making it super annoying for a team to work with.
* **[Nagios] [Nagios]** - A free Linux-based monitoring system that can be huge help in keeping systems up and running. Lots of easy ways to get started with it as well.
* **[OTRS] [OTRS]** - An IT Service Management tool. If you need a ticketing system, helpdesk system, or CMDB that adheres to ITIL principles and is free/reasonably easy to setup, look no further.

## Helpful Windows apps for Coders
* **[Github Desktop for Windows] [Github Desktop for Windows]** - Work with Github projects on Windows? This makes it dead simple.
* **[ScriptCS] [ScriptCS]** - A way of writing scripts in C# if you hate powershell.
* **[Fiddler] [Fiddler]** - Send and profile http requests; very useful when working with API projects.
* **[Slack] [Slack]** - The chat client that everyone knows and loves
* **[Camtasia] [Camtasia]** - Doing a screencast or demo video? This is commercial software but probably your best bet.
* **[ScreenToGif] [ScreenToGif]** - Drag over a portion of your screen, hit record, and it will capture the output as an animated gif.
* **[F.lux] [F.lux]** - Stops your screen from killing your eyes.
* **[Chocolatey] [Chocolatey]** - A package management script for windows, so you can install and update software in a similar way to apt-get. I've run one command after a fresh install and ha
* **[Greenshot] [Greenshot]** - An excellent free tool for capturing screenshots and saving to various destinations.
* **[ImgBurn] [ImgBurn]** - A tool for creating disc images
* **[Virtual CloneDrive] [Virtual CloneDrive]** – a good free tool to mount disc images.
* **[LogParser 2.x Studio] [LogParser 2.x Studio]** - A tool for easily loading and quering log files in classic formats (such as IIS logs)
* **[RDCMan] [RDCMan]** - A tool for managing many remote desktop connections. Useful in large client environments where you may need to remote into many machines.

[ActiveInbox]: http://activeinboxhq.com
[CardCounter for Trello]: https://chrome.google.com/webstore/detail/cardcounter-for-trello/miejdnaildjcmahbhmfngfdoficmkdhi?hl=en
[CheckerPlus for Gmail]: https://chrome.google.com/webstore/detail/checker-plus-for-gmail/oeopbcgkkoapgobdbedcemjljbihmemj?hl=en
[Feedly]: http://Feedly.com
[Github Selfies]: https://chrome.google.com/webstore/detail/github-selfies/ldnpkdnkgkogfnahcnldaedcoadjbkbl
[Instapaper]: http://Instapaper.com
[LastPass]: http://lastpass.com
[XMarks]: http://xmarks.com
[ArtooJS]: https://medialab.github.io/artoo/
[Visual Studio 2015]: https://www.visualstudio.com/vs/
[VSCode]: http://code.visualstudio.com/
[Atom Editor]: https://atom.io/
[ReSharper]: https://www.jetbrains.com/resharper/
[NDepend]: http://www.ndepend.com/
[SpecFlow]: http://specflow.org/
[NCrunch]: http://www.ncrunch.net/
[Storyteller]: http://storyteller.github.io/
[xUnit]: https://xunit.github.io/
[FluentAssertions]: http://www.fluentassertions.com/
[Serilog]: https://serilog.net/
[NBench]: https://github.com/petabridge/NBench
[ElasticSearch & ElasticSearch.NET]: https://github.com/elastic/elasticsearch-net
[Akka.NET]: http://getakka.net/
[CsvHelper]: https://joshclose.github.io/CsvHelper/
[Squirrel]: https://github.com/Squirrel/Squirrel.Windows
[MassTransit]: http://masstransit-project.com/
[Toggler]: https://github.com/manojlds/Toggler
[Github's Scientist.NET]: https://github.com/github/Scientist.net
[Moq]: https://github.com/moq/moq4
[FakeItEasy]: https://fakeiteasy.github.io/
[Autofac]: https://autofac.org/
[Ninject]: http://www.ninject.org/
[StructureMap]: http://structuremap.github.io/
[LiteGuard]: https://github.com/adamralph/liteguard
[FluentValidation]: https://github.com/JeremySkinner/FluentValidation
[Humanizer]: https://github.com/Humanizr/Humanizer
[Selenium]: http://www.seleniumhq.org/
[Pingendo]: http://pingendo.com/
[Balsamiq]: https://balsamiq.com/
[The Pencil Project]: http://pencil.evolus.vn/
[NCover]: https://www.ncover.com/
[dotCover]: https://www.jetbrains.com/dotcover/
[TeamCity]: https://www.jetbrains.com/teamcity/
[Jenkins]: https://jenkins.io/
[OctopusDeploy]: https://octopus.com/
[RoundhousE]: https://github.com/chucknorris/roundhouse
[PayPal's AATT]: https://github.com/paypal/AATT
[PhantomJS]: http://phantomjs.org/
[Seq]: https://getseq.net/
[Terraform]: https://www.terraform.io/
[MiniProfiler]: http://miniprofiler.com/
[Opserver]: https://github.com/opserver/Opserver
[StackExchange's Blackbox]: https://github.com/StackExchange/blackbox
[Nagios]: https://www.nagios.org/
[OTRS]: https://www.otrs.com/