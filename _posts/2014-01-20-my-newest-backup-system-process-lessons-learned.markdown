---
layout: post
title: My Newest Backup System / Process [Lessons Learned]
date: 2014-01-20 20:39:00.000000000 -05:00
comments: true
redirect_from: 
 - /2014/01/my-newest-backup-system-process-lessons.html
---
With all my bellyaching about Backblaze lately, it only stands to reason that I should pick a better system.

So, following [Scott Hanselman's advice](http://www.hanselman.com/blog/TheComputerBackupRuleOfThree.aspx), I'm upping my backup game. Below is how I plan to take care of my ~400 GB of data so far:

* **Taking care of the data normally:** My data will be on two 2TB hard drives in a RAID1 configuration. It uses Intel RST, which is a great app that lets me use an SSD drive as a cache. If your components support it, I can't recommend it enough.
* **An extra local copy:** I have two additional 1TB harddrives (from my last RAID set). I'll be setting up Robocopy on a scheduled task to mirror files in certain folders, and will also set it up to monitor folders when files change.
* **An additional off-site copy:** Since I have two 1 TB hard drives, I will label them "A" and "B" and swap them when I go to see my family in Pennsylvania. If I didn't have family in another state, a bank safety deposit box would do just fine.
* **An external hard drive**: Because seriously, why not? This way I know it can travel, too. No backup is too much, even just for convenience, especially if I can automate it.
* **GMail:** My e-mail is also precious. I'll be again using [a Hanselman-authored solution](http://www.hanselman.com/blog/AutomaticallyBackupYourGmailAccountOnAScheduleWithGMVaultAndWindowsTaskScheduler.aspx) to back this up.
* **Cloud Backup:** If Backblaze is able to take care of me, I may keep them because I have a lot invested. Otherwise, I'll be looking at other options. But the point is, this should be the last of my concerns after all the other ones are taken care of.

Looking forward to getting this set up ASAP.
