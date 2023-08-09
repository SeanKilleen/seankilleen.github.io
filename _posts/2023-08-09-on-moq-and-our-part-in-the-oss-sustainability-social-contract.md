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
* Roughly a day later, [the change was reverted](https://github.com/moq/moq/releases/tag/v4.20.2).

## My Take

This is yet another situation where the situation for this project became untenable, traditional paths don't seem to have worked, and the author had an idea for something new and novel. Would I have done it myself? No. Do I think it was a successful idea? Absolutely not. Can I fault them for trying? No. Do I think this author deserves our grace and respect after we've all consumed their work for free for years? Yes.

And since I haven't done a single thing to help this library to this point, I haven't held up my end of the OSS social contract. So, my currency is now in being empathetic and allowing the benefit of the doubt on the author's intentions. "Let they who are without OSS sin cast the first stone."

## Looking Inward: How Could This Have Been Prevented?

I like to think about this from an impact perspective. If I wanted a different outcome here, what are some things I could have done? I'd suggest others could benefit from doing this as well.

* I could have commented my thoughts on the proposed change. But, I didn't actively follow the project beyond consuming it.
  * **Action**: I could follow the authors of the OSS tools I depend on, on various social channels (and add their blogs to my feed reader).
  * **Action**: OSS projects could add an announcements repo similar to how the .NET team does it (but without expecting the same rigor)
* I could have sustained the project in some way. I didn't contribute to it at all despite teaching it in several courses.
  * **Action**: Look into creating OSS support programs / sustainability funds in my place of employment.
  * **Action**: Budget for OSS support, in terms of both time and moey
* I can show support for the creator and their intentions
  * I'm attempting to being doing that here.

## The Social Contract of OSS Sustainability

## It's Not a "Supply Chain" Unless You're a Responsible Consumer

## Other Perspectives I've Heard (and Responses)

## Bottom Line: We Need Better Systems Thinking Around OSS Ecosystems 