---
title: "How (and Why) to Lobby Companies to Support .NET OSS"
layout: post
date: 2016-01-30 15:39:00.000000000 -05:00
excerpt: "The .NET Community needs to step up. You can help."
references:
 - title: "OpenHub, the open source network"
   url: https://www.openhub.net/
 - title: "the xUnit open source project on OpenHub : widgets page" 
   url: https://www.openhub.net/p/xunit/widgets 
   parenttitle: "OpenHub"
   parenturl: https://www.openhub.net/
 - title: "NancyFx Contributing Guide"
   url: https://github.com/NancyFx/Nancy/blob/master/CONTRIBUTING.md
   parenttitle: "NancyFx on Github"
   parenturl: https://github.com/NancyFx/Nancy
 - title: "Akka.NET Contributing Guide"
   url: https://github.com/akkadotnet/akka.net/blob/dev/CONTRIBUTING.md
   parenttitle: "Akka.NET on Github"
   parenturl: https://github.com/akkadotnet/akka.net
 - title: "Our Team"
   url: http://getakka.net/pages/team
   parenttitle: "Akka.NET"
   parenturl: http://getakka.net
 - title: "Up for Grabs"
   url: http://up-for-grabs.net/#/tags/.NET
 - title: "Contributing to Open Source on GitHub"
   url: https://guides.github.com/activities/contributing-to-open-source/
   parenttitle: "GitHub Guides"
   parenturl: https://guides.github.com
 - title: ".NET Foundation"
   url: https://github.com/dotnet
   parenttitle: "GitHub"
   parenturl: https://github.com
 - title: "Git Tutorials and Training"
   url: https://www.atlassian.com/git/tutorials/
   parenttitle: Atlassian
   parenturl: https://www.atlassian.com/
 - title: "Code School - Try Git"
   url: https://try.github.io/levels/1/challenges/1
 - title: "Git - the simple guide - no deep shit!"
   url: http://rogerdudler.github.io/git-guide/
 
comments: true
---
**Update:** I've purchased <http://AWider.NET> (empty right now) to take this project further. I've created [a GitHub repository](https://github.com/SeanKilleen/AWiderDotNet) and I hope you'll join me for some planning discussion in the [issues section](https://github.com/SeanKilleen/AWiderDotNet/issues). Let's help cast a wider .NET!

____

This is a follow-up to [my last post](http://SeanKilleen.com/2016/01/dotnet-oss-acceleration/). I wanted to provide a more concrete way for developers to help their companies get involved, and these thoughts are what came out. 

**Note:** While this article is geared primarily towards .NET developers and GitHub-based OSS projects, I think it applies more broadly as well. 

Many developers would like to see open-source projects thrive, or at least are aware of how important they are to the everyday ecosystem of .NET development. But, how can we begin to support that effort? The only answer is we need to have some skin in the game and start contributing more broadly. And the fastest path to this will be to get our companies to support us.

After my last post, there seemed to be a consensus on that point: 

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">Good write up. Companies who use OSS extensively and never contribute back are the biggest blocker right now IMO. <a href="https://t.co/gR5plHTYyS">https://t.co/gR5plHTYyS</a></p>&mdash; Itamar Syn-Hershko (@synhershko) <a href="https://twitter.com/synhershko/status/693471466180984832">January 30, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/sjkilleen">@sjkilleen</a> dude, I love your energy :-) I think you&#39;re on to something by focusing on the enabling of day-job contribution</p>&mdash; Adam Ralph (@adamralph) <a href="https://twitter.com/adamralph/status/693482878697508866">January 30, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

So, I wanted to reflect a little bit on how we, as .NET developers, might do better on this front and get our companies to support open-source efforts.

### First, Do a Little Research
Here's a good place to start. Devs, why not: 

* Look at the number of tools you use (start with the nuget packages or anything in a `lib` folder)
 * ...and likely, marvel at the sheer number of them. There are probably a ton. We stand on the shoulders of giants, and that's pretty cool. Let that gratitude sink in.
* Look at how much time or lines of code they save you vs trying to figure 1) how to tackle that problem and 2) how to implement their solution that you use currently with the level of quality it provides.
* Think about how many person-hours it would take you or your team to produce that sort of code.
* Think about how critical it is to your project's success. If it went away -- as in *poof*, disappeared from your code like it had never been there -- would it be easily replaceable? Would you need to scramble?
* Think about how often you come into contact with the library code itself (Shoved in a small corner of the project? Or sprinkled throughout?)
* Think about the average cost to a business per senior developer -- you're probably low-balling it.

