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
* How long would it take to replace it in dev hours?

With that information, I'll ask:

* Are we getting more impact in dev hours back than what we'd be spending to license it?
* Is it going to cost more dev hours ripping it out that it takes to pay for it over the next 1-2 years?

I won't make this decision alone. I'll ask the team their input and make sure I have the whole story.

## Other Thoughts I'm Seeing on the Change
