---
title: My Thoughts on the FluentAssertions License Change
comments: true
tags:
  - dotnet
  - .net
  - oss
date: 2025-01-14 22:12 -0500
---
Recently, [Fluent Assertions changed to a dual-license](https://github.com/fluentassertions/fluentassertions/pull/2943) in its latest v8.0 release, with a paid license for commercial use. Unsurprisingly, people had Lots Of Feelings™️about this. I wanted to walk through some things I'm seeing/hearing and put my perspective on it.

## My Thoughts on the Change

I [talked about this on BlueSky](https://bsky.app/profile/did:plc:ozet7mfwewusddc5nvv2k23p/post/3lfqnk77g2s23), but just to summarize: I've used this library for years and benefited from it, and I appreciate all the work that Dennis and others put into it that allowed me to consume it and make my life easier without thinking about it much.

But now, that changes. With this change, I can no longer just consume this tool without thinking about how I'm approaching the impact it has.

And -- that's fine! Dennis and the key contributors have every right to benefit from this work in this way if that's the way they want it to go. My choice will be to either pay for the library and get the stability that comes with it, or remove the library (I don't believe in remaining on old versions of dependencies, so that's not an option.) But I refuse to be mad about being forced to be conscious about something that I previously unconsciously consumed.

## How I'll Evaluate Whether to Purchase

With a library like this, it seems like a pretty straight-forward evaluation.

* Total licensing cost: $130 times the number of developers who are in scope
* That cost in "dev hours": total licensing cost / rough hourly rate of a dev
* Add 1-2 more hours because dealing with keeping up with licensing is not a value-add use of my time and feels like a paper cut.
* How long would it take to remove/replace it, in dev hours?

With that information, I'll ask:

* Are we getting more impact in dev hours back than what we'd be spending to license it?
* Is it going to cost more dev hours ripping it out that it takes to pay for it over the next 1-2 years?
* Do I feel like license is such that I can abide it without causing risk for our organization? Custom licenses do make this a little more difficult.

I won't make this decision alone. I'll ask the team their input and make sure I have the whole story.

## Reactions to Other Thoughts I'm Seeing on the Change

Going to summarize from comments I'm seeing on [the pull request that changes the licensing](https://github.com/fluentassertions/fluentassertions/pull/2943). I'm using quotes below, but in most cases they represent generalized thoughts.

> You should make sure you adhere to the rules of the prior Apache 2.0 License. It would be helpful to know if this applies to 8.0 and above or if it's larger in scope.

This seems absolutely reasonable to ask / clarify.

> It should probably be included very prominently in any upgrade guides

Yep, also fair.

> This is corporate greed / fleecing people for money.

Nope, I don't buy this part. This library was FOSS for 15 years. Proponents of OSS that talk about corporate / maintainer greed forget about the effect of "consumption greed" on the maintainers of those very tools.

> You honestly think someone is going to pay $130 per developer per year for what's essentially syntax sugar for unit test code?

Obviously they do, or they wouldn't have done it. All you're doing is insulting someone who gave us 15 years of free impact because you now have to make a choice. That's not how to be a part of a community, either.

> Make a separate product and NuGet package if you must. FluentAssertions Pro

This strikes me as the same thing as saying "ask for donations". The key is that the maintainers wanted a different outcome. You don't get to that outcome by doing ineffective things like creating an entirely separate package. That's just wanting the maintainers to do something different (and more work!) so that people can continue to not support the maintainers in the way they choose to want to be supported.

> The price isn't reasonable!

Reasonable is whatever the market will bear. Maybe this will become apparent if FluentAssertions doesn't sell the licenses they expect. Maybe the price will change. Or maybe it will be just fine, and other folks will have to move on even if they'd prefer not to. It's how things go sometimes.

> I can't justify the price to my leadership

Then you're either not getting enough impact from it to justify keeping it, or you're not doing a good enough job articulating the impact, or your company isn't invested enough in considering its software tooling costs and developer experience. In any of those cases, just remove it and move to another library.

> users had no reason to suspect that they would have to pay money for future improvements or bug and security fixes.

Those users are living in a universe where they receive things for free while (largely) contributing very little or nothing back. That's some pretty magical thinking. I too would like free things forever! But if you're not contributing your money or your time, you'd best at least be contributing your understanding and your gratitude.

> This change goes against the original idea of the project.

I didn't realize that people knew the maintainer's original idea for the project, and that the idea wouldn't change in 15 years, and that random commenters would be the ones who decide how that could evolve?


