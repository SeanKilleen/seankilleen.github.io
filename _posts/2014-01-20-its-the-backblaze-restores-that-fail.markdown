---
layout: post
title: '"It''s the (Backblaze) restores that fail."'
date: 2014-01-20 20:17:00.000000000 -05:00
comments: true

redirect_from:
 - /2014/01/its-backblaze-restores-that-fail.html
---
*[FYI, since it's only fair: if Backblaze makes this right or wants to respond, I will absolutely allow them space in this post to do so. I still have a lot of respect for them as a company. <a href="https://news.ycombinator.com/item?id=7093016" >You can follow the discussion on HackerNews</a>.]*

Folks involved in systems administration may likely be familiar with the adage that "Backups always work; it's the restores that fail." [^1]

For years, I've put a lot of trust into http://www.backblaze.com as an online backup application. I have evangelized them to many people; my family members and girlfriend in particular will attest to the fact that I've often foisted the solution upon them, and I've even gone so far as to buy a subscription for a friend of mine who is a writer but didn't have a backup solution.

**However, currently I'm stuck in a frustrating restoration process that is making me rethink the decision to use Backblaze.**

Background: a little over a week ago, I made some stupid decisions when the RAID controller died on my out-of-support motherboard and my disks got a little scrambled. I knew I'd need to rebuild my system, but essentially I got rid of the data because I knew I had it in another location and was comfortable because I trusted Backblaze.

My first trouble came when I requested a small restore on my laptop. It was 32 MB of data that I needed to get my system up and running again [^2], downloaded to a laptop. I tried unsuccessfully for *hours* to get those files to download. The speed dropped to 0kb/sec after 3 seconds until the downloads timed out. I used both http downloads and Backblaze's downloader application, to no avail.

After a very helpful conversation with BackBlaze's CEO [^3], who got the engineers to confirm that their servers appeared to all be doing fine, I was able to get the downloads to work, but only seemingly after force-quitting every chrome.exe application (whether this is the fault of Backblaze's software or chrome, I can't say. I should have rebooted my whole system earlier in the process, but it seemed like an issue with their servers given that I could stream HD video and was getting at least 14-15mbps down at the time).

So the next step: Now that the downloads were confirmed to work, I got my system back in order and then prepared my first restore -- a 6 GB chunk of data out of my ~400 GB stash. This download took a long time, but is worth waiting for as I do not want to pay $189 to have my data shipped to me (one of their options). However, upon finishing the download after 12+ hours, when unzipping the file I was told that it wasn't a valid archive. Both the backblaze unzipper and 7-Zip could not make any sense of the file.

The support ticket I had open through all of this is equally frustrating. Firstly, the support staff was off for the weekend. This is totally understandable, but when dealing with something mission-critical like data, I think it makes sense to employ a weekend staff. Someone finally replied to my first ticket at 10:30 this morning. When I told them the 6GB download unzip had failed using the backblaze downloader, they asked me to try again using 7-zip. I confirmed that I had tried both and asked if there was anything I could do to fix the 6GB download or if this was a known issue. That was a little before 1PM EST; it is currently 8pm EST and I have not heard back from BackBlaze.

Given the slow speed of transfer and technical difficulties with a 6GB file, how am I supposed to trust them either with a 400 GB restore, or (as they recommend) ~20 sets of 20GB files? It's put me in a very difficult position by not delivering on its promise -- a promise that means a lot to me as an IT guy.

<a href="http://www.code42.com/crashplan/" >CrashPlan </a>is looking like a great option right now, and I'll be exploring other solutions as well. If I have to spend $189 to get Backblaze to do what it promises to do for me, after paying for years, I have no choice but to look elsewhere.

In the end, I am grateful for what Backblaze offers, and hope that it can follow through on it to remedy the situation.

###Conclusions / Concerns
* **Don't be like Sean -- do what Scott Hanselman says and always have a local backup, too**. I now have an additional 1TB SATA drive and plan to use it specifically for this purpose. I thought I was sacrificing convenience for dollars, but it was worse than that. This was hubris on my part.
* Backblaze really needs to up its restore game. A LOT. Restoring your precious files is generally an anxious process; as a technical person I hit a ton of roadblocks. I don't pay them to back my things up; I pay them to restore my things when I need them.
* Is Backblaze neglecting its restoration services knowing that customers will likely opt for the $99-189 purchase of a shipped HDD because their data is precious? I certainly hope not, but it seems to be a possible conflict of interest.

###Footnotes
[^1]: I've heard this in the industry for years, but since I don't know the originator, I'll give <a href="http://www.hanselman.com/blog/TheComputerBackupRuleOfThree.aspx" >Scott Hanselman</a> the credit.

[^2]: Side note: If you are going to scan your documents -- like say, **serial keys to your OS** -- don't keep them as remote files only. In general, I'll be switching to an additional form of backup for local as well.

[^3]: Seriously, I commend his willingness to engage with a slightly-frustrated customer who found him on Twitter during the weekend. It was a long shot but his response inspires confidence. <a href="http://storify.com/seankilleen/very-supportive-conversation-with-backblaze-ceo" >Here's the Storify of our conversation so far</a>; I'll edit it as progress is made.
