---
layout: post
excerpt: "SSRS (SQL Server Reporting Services) uses port 80 by default on any server it’s installed on. Ugh"
title: 'How To: Stop SQL Server Reporting Services from using Port 80 on your Server
  [Field Notes]'
date: 2012-11-27 17:00:00.000000000 -05:00
comments: true

redirect_from:
 - /2012/11/how-to-stop-sql-server-reporting.html
---
### Problem
SSRS (SQL Server Reporting Services) uses port 80 by default on any server it's installed on.

This is *crazy annoying*, because you may want to have web servers or other application servers that also use the default http port 80.

Running `netstat -ano` from the command line at this point usually shows you that port 80 is in use by PID 4 (the system process).

### Solution
Fortunately, this isn't too hard to fix:

* Log on to the server that hosts SSRS.
* Go to `Start > Programs > SQL Server 2008 R2 > Configuration Tools > Reporting Services Configuration Manager`
* Connect to the server in question (usually your local server)
* Go to the `Web Service URL` section
* Change the TCP port to an open port other than port 80 (81 happened to work on my server) and hit `Apply`
* Go to the `Report Manager URL` section
* Click `Advanced`
* Click the entry with a TCP port of 80 and then click the `Edit` button.
* Change the `TCP Port` entry to the same thing you changed it to in the `Web Service URL` section previously and Click `OK`.
* Click `OK` again.

At this point, running `netstat -ano` should not show an entry for port 80.
