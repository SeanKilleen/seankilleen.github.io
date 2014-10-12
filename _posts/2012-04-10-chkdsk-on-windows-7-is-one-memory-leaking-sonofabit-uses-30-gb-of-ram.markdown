---
layout: post
title: Chkdsk on Windows 7 is one memory-leaking Sonofabit, Uses 30 GB of RAM
date: 2012-04-10 16:45:00.000000000 -04:00
comments: true

---
My desktop PC has 32 GB of RAM. It's ridiculous in that way, by almost any standard. I assumed that when I hit full usage of memory it would be because my entire virtual network of random servers, etc. would be running at once.

I was wrong. All it took was running Chkdsk.exe on an external HDD.

See below for yourself:

![Picture of Chkdsk.exe eating all my RAM.]({{site.post-images}}/2012-04-10_Chkdsk_CrazyMemoryUsage.png)

In case you can't see it clearly, that's Chkdsk.exe taking up 30,060,916 KB of RAM. Otherwise known as ***30.06 GB of RAM***.

[Apparently]() [this]() [has]() [been]() a [known]() [issue]() [for]() a [long]() [time]().

If I find a resolution, I'll post one here in problem/solution format. If you have any tips, drop a line in the comments!

**Update:** Apparently the OS shipped with this bug and there's no attempt to correct it as it's a very low-level architecture issue. I'll check Windows 8 in a VM and see if it runs into the same problem.

[Apparently]: http://social.technet.microsoft.com/Forums/en-US/w7itprogeneral/thread/a3cd974b-4758-44bb-b1c0-289ef813b2e6/

[this]: http://social.technet.microsoft.com/Search/en-US/windows?query=Chkdsk.exe%20memory&amp;rq=meta:Search.MSForums.ForumID(5e870b2f-e15b-45f9-8fe4-ede340e81641)+site:microsoft.com&amp;rn=Windows+7+Performance+Forum

[has]: http://answers.microsoft.com/en-us/windows/forum/windows_7-windows_programs/64-bit-explorerexe-memory-leak/a405cdcd-6926-4a9f-809e-bc1f9c595cd0?tab=MoreHelp

[been]: http://social.technet.microsoft.com/Forums/en-US/w7itproperf/thread/02a8fb95-a028-46ef-88fe-69f1e5b2d71d

[known]:http://www.neowin.net/news/main/09/08/05/windows-7-rtm-contains-a-rather-nasty-chkdsk-bug

[issue]: http://social.technet.microsoft.com/Forums/en-US/w7itproperf/thread/3dc1af71-56d8-447b-ad9b-2a94b36dffc1

[for]: http://social.technet.microsoft.com/Forums/en-US/w7itproperf/thread/2b854229-ce35-4a49-a544-77c15786c529

[long]: http://www.infoworld.com/d/windows/critical-windows-7-bug-risks-derailing-product-launch-330

[time]: http://www.computerworlduk.com/news/operating-systems/16098/windows-7-massive-memory-leak-could-delay-release/
