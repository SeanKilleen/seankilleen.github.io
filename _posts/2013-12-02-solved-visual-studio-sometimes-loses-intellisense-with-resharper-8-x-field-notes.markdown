---
layout: post
title: 'Solved: Visual Studio sometimes loses Intellisense with ReSharper 8.x [Field
  Notes]'
date: 2013-12-02 18:30:00.000000000 -05:00
comments: true
excerpt: "Sometimes, for whatever reason, Intellisense will go away in Visual Studio while using ReSharper."
redirect_from: 
 - /2013/12/solved-visual-studio-sometimes-loses.html
---
###Problem
Sometimes, for whatever reason, Intellisense will go away in Visual Studio while using ReSharper.

This is a bummer, because Intellisense is a huge help, and very easy to take for granted until it's gone.

###Resolution
Some folks reported having to close and reopen Visual Studio to get this to work, but I was able to fix it in the following way:


* From the ReSharper Menu, choose `Options`:
![Resharper menu]({{site.post-images}}/2013-12-02_ReSharperIssue_01.png)
* From the Intellisense Menu, choose `General`:
![Resharper Intellisense Menu]({{site.post-images}}/2013-12-02_ReSharperIssue_02.png)
* Ensure that `ReSharper` is selected, so you get all that extra goodness:
![General Settings Menu Resharper Selection]({{site.post-images}}/2013-12-02_ReSharperIssue_03.png)
* Click `Save`:
![Clicking the Save button]({{site.post-images}}/2013-12-02_ReSharperIssue_04.png)

At this point, ReSharper appears to refresh its settings and this kicks Intellisense back into action.