A great tool for helping to think about and quantify these things is [OpenHub](https://www.openhub.net/), which provides stats and badges for a project -- see [this example using xUnit](https://www.openhub.net/p/xunit/widgets) for a number of stats on estimated cost.

Those dev-hours represent a big cost savings to your business thanks to the largely free work of others. And the criticality of those libraries and tools represent a long-term productivity risk to your business and its products if they're abandoned.

You're now armed with data. The next part is a little harder, but totally doable.

### What's the Goal Here?
In exchange for the huge amount of value that OSS provides your respective companies, the OSS community needs them to contribute back a small fraction of resources to help keep it alive. 

While this could be in the form of a monetary donation, the best option is to provide time for developers to become a part of the community and help contribute to it and grow it. That's where the hurt is now, and that's what needs to be addressed.

### This Could be an "everyone wins" situation! But you have to sell it.
There are a ton of benefits to companies allowing their employees to contribute back. They may not see productivity gains initially, due to losing some hours, but think of the following:

* They gain a long-term commitment to the tools they (and you) already depend upon. It's a commitment they know they can trust, because they're the ones making it.
* A company benefits when developers understand the tools they're working with. The tools become less of a black box when developers understand the internals. In many cases, this helps developers use those tools better. It also teaches top-notch development techniques that help make those libraries possible. 
* Increased confidence of your development team: A lot of developers, especially in enterprise shops, believe that "smarter people than us are the ones who write those things." How big of a confidence boost would it be to jump in and understand that it's all just code, and that they can contribute? It may spark some new ideas in those developers, but at worst they'll be able to more confidently approach your code. 
* Supporting OSS library authors frees those same high-quality developers up to devote more time to new efforts that continue to drive the ecosystem forward. They're visionaries who are making things happen -- giving them the maximum bandwidth to do that benefits everyone.
* Do you as a dev have a feature that you wished was in your favorite library? In many cases, if it's aligned with the authors' goals, they'll help you build it! This improves your situation as a developer, and by extension improves your company's software. 
* Lastly, it's great PR. Developers want to come to companies who are forward thinking and allow developers to contribute back. They want to work for people who are responsible members of the software development ecosystem. And a lot of times, those libraries will thank you on their websites and within their repositories. 

### Devs: OSS involvement isn't as scary as it seems -- I promise.
I totally hear you. Not long ago I was very hesitant about OSS in .NET -- I didn't know where to start. It was like showing up to a party where everyone else was already really cool and talking to each other and nobody knew you. Saying hi or suggesting a change felt like butting in.

But the thing is, when you finally say hello at this party, you realize that most people are there just waiting for the chance to be awesome to you. It turns out that a lot of OSS folks are mentors and teachers, because that's a big part of cultivating a successful community. And they're the ones looking for your involvement! So chances are, you'll get a reasonably warm reception.

* **What if I don't know what a project expects from my contributions?** Most larger OSS projects have a contributing guide (see [NancyFX's](https://github.com/NancyFx/Nancy/blob/master/CONTRIBUTING.md) or [Akka.NET's](https://github.com/akkadotnet/akka.net/blob/dev/CONTRIBUTING.md) for examples) 
* **I'm not that familiar with Git**: Folks will totally help you through the process, even if you don't get it at first. There are [plenty](https://www.atlassian.com/git/tutorials/) [of](https://try.github.io/levels/1/challenges/1) [guides](http://rogerdudler.github.io/git-guide/) [available](https://www.google.com/webhp?q=git+tutorial). The [Petabridge](http://petabridge.com) folks recently did [a YouTube video on it](https://www.youtube.com/watch?v=8UguQzmswC4) as well. 
* **I'm not that familiar with a quality development process**: Sometimes devs hold off on contributing because they don't know how to write unit tests or get familiar with certain concepts. But remember -- the community more likely than not will help you, and that gets you up to speed at the same time that it makes connections and helps you give back. Everyone wins, and you upping your dev skills is a big part of that win.
* **I need to spend time building my brand / resume**: Uhhh, OSS is a fantastic way to do that. I can offer a personal example: I jumped in in a very small way to help out [Akka.NET](http://getakka.net) with some of their documentation and a script to add some licensing comments to code. I thought it was pretty minor, but it turned out to help them clear a hurdle in getting to v1. They thanked me in front of a room of people I looked up to at dotNetFringe, and [I'm currently listed on their contributors page!](http://getakka.net/pages/team) How's that for brand-building? I've met a ton of people that I really respect in the community, and I feel more like a member now than I ever have.
* **I'm not sure where to jump in**: Yeah, this is a hard question. The good news is, there's an easy answer: start anywhere. There's a great site, [Up-for-grabs.net](http://up-for-grabs.net/#/tags/.NET) that features projects that are specifically asking for help. Find one that looks cool enough to you and jump in!
* **I've seen people react badly to newcomers before.** Well, there are some cultural rules to follow ([GitHub has a nice guide](https://guides.github.com/activities/contributing-to-open-source/) on how to do it well). Or those people may have been having a bad day. Or maybe they're jerks and you should look for a new OSS project to contribute to. 
* **Can't I just keep relying on Microsoft to do it for me?** Well, yes and no. In case you haven't noticed, [Microsoft is embarcing OSS](https://github.com/dotnet) more than ever before. Which is awesome. You could choose to rely on others to provide your tools, but that limits you as a developer and allows other people to create the future of your industry for you. Why not at least give it a shot and see what it's all about? Ownership and having a stake in things can feel awesome. 

## What do you think? 
What other obstacles exist to lobbying companies to support OSS? What other ideas do you have on how we might tackle this together as a community? I'd love to discuss this with you in the comments.
