---
layout: post
title: 'SQL Server: Save Not Permitted Dialog Box [Field Notes]'
date: 2011-12-01 23:08:00.000000000 -05:00
comments: true

references: 
 - title: "Save (Not Permitted) dialog box"
   url: http://msdn.microsoft.com/en-us/library/bb895146.aspx
   parenttitle: MSDN
   parenturl: http://msdn.microsoft.com/en-us/default.aspx

---
###Problem
In a new install of SQL Server 2008, when attempting to save changes to a table in a new database, I occasionally get the following error:

> Saving changes is not permitted. The changes you have made require the following tables to be dropped and re-created. You have either made changes to a table that can't be re-created or enabled the option Prevent saving changes that require the table to be recreated.

###Solution
Per [this excellent article on MSDN help], take the following steps to rid yourself of this error:

* `Tools > Options`
* Expand the `Designers` Section
* Click the `Table and Database Designers` section
* Uncheck the box labeled `Prevent saving changes that require table re-creation.`

###Caveat
**Don't do this on a production database**. Just don't do it. I only needed this for a quick temporary database, or when working in design mode. Otherwise, this option should always be enabled.

[this excellent article on MSDN help]: http://msdn.microsoft.com/en-us/library/bb895146.aspx