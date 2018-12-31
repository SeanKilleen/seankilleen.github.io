---
 
title: 'Robocopy: "You do not have the Backup and Restore Files user rights" [Field
  Notes]'
date: 2011-10-18 12:29:00.000000000 -04:00
excerpt: "In Windows 7, using Robocopy with the /B or /ZB switches I see the error 'You do not have the Backup and Restore Files user rights'."
comments: true
redirect_from: 
 - /2011/10/robocopy-you-do-not-have-backup-and.html
 
---
*[**Ed. Note:** "Field Notes" is a place where I plan to succinctly describe solutions to problems that I run across in my daily work. They are meant as a reference; ask if you have any questions!]*

### Problem
In Windows 7, Using Robocopy with the `/B` or `/ZB` switches yields the error:

> You do not have the Backup and Restore Files user rights

### Solution
This is due to UAC. 

Either run the command prompt as an administrator (with appropriate credentials) or ensure that your scheduled task has appropriate credentials.
