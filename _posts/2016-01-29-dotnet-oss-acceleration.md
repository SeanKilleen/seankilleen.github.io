---
title: "How can we Accelerate the .NET OSS Ecosystem?"
 
date: 2016-01-30 00:33:00.000000000 -05:00
excerpt: "Itamar Syn-Hershko got me thinking."
references:
 - title: Itamar Syn-Hershko
   url:  http://twitter.com/synhershko
   parenttitle: Twitter
   parenturl: http://twitter.com
 - title: "Open-source and .NET - it's not picking up"
   url: http://code972.com/blog/2016/01/93-open-source-and-net-its-not-picking-up
   parenttitle: "Code972 :: Coding from the back of a camel"
   parenturl: http://code972.com
 - title: "WeWorkRemotely"
   url: https://weworkremotely.com/
 - title: ".NET Fringe"
   url: http://dotnetfringe.org/
   
comments: true
---
**A brief update:** To keep this conversation going, I authored an additional post: [How (and Why) to Lobby Companies to Support .NET OSS](http://seankilleen.com/2016/01/how-and-why-to-lobby-for-oss/)

___

I was lying in bed, getting ready to call it an early Friday evening, when I came across a blog post. 

[Itamar Syn-Hershko](http://twitter.com/synhershko) is someone I have a lot of respect for in the .NET Community. I've seen him as someone involved with Lucene.NET and RavenDB. More recently, I've known him as someone who helped run the [.NET Fringe conference](http://dotnetfringe.org/) in April that I was lucky enough to attend. He also helped me squash a pull request for the first time (I butchered it if I recall correctly).

So his blog post, [Open-source and .NET - it's not picking up](http://code972.com/blog/2016/01/93-open-source-and-net-its-not-picking-up), took me by surprise. Since April, when I attended [.NET Fringe](http://dotnetfringe.org/) and met some fantastic people, I've been slowly pulled into the .NET open-source ecosystem, dipping my toes in the water and trying to help here and there. To hear someone like Itamar lament the state of the ecosystem made me really take notice.

Go ahead and read his post -- I'll wait. 

## Some of the challenges to OSS On-boarding in the .NET World
I want this post to be more about ideas for fixing things than summarizing what Itamar said or explaining it, but I think these will help provide some context and highlight some of the "immaturity" I'll speak of later. Some of the challenges I've seen or personally experienced include:

* **Immature development process/approach**: In this case, OSS is out there, but it's so high up on the hierarchy of needs for companies who are just struggling to churn out software. I'm not on board with this attitude, but I think it's important to acknowledge that it exists.
* **Organizational fear of OSS, e.g. security risk**: This stems from process immaturity and a fear of owning one's product/software. If only MS software is used and something goes wrong, devs can always blame MS or companies can call them for support. In an open-source ecosystem, a greater degree of understanding and ownership is required, and I think it can be tough for shops to take that leap.
* **Still getting used to consuming OSS**: Once companies acknowledge OSS, it can be overwhelming just to think about *using* all of the packages, let alone trying to contribute back. It's challenging enough just to get your code to work with theirs. 
* **How do I know what to focus on?**: This has been a challenge for me specifically. I'm overwhelmed by all the awesome things I want to commit to / work on, only to face reality and understand that there's no way I can do it all. How does one focus? I'm sure that Itamar didn't sign up for open-source knowing he'd be an awesome match for Lucene.NET and be able to focus a lot of effort and drive there. How can we point ourselves towards finding projects where we can make a home? And also, how do we do this more quickly, without being overwhelmed? 
* **Where the hell do you get all this time from?**: How do my OSS heroes/heroines do it? How do you make OSS a part of your life in a meaningful way? Some form companies around their library and the ecosystem/market demands they work on it. Some are consultants using the tools who make their own schedules and perhaps budget time for it instead of billable work. Some have companies that sponsor the project with their time. Some have companies that support 20% time and they choose to use it in this way. Some just don't sleep or are insanely passionate or are less social and don't mind living in code 90% of the time. Does someone need to have one of those things be true in order to be able to make an impact?

## So, what can we do?
What can we do to help companies help us help the software that helps us help our companies? [^1]

I agree that we can do better, and my brain started churning on concrete ways we might approach this. I would love some feedback on them, and if anyone feels really passionately about it, maybe I can run with one of them.

### .NET OSS Involvement as a Maturity Model
I keep wondering if some sort of a maturity model is applicable here. Every company is at the stage of this evolution. Many are in the dark ages (no Nuget, no non-Microsoft, banning open source, etc.) and some are at the forefront, using and contributing to open-source code (or maintaining the libraries we all desperately need). 

The advantage of a maturity model, if we can develop a concrete one, is that if we can name where a company is on this maturity scale, we can show them:

* Where the culture expects them to move to eventually 
* What direction they should be headed in now
* How far behind they are, and 
* What their next step / focus should be.

### Finding a way to help companies donate OSS Hours
Some companies attempt to support OSS by donating to the tools they use to support their main developers, which is definitely a great idea. However, it sounds like what the .NET OSS ecosystem needs is for a lot more people to come into the tent. 

Could we find a way to allow companies to donate OSS Hours in the form of their developers' time? Is there a way we could standardize / formalize it to make the policy easier for companies to adopt and track? If so, I think this could bring a lot of new faces. 

We could evangelize this from the inside out -- and a formal place to point to could help us do just that. Maybe a web site laying out the principles / ideas behind giving back? It's second-nature to those already doing it, but sometimes companies have to be convinced why altruism can be good for them, too.

### A "Good OSS Steward" Program
Some companies do the right thing and give back time and money instead of simply taking OSS for granted. While I don't advocate rewarding companies for doing the right thing, in this case I wonder if that might help everyone. 

What if some sort of a "certification" / recognition program exists for companies who provide the ability / incentives for their employees to contribute back to OSS? This would recognize companies who do the right thing, as well as incentivizing 

### Connecting Devs and Companies who care about OSS
Sites such as [WeWorkRemotely](https://weworkremotely.com/) organize the job search around work environment preferences. Does a tool exist for companies who care about using and contributing to OSS? 

I wonder if we could get StackOverflow Careers to add this as a way of matching companies with recruits, or to put together some sort of a quick / free job board on our own to accomplish the task. 

I might be overly optimistic, but if the best devs care about contributing, and they go to the companies where they're supporting that work, it could cause the industry overall to shift in that direction. 

### Meetups geared specifically toward .NET OSS Development 
This seems like the kind of thing that could be templated relatively easy and spread around. If developers get in a room together and the group chooses to support a few open-source projects, they could spend that time learning the OSS project and helping each other on the path to becoming contributors. 

Projects could be chosen for a few months at a time; a few could always be on deck to ensure a backlog / wide interest, and projects could be rotated in and out. Local companies could maybe even sponsor meetups and pick one of the projects, which helps them focus efforts in ways that benefit them, as well as being good for recruiting. 

I wonder if a push on this could help groups in various cities self-organize around this goal. 

## Are things really slow, or is it a matter of perspective? 

![An image of a car side mirror stating "dot net OSS devs may be closer than they appear"]({{site.post-images}}/dotnet-oss-closer-than-they-appear.png)

While I'm certain that the lack of progress Itamar sees is real and needs to be addressed, I also think he's so far ahead of the game that it might take some time to see that acceleration is happening -- it might appear slower from his vantage point. 

There's a great deal of inertia that we have to overcome, and changing the mindset of an entire industry is never going to be easy. 

But, I see a growing number of developers all around me excited about OSS in the .NET ecosystem, and they understand the importance of giving back. Like me, I think they're hovering around the edges and dipping their toes in the water, waiting for the right time to jump in or becoming incrementally more involved. I think a new generation of .NET developers is coming of age -- or being reincarnated ;). Now that OSS is backed by a huge group of passionate people -- and to a much greater extent these days, Microsoft itself -- I hope we'll go beyond seeing the fruits of the labor of people like Itamar, to actually helping them plant some seeds. 

## Hey, Itamar -- and other .NET OSS Pioneers: Thank you! Please don't lose hope.

We owe a lot to the ".NET OSS pioneers" who've come before us. We've been standing on the shoulders of giants. But they need more than our thanks -- they need us to pitch in.

Itamar, you inspired me this evening. I couldn't sleep, and I felt the need to contribute something. I wrote this, but I'll do my best to submit a PR before I sleep, too. :)

## What do you think? 
This seems like a problem worth fixing, and I'd love to hear how you think we can do it.

I would love your feedback on the ideas I mentioned here -- if you're interested in running with any of them, let me know and I'd love to help out!

[^1]: It might get confusing I guess.