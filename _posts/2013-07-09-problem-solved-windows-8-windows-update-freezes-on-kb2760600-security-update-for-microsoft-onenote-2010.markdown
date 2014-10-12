---
layout: post
title: 'Problem Solved: Windows 8 Windows Update Freezes on KB2760600, "Security Update
  for Microsoft OneNote 2010"'
date: 2013-07-09 23:23:00.000000000 -04:00
comments: true

---
Ran into this today; thought I'd document it for others.

###Problem
When installing Windows Updates on Windows 8, it seems to stall while processing the following update:

"Security Update for Microsoft OneNote 2010 (KB2760600) 32-Bit Edition"

###Solution

Per <a href="http://answers.microsoft.com/en-us/office/forum/office_2010-onenote/kb2760600-not-installing/811842f5-6a58-40e1-a107-7303ddc4dcdf" target="_blank">this conversion on a Microsoft forum</a>, run task manager and close "spoolsv.exe".

The update should finish shortly thereafter without issue.

###References
* <a href="http://answers.microsoft.com/en-us/office/forum/office_2010-onenote/kb2760600-not-installing/811842f5-6a58-40e1-a107-7303ddc4dcdf" target="_blank">KB2760600 - not installing</a> [<a href="http://answers.microsoft.com/en-us" target="_blank">Microsoft Community</a>]
