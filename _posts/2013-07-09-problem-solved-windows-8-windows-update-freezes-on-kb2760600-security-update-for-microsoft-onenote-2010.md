---
 
title: 'Problem Solved: Windows 8 Windows Update Freezes on KB2760600, "Security Update
  for Microsoft OneNote 2010"'
date: 2013-07-09 23:23:00.000000000 -04:00
comments: true
redirect_from: 
 - /2013/07/problem-solved-windows-8-windows-update.html
references: 
 - title: "KB2760600 - not installing"
   url: http://answers.microsoft.com/en-us/office/forum/office_2010-onenote/kb2760600-not-installing/811842f5-6a58-40e1-a107-7303ddc4dcdf
   parenttitle: Microsoft Community
   parenturl: http://answers.microsoft.com/en-us
---
Ran into this today; thought I'd document it for others.

### Problem
When installing Windows Updates on Windows 8, it seems to stall while processing the following update:

"Security Update for Microsoft OneNote 2010 (KB2760600) 32-Bit Edition"

### Solution

Per [this conversion on a Microsoft forum][Forum link], run task manager and close "spoolsv.exe".

The update should finish shortly thereafter without issue.

[Forum link]: http://answers.microsoft.com/en-us/office/forum/office_2010-onenote/kb2760600-not-installing/811842f5-6a58-40e1-a107-7303ddc4dcdf
