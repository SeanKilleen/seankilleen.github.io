---
title: On Moq and our Part in the OSS Sustainability Social Contract
comments: true
tags:
  - oss
  - culture
  - sustainability
  - open-source
  - community
  - social-contract
date: 2023-08-09 08:18 -0400
---
Let they who are without OSS sin cast the first stone. Let's look inward on OSS sustainability issues.

## What Happened?

Recently, [Moq, an OSS mocking library for .NET](https://github.com/moq/moq), made a change. The timeline as far as I can tell is roughly:

* At some point, likely for a long time, sustaining the Moq OSS library became untenable.
* Also as background, some OSS projects have tried things for a long time - asking for sponsors and contributors, changing license terms. All are typically met with some form of hostility from a large group of consumers who have no intention of supporting the software.
* In January, the maintainer of Moq [blogged about a tool they'd be building called SponsorLink](https://www.cazzulino.com/sponsorlink.html), specifically saying they're "trying something new-ish". This tool collects GitHub e-mail addresses and hashes them, and appears to attempt to ask for sponsorship within the IDE if a user isn't already sponsoring.
* In April, [it was pointed out via a GitHub comment](https://github.com/devlooped/SponsorLink/issues/10) that this might not be a great approach from a privacy & GDPR perspective. At the time, the author dismissed that concern because they believed the hashing of the e-mails meant there wasn't a privacy violation. This is incorrect but I understand how someone could mistakenly come to that conclusion.
* This month, the author [implemented that tooling in a release](https://github.com/moq/moq/releases/tag/v4.20.0), and a lot of folks were (understandably) caught off guard when they made the update. Some had the package flagged for security issues because it contained a new dependency that was making network calls. Some had their builds negatively impacted (such as those who enabled warnings as errors, etc.)
* As will likely not be surprising, people became pretty irate -- working to rip Moq out of their setups (or at least saying they would), warning other projects that use the library, calling it malware, bashing the library, etc. 
* Roughly a day later, [the change was reverted](https://github.com/moq/moq/releases/tag/v4.20.2). Though, it sounds like there are still plans to continue with it.

## My Take

This is yet another situation where the situation for this project became untenable, traditional paths don't seem to have worked, and the author had an idea for something new and novel. Would I have done it myself? No. Do I think it was a successful idea? Absolutely not. Can I fault them for trying? No. Do I think this author deserves our grace and respect after we've all consumed their work for free for years? Yes.

With that said, I think this is a good example of how not to go about this sort of change. I think the implications of collecting developer email addresses without consent, and introducing a closed source (and obfuscated) binary, were not fully considered. And I think for a change like this, a lot more communication in a lot more formats would be helpful. I think negative-first approach (warning, slowed builds) is bound to frustrate people and make them defensive, which makes them much less likely to donate. Similar with being surprised. And I know the author tried to show how they had no nefarious intent, but they noted that without noting the real frustration that accompanied their actions -- impact matters more than intent.

And since I haven't done a single thing to help this library to this point, I haven't held up my end of the OSS social contract. So, my currency is now in being empathetic and allowing the benefit of the doubt on the author's intentions. "Let they who are without OSS sin cast the first stone."

## The Social Contract of OSS Sustainability

In my view, there's a social contract around OSS and its sustainability. My wording of this social contract is essentially:

> You get to expect things of an OSS project to the extent that you contribute to that OSS project or are willing to help. Everything else should be gratitude or grace.

For the projects I actively contribute to, or where I am willing to provide and commit to a solution, I allow myself to have expectations and expect them to be met. For commercial libraries that are strongly tied to business I do with a gien organization, I feel the same. For everything else, I try to remind myself that I'm thankful that it exists, and my concerns need to be expressed with a very different tone, and that some space needs to be given if I feel mistakes have been made.

The last part of my social think is to strongly consider that I am a member of the .NET OSS Community, and thus I am a member of the community and the system that allowed this to happen. What could I do differently? I think about it this way not because it's literally true, but because it allows me to shift my perspective to how I/we better support the OSS ecosystem to get the outcomes we might want.

Of _course_ people feel disrupted when a package restricts itself in some way, or adds commercial licensing, or goes dark. But the issue isn't those decisions; the issue is our inability to recognize their value in our supply chain and act accordingly.

## So, Looking Inward: How Could This Have Been Prevented?

I like to think about this from an impact perspective. If I wanted a different outcome here, what are some things I could have done? I'd suggest others could benefit from doing this as well.

I have to remember that I as a user of Moq I didn't follow the author to stay up to date, so I didn't read or comment on the announcement post that is 7 months old. And also I didn't provide monetary support OR community support. I'm not holding up my part of the OSS social contract, so it's hard for me to feel mad when I feel that the author missed the mark on it too. To be outraged at this without prior support is to be a direct part of the problem of OSS sustainability, because it assumes we should be nothing but consumers without fulfilling the obligations of community.

* I could have commented my thoughts on the proposed change. But, I didn't actively follow the project beyond consuming it.
  * **Action**: I could follow the authors of the OSS tools I depend on, on various social channels (and add their blogs to my feed reader).
  * **Action**: OSS projects could add an announcements repository similar to how the .NET team does it (but without expecting the same rigor). I could write up some guidance on how to do that.
* I could have sustained the project in some way. I didn't contribute to it at all despite teaching it in several courses and using it for a long time.
  * **Action**: Look into creating OSS support programs / sustainability funds in my place of employment. Gather materials to help others do so.
  * **Action**: Budget for OSS support, in terms of both time and money. Write about doing this. Help others to do so.
* I can show support for the creator and their intentions
  * I'm attempting to do that here.

## It's Not a "Supply Chain" Unless You're a Responsible Consumer

One thing I want to call out because it annoys me to no end: people who complain about having to rip libraries out or get in trouble with their Security / DevSecOps teams and how personally frustrating it is for them. 

You typically either build software, or buy software. But OSS has introduced an additional category: "software you can use and thankfully don't have to buy." The problem occurs when we remove the "thankfully" and it becomes an expectation of an entire ecosystem

These companies have been using this library for free. Presumably it saves them money or time (which to a business _is money_.) Those organizations who are using OSS but not paying attention to the ecosystem they use are making a strategic mistake around a supply chain. As a business, you either need to actively understand your supply chain, or understand your own situation enough that you can adapt if your supply chain changes (without blaming the supply chain). If you don't have a supply chain that is committed to you via a business transaction, then you need to be aware of those risks and work to mitigate them or budget for them in some way. 

Within business contexts, stop pretending that free OSS work owes you the responsibility of being a supplier in a supply chain if you're not doing the appropriate work of being a business consumer (i.e. paying for the supplier). 

Anything else is just magical thinking.

## Other Perspectives I've Heard (and my responses)

* **[Concerns were raised](I'd say it was considered but no shits were given https://github.com/devlooped/SponsorLink/issues/10) but the developer didn't care**: I'm not sure I see it the same way. I think someone had an idea for how to maybe address the OSS sustainability crisis within their own sphere of influence and the optimism outweighed the downsides (plus a lack of understanding of the GDPR implications).
* **This is not well thought through technically**: Sure, I agree -- I would have rejected such an idea if it came up in my brain. But I only have my context, and this creator only has theirs. So my larger point is: where was the community support & involvement? Where was the jumping in to help support this OSS author?
* **They should have expected to be nagged about this**: I understand personal frustration, but I wish that everyone could take a breath before showing up in such an entitled manner. At a minimum we owe the author our respect and reasonable discourse. Mistakes can be made, and I wasn't there to help prevent them, and from what I can tell, a lot of other people weren't there either.
* **He's burned his political capital all at once**: Not with me. And that's my point. If we can't allow someone to learn and grow, after they did something with reasonable intentions, after creating a library that we've used for free for years, what does that say about us as a community? How flimsy is the currency of our political capital that it's tied to someone doing something for free, forever, without attempting to innovate, and also never making a mistake? If I were them, I'd stop caring about that kind of political capital entirely. It's a bad idea. And we owe this creator the grace of recovering from that bad idea, with continued respectful dialog.
* **Nobody is able to engage on every single OSS project they use. We all have limited time**: Correct. To that extent, I think it's a goal for all of us to get more people involved in the ecosystem to ensure we have "coverage" since we can't be in all places. So let's work on systems that bring more people into these communities.

## Advice for OSS Authors Going Forward

I play a minor role in this ecosystem but I've thought about it for a while, so I'll humbly add some advice for OSS creators in case it helps (many are already doing lots of these things)

* Ask for financial support when you need it.
* Have an amount / goal in mind if possible. This is often easier to help rally a community to support.
* Build avenues for understanding who your larger / profitable users are, and lobby them (or work with the larger community to lobby them) on how to create OSS Sustainability funds, etc. We should have a better community system to do this.
* If you're considering a system to drive financial support, think about how to help your audience feel less defensive. This typically means finding ways to pull people into these changes rather than push changes onto them, especially changes that add extra work or result in them feeling defensive or suspicious. For any changes that could have those imapcts, over-communicate about it in several forms of media (tweets, blog, pinned GitHub issue, release notes) across a period of time prior to enacting the change.
* Assume that small bits of negative feedback early on will be amplified by consumers when the change is released more widely. It shouldn't be this way, but anticipating it might help you give the appropriate weight to that early feedback.

## Bottom Line: We Need Better Systems Thinking Around OSS Ecosystems

We need better systemic ways to:

* Allow maintainers to surface the kinds of help they need in a centralized way
* Allow organizations and consumers to do the right thing by default (ways to contribute to all dependencies they benefit from)
* Connect people who are willing to help with training to provide the kinds of help that are needed, and connect them with the places that need it.

I have some thoughts on how to do these things and am going to try to reconfigure my priorities to use this instance as a call to action.

## Your Thoughts are Welcome!

This is a pretty nuanced conversation and I'd love to hear your thoughts in the comments.