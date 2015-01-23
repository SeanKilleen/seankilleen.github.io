---
layout: post
title: 'Fix: Crystal Reports 2008: Database Links Happen Automatically and Cause Unnecessary
  Slow-down [Field Notes]'
date: 2011-11-18 12:15:00.000000000 -05:00
comments: true


---
### Problem
In Crysal Reports, whenever adding a table from an existing data source, or adding a new datasource, when I click "OK", Crystal automatically switches to the "Links" tab and auto-calculates links.

99% of the time this is something I **don't** want it to do.
### Solution
Auto-linking can be turned off in Crystal's options with the Following Steps:

* From the `File` menu, select `Options...`
* Select the `Database` tab.
* Under the `Advanced Options` section, uncheck `Automatic Smart Linking.`
* Feel your blood pressure drop to normal levels.
