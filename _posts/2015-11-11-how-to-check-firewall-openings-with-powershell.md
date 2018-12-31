---
title: "How To: Check Firewall Port Openings with Powershell"
 
date: 2015-11-11 23:15:00.000000000 -05:00
excerpt: "A little scripting can save a lot of wondering."
comments: true
---
## The Problem

If you deal with managing servers on any kind of corporate network that takes itself seriously, you'll know you can often run into issues where infrastructure is inaccessible. Sometimes this is by design and sometimes it's by accident, but oftentimes it's related to a firewall opening (or lack thereof). 

While working in an environment that manages many port openings, we had an incident where some old firewall rules kept getting reverted. When we lost connection, we needed a quick tool to assess whether that was a connectivity issue at the network level or whether we needed to start digging in further.

## Enough already, get to the Solution! 

The embedded gist is below. 

One last note before we begin -- I normally like to credit references in my blog post. In this case, they've fallen by the wayside because this was turned around pretty quickly. If I found out where I got some of the ideas from, I'll be updating this post. If you happen to stumble across something similar, let me know in the comments as I might be able to cred them here. 

<script src="https://gist.github.com/SeanKilleen/3800151caa9f4dc96183.js"></script>

## It Could Still Use Some Love..

I'll be honest: there's some sloppy PowerShell in there. While this one gets the job done, there are a lot of things that could be improved about it and I'd love to hear your feedback on improving it! I'm sharing it because I figure perfect is the enemy of good. I'll accept pull requests ... :) 

It would also make sense at some point to extend this script to be interoperable with SCOM / other monitoring systems, so that they could execute the script and the script could report back. 

Another note that's worth mentioning: This script requires you to have a service open and listening on the port you specify. For example, if are checking port 8172 but WebDeploy isn't enabled and listening on that port, it will "fail" even though the firewall is totally fine. Make sure you check this first so that your friends in networking don't laugh at you. :) 

## What do you think? 

I'd love opinions and enhancements. How do you handle these sorts of challenges? Is there a more standard/elegant piece of code available? Sound off in the comments!