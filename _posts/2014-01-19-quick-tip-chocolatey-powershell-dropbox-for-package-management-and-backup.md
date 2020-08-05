---
 
title: 'Quick tip: Chocolatey + Powershell + Dropbox for package management and backup'
date: 2014-01-19 01:55:00.000000000 -05:00
comments: true
redirect_from: 
 - /2014/01/quick-tip-chocolatey-powershell-dropbox.html
---
So it's been a long day and night rebuilding a system from scratch (Motherboard issue + Hubris + Bad decisions). But on this go 'round, I decided to install as much of my software as Chocolatey packages as possible.

**Have you Installed Chocolatey? If not, and you care about being a windows sysadmin or developer, stop reading this and head to <http://chocolatey.org/> immediately to read up and install it. I'll wait.**

Done? Okay, great. So I was looking through the Chocolatey Gallery and finding packages to install (side note, installing multiple packages is as easy as "cinst packagename1 packagename2 packagenameN") when it occurred to me: as I change things, wouldn't it be nice if I had a list somewhere of these packages that stays updated?

Cue an all-too-easy powershell script on a scheduled task and 2 minutes later I was up and running. The script:

```powershell
$theDate = $(get-date -f yyyy-MM-dd_hh-mm-ss)
$baseLocation = "C:\Users\Sean\Dropbox\MyPCName\ChocolateyPackageListExport"
$finalFileName = $baseLocation + "\" + $theDate + "_PackageList.txt"
clist -lo | Out-File $finalFileName
```

Pretty simple -- it uses Chocolatey's list command with the -lo flag to show local packages only, and then outputs that list to a filename with a DateStamp.

I saved it in DropBox. The next step was to set a scheduled task. Again, easy! I created a simple task to run at 4am everyday. The action item is simply:

```cmd
powershell -NoLogo C:\Users\Sean\Dropbox\MyPCName\Scripts\ExportChocolateyPackageList.ps1
```

Now I get a date-versioned list of all my installed packages synced to any of my devices every morning at 4am.
