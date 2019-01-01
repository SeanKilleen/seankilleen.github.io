---
title: 'How to Copy ACL Permissions For Folders, Using Powershell'
 
date: 2015-01-22 12:47:00.000000000 -05:00
comments: true
---
## Problem

I needed the permissions on folder B to be exactly what they were on folder A.

## Solution

Powershell's `Get-Acl` and `Set-Acl` commands can be conveniently piped together.

So to copy permissions from C:\Folder1 to C:\Folder2, the following one-liner would do the trick:

`Get-Acl -Path C:\Folder1 | Set-Acl -Path C:\Folder2`

Happy scripting!