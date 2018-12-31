---
layout: post
title: 'Crystal Reports 2008 / Business Objects XI: Differing ODBC DataSource Issue
  [Field Notes]'
date: 2011-11-10 10:38:00.000000000 -05:00
comments: true

---
### Problem
In Crystal Reports 2008, I create a report using an Oracle connection or an ODBC connection with name x. When I upload the report BO XI, it doesn't work with the ODBC connection added to it.

### Cause
While annoying, this appears to be because Business Objects doesn't automatically apply its own Data Source, and so any difference that doesn't match up in the server will result in a database error or repeated/endless login dialogs.

### Solution
When using ODBC connections on your BO Server, prior uploading your report, be sure to create an ODBC connection with the same name as the server and set the data source location to it.

This should allow the server connection to stand in for the local connection and remove the Database issues when you run the report in Business Objects XI.
