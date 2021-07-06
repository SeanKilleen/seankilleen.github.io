---
title: How to Contribute to OSS Projects When You're Unfamiliar With Their Code

tags:
  - OSS
  - contributions
  - culture
  - getting started
date: 2020-08-24 9:00 -0400
excerpt: "It can seem daunting, but there are some ways in."

header:
  overlay_image: https://images.unsplash.com/photo-1502101872923-d48509bff386?ixlib=rb-1.2.1&auto=format
  overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
  caption: "Photo credit: [**Jukan Tateisi @ Unsplash**](https://unsplash.com/@tateisimikito?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
---
I had a great question from a colleague recently and I figured I'd put my answer out there.

> I am curious, when you contribute to open source stuff, do you find that you really need to understand the project at a very complete level before making contributions? I'm wondering what balance to strike when thinking about contributing. For example, I use a certain project a lot, and would love to give back, but I don't really understand it. I just use the interface it exposes. So how much digging should I do before I try to look at their issues and solve something?

It usually depends on the environment of the project. I usually contribute in a few different ways:

* Super minor stuff (PR odds and ends like typos in documentation)
* Docs
* More substantial source code contributions (could also mean automated tests or CI/CD support)

Projects are normally really grateful to receive docs contributions, so if I'm looking to introduce myself to that project, I'll often start out by offering docs. It also helps me start digging into the code-base.
 (_Ed. note: when I wrote this, I had no idea I'd [become the NUnit docs lead](https://seankilleen.com/2020/07/announcement-i-am-now-the-lead-for-the-nunit-docs-project/) by doing this very thing!_)

I think it's important to start with issues, not pull requests -- especially if you're new. I look for issues that are tagged `up-for-grabs`, `good-first-issue`, `help-wanted`, etc. I usually comment on those issues and ask if someone's OK if I jump into it, and mention that I'm a bit newer to contributing on this project but I'm interested. If I want to suggest any changes myself -- docs contributions, any code contributions, I usually add an issue for discussion unless it's abundantly clear that it's needed.

If someone is OK with me hopping onto an issue, I'll start a PR early, use draft PRs, and make many small commits. And I'll use the PR text to be crystal clear about what I'm doing, the effect I think it'll have, my thought process, and answering any "why" questions. I also make it super-explicit that I'd love and welcome feedback, the earlier the better.

The rest of it is just "working out loud". I push commits, I add comments along the way summarizing my progress and any stumbling blocks, etc.

In my colleague's example, the project they are interested in has a `good-first-issue` label. This indicates it's a good way to ease in, and they'll help you with the process.
That's a great sign -- it means they're interested in contributions and will be friendly about you offering yours. I'd take them up on one of those.

Don't worry; it will be humbling. Every new code-base is. But the end result feels really good.
 A way to make this fun: stream it! If you're worried about slogging through, 100 other people probably are, too. If you show your thought process and noodling through things, other people might even join and help. It takes a bit of guts but if you embrace the learning part of it and don't think of it like a conference talk, people actually get really into co-creating with you (learned that one from colleague and fellow Microsoft MVP [Alex Slotte](https://twitter.com/alexslotte) who is having [a great time streaming](https://www.twitch.tv/alexslotte), with great success.)

The most important thing: get started! If you are humble, willing to accept feedback, and care about being kind and helping out, chances are you're going to make a great and welcome impact.
