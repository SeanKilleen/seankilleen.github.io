---
layout: single
author_profile: true
title: My Toolbox
modified: 2016-12-27T23:25:00.000000-05:00
show_edit_link: true
---
There are so many great tools in this industry that I rely on on a regular basis. I thought it would be fitting to highlight them on a continuously updated page so that people can see what I recommend developers use and why.

The items below are links -- feel free to click and explore!

## Browser Extensions

* **[ActiveInbox] [ActiveInbox]**: (Chrome only) This is a great productivity web app that I use to enhance my GMail experience. They're the reason why I often have zero messages in my inbox and can find things quickly.
* **[CheckerPlus for Gmail] [CheckerPlus for Gmail]**: A fantastic extension to help me quickly see incoming e-mail from multiple Gmail accounts.
* **[Feedly] [Feedly]**: The best RSS Reader app, in my opinion.
* **[Pocket](https://getpocket.com)**: Save articles and events for later reading.
* **[1Password] [1Password]**: My choice of password manager.
* **[ArtooJS] [ArtooJS]** (Scraping) - A bookmarklet that injects a javascript library into any page on command that will enable many scraping/parsing scenarios more easily.
* **[Toggl] [Toggl]** - A tool to track your time. Integrates with a gazillion web sites to put the timer right there, which means I actually use it. Also has a great mobile app.
* **[BlackMagic] [BlackMagic]** - A Twitter analytics extension. I don't use Twitter much anymore, having moved to Mastodon, but this was a really insightful tool, even for personal use. Loved it since the early days.
* **[Personal Blocklist] [PersonalBlocklist]** - Helps me remove unwanted sites from my Google search results.

## Editors

* **[Visual Studio] [Visual Studio]** - The quintessential editor for .NET-based applications.
* **[VSCode] [VSCode]** - A free, lightweight, open-source, cross-platform editor also supported by Microsoft. Great for web work and C#/F# work. Very extensible.

## Visual Studio Extensions / Tools

* **[ReSharper] [ReSharper]** - The ultimate "second pair of eyes" for development using Visual Studio. Additional syntax highlighting, test running, recommendations, advanced search, and a slew of other features. An almost indispensable product for .NET Development. A commercial product from JetBrains.
* **[NDepend] [NDepend]** - A great static analysis toolset for .NET projects. Particularly for large legacy projects, this has a number of great warnings, and the ability to gain tons of different insights into how the code is currently situated. Includes the ability to spelunk code with custom queries and rules.
* **[SpecFlow] [SpecFlow]** - A helpful tool on .NET for doing BDD development. SpecFlow will generate specification files from human readable tests that can then be connected to a unit testing framework for execution. This helps ensure that the code is adhering to the requirements, and that acceptance tests are automated as much as possible.
* **[NCrunch] [NCrunch]** - An automated test runner that integrates with Visual Studio. NCrunch runs only the tests for code that's changed and provides immediate feedback in the IDE. Can greatly reduce development time, especially when taking a TDD approach.

## VS Code Extensions

* **[File watcher extension](https://seankilleen.com/2018/08/vscode-tip-watch-files/)** - Comes in handy often
* **CodeTour** - Show someone around a repository using config that can be stored in the repository. Great for orienting to new projects!
* **indent-rainbow** - Nice visual way to show levels of indents.
* **JSON Escaper** - When you need it, it's a wonderful thing to have.
* **JSON Tools** - Easily flatten JSON etc.
* **Markdownlint** - An indispensible part of my writing process, made easier with the extension to show me issues in the editor.
* **VS Code Live Share** - this is awesome, allows you to live code with one or more people remotely. Super for remote pairing / mobbing.
* **Docker Extension** - great extension; lets me easily see in a sidebar what containers are running, lets me quickly open a shell into them, etc.
* **GitLens** - great UI integration of various pieces of git information
* **Markdown shortcuts** - I write a lot of markdown for the blog. Markdown shortcuts is really helpful with quick formatting changes (e.g. `CTRL + B` bolds text). Super useful.

## Nuget Packages Worth Knowing

* **[xUnit] [xUnit]** - a modern unit testing library for .NET. Used by the Microsoft team on the .NET framework itself, and fully compatible with .NET Core. Amazing tooling, fast execution, and a short learning curve. It's my testing framework of choice.
* **[NUnit] [NUnit]** - A great alternative to xUnit. I think everyone should know both, personally.
* **[FluentAssertions] [FluentAssertions]** - Sometimes, assertions are hard to read in tests and cause confusion. FluentAssertions provides an easily readable unified way forward. If a variable called "myValue" should be equal to 5, NUnit's assert syntax might be `Assert.That(myValue, Is.EqualTo(5))`. With FA, that becomes `myValue.Should().Be(5)`. It also has great built-in assertions, such as `ShouldBeEquivalentTo`, `ShouldContain()`, and `ShouldNotBeEmpty()`
* **[Serilog] [Serilog]** - A structured logging library for .NET. Structured logging beats the pants off of regular text logging because you can surface more information about the structure of the log message itself.
* **[NBench] [NBench]** - Used to test highly asynchronous / concurrent systems such as Akka.NET, NBench is a great choice for performance profiling your code. Particularly for systems that will find themselves under heavy load, it's important to profile the code and set a baseline so that performance doesn't degrade over time.
* **[ElasticSearch & ElasticSearch.NET] [ElasticSearch & ElasticSearch.NET]** - If you need to surface complex queries across massive amounts of data and have the results be lightning-fast, this is a great place to begin.
* **[Akka.NET] [Akka.NET]** - A framework/library for building actor-based systems in .NET. The Actor model is a paradigm for creating distributed, clustered, massively-scalable, self-healing, and reactive systems. And it makes that all reasonably easy. If that sounds awesome, it's only because it is awesome.
* **[CsvHelper] [CsvHelper]** - A great tool for pulling in and processing data to/from CSV files.
* **[Moq] [Moq] / [FakeItEasy] [FakeItEasy]** - Unit testing projects need mocking libraries. Moq and FakeItEasy are two good ones.
* **[FluentValidation] [FluentValidation]** - Validating complex data is hard. Like, really hard. And custom validation logic often fails at handling things like different contexts or testability without becoming incredibly bloated. FluentValidation is a great library that assists in validating business objects in different contexts in a friendly to use way.
* **[Humanizer] [Humanizer]** - A great tool for manipulating and displaying strings, enums, dates, times, numbers, and quantities. If you're wondering how to display pluralization, different cases, truncate text, etc. This library is hugely helpful.

## Favorite ReSharper Extensions

ReSharper is such a popular plugin that I have my own favorite extensions for it, source-able from the ReSharper plugins menu:

* **ReSpeller** - Checks for typos in your code. Has saved me from a bad method name many a time.
* **Enhanced Tooltip** - Better visual tooltips when mousing over code.
* **Cyclomatic Complexity** - Shows when a method is growing too complex and should be refactored.
* **Heap Allocations viewer** - Helpful to surface when you're accidentally creating an object 1,000 times in a loop. :)
* **Exceptional**: Analyzes exceptions that might be thrown and is a nice reminder to be handling them.

## Design

* **[Pingendo] [Pingendo]** - An awesome free app if you plan on building a site with Bootstrap. Pingendo is an app for windows or Mac that allows you to visually layout mockups / sites using re-usable bootstrap components, and will then generate the HTML required to produce those components on a web page. A nice tool that makes getting started really quick & easy for a bootstrap-enabled web site.
* **[The Pencil Project] [The Pencil Project]** – A free/OSS wire-framing tool for all platforms.

## Helpful Windows apps for Coders

* **[GitHub Desktop for Windows] [GitHub Desktop for Windows]** - Work with GitHub projects on Windows? This makes it dead simple.
* **[Fiddler] [Fiddler]** - Send and profile http requests; very useful when working with API projects.
* **[Slack] [Slack]** - The chat client that everyone knows and loves
* **[Camtasia] [Camtasia]** - Doing a screencast or demo video? This is commercial software but probably your best bet.
* **[ScreenToGif] [ScreenToGif]** - Drag over a portion of your screen, hit record, and it will capture the output as an animated gif.
* **[F.lux] [F.lux]** - Stops your screen from killing your eyes.
* **[Chocolatey] [Chocolatey]** - A package management script for windows, so you can install and update software in a similar way to apt-get. I've run one command after a fresh install and ha
* **[Greenshot] [Greenshot]** - An excellent free tool for capturing screenshots and saving to various destinations.
* **[ImgBurn] [ImgBurn]** - A tool for creating disc images
* **[LogParser 2.x Studio] [LogParser 2.x Studio]** - A tool for easily loading and querying log files in classic formats (such as IIS logs)

[ActiveInbox]: http://activeinboxhq.com
[CheckerPlus for Gmail]: https://chrome.google.com/webstore/detail/checker-plus-for-gmail/oeopbcgkkoapgobdbedcemjljbihmemj?hl=en
[Feedly]: http://Feedly.com
[1Password]: http://1password.com
[ArtooJS]: https://medialab.GitHub.io/artoo/
[Visual Studio]: https://www.visualstudio.com/vs/
[VSCode]: http://code.visualstudio.com/
[ReSharper]: https://www.jetbrains.com/resharper/
[NDepend]: http://www.ndepend.com/
[SpecFlow]: http://specflow.org/
[NCrunch]: http://www.ncrunch.net/
[xUnit]: https://xunit.net/
[FluentAssertions]: http://www.fluentassertions.com/
[Serilog]: https://serilog.net/
[NBench]: https://GitHub.com/petabridge/NBench
[ElasticSearch & ElasticSearch.NET]: https://GitHub.com/elastic/elasticsearch-net
[Akka.NET]: http://getakka.net/
[CsvHelper]: https://joshclose.GitHub.io/CsvHelper/
[Moq]: https://GitHub.com/moq/moq4
[FakeItEasy]: https://fakeiteasy.GitHub.io/
[FluentValidation]: https://GitHub.com/JeremySkinner/FluentValidation
[Humanizer]: https://GitHub.com/Humanizr/Humanizer
[Pingendo]: http://pingendo.com/
[The Pencil Project]: http://pencil.evolus.vn/
[GitHub Desktop for Windows]: https://desktop.GitHub.com/
[Fiddler]: https://www.telerik.com/fiddler
[Slack]: https://slack.com/
[Camtasia]: https://www.techsmith.com/camtasia.html
[ScreenToGif]: http://www.screentogif.com/
[F.lux]: https://justgetflux.com/
[Chocolatey]: https://chocolatey.org/
[Greenshot]: http://getgreenshot.org/
[ImgBurn]: http://www.imgburn.com/
[LogParser 2.x Studio]: https://gallery.technet.microsoft.com/office/Log-Parser-Studio-cd458765
[Toggl]: https://toggl.com/
[PersonalBlocklist]: https://addons.mozilla.org/en-US/firefox/addon/personal-blocklist/
[BlackMagic]: https://BlackMagic.so
[NUnit]: https://nunit.org
