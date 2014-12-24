---
layout: post
title: 'Quick Fix: Windows Server 2008 R2 Internet Explorer Windows Update Issue [Field
  Notes]'
date: 2012-04-16 09:08:00.000000000 -04:00
comments: true
redirect_from: 
 - /2012/04/quick-fix-windows-server-2008-r2.html
---
###Problem
On a fresh install of server 2008, after adding IE 9 via Windows Update, the installation appears again in later updates.

When trying to perform this install, you receive the error code `"9c48"`.

###Cause
In layman's terms: Essentially, it looks like the installer binaries after April 2012 are screwed up somehow. This causes it to install incorrectly the first time, and see itself as ready to be downloaded for the first time (instead of ready to download updates).

###Solution
####Step 1: Uninstall your current Internet Explorer
* Go into Windows Updates
* Click `View Update History`
* In the search box up top, type "Internet" and the search should filter to include "Internet Explorer 9".
* Right-click on Internet Explorer 9 and Choose `Uninstall`.

####Step 2: Download a good installer
[Via this great thread][Thread], I found a solution on the download location.

You can download a non-broken IE 9 Installer from Microsoft at <http://www.microsoft.com/download/en/details.aspx?id=23332>.

####Step 3: Install the Downloaded (non-Windows-Update) IE 9
This one's pretty straightforward. You'll have to restart once you're done.

####Step 4: Check for Updates
When checking for Windows Updates, you should no longer see Internet Explorer 9 offered as an update, and should instead see updates for the program (if available).

[Thread]: http://social.technet.microsoft.com/Forums/en-US/winservergen/thread/2c252dbe-c833-424d-9b75-4948bb8fb816