---
layout: post
title: 'Crystal Reports Gotchas: Spinning Wheel Forever? Check for Hidden Error Messages.
  [Field Notes]'
date: 2013-02-26 19:00:00.000000000 -05:00
excerpt: "When attempting to run a report from Crystal Reports Server 2008, the 'processing data' wheel seems to be stuck in an infinite spin."
comments: true

---
###Problem
When attempting to run a report from Crystal Reports Server 2008, the "processing data" wheel seems to be stuck in an infinite spin. On a server with constrained resources, this might seem to be a processing speed issue. This only happens with a specific report.

###Solution

* Open and log into Crystal Reports Server InfoView
* In InfoView, click on `Preferences`. 
* Click the arrow next to the Crystal Report section to drop it down.
* For the `default view format` option, choose `Web Java (Java Required)`.
* Run the report again.

Doing this revealed a hidden error message for me. The other two modes appear to infinitely process the report, but "web java" mode revealed an error in the report very quickly.

This led me on a goose chase for hours the other day, so I hope someone else might benefit.
