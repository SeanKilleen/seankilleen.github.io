---
layout: post
title: 'How to: Drag and Drop Files to an Elevated Program [Field Notes]'
date: 2014-03-05 19:00:00.000000000 -05:00
comments: true
---
###Problem

I run Visual Studio as an Administrator, which is helpful, but also means that I can't drag &amp; drop files / folders from Windows Explorer (since it's not elevated). That's a pain in the butt.

###Solution

Thanks to [a handy discussion on the HowToGeek site](http://www.howtogeek.com/forum/topic/how-to-run-explorerexe-shell-as-an-administrator-win7), I found the following tip.

[Caveat: this [works on my machine](http://blog.codinghorror.com/the-works-on-my-machine-certification-program/), a work desktop using Windows 7.]

####To enable an elevated windows explorer:
* Right-click on the task bar and select `Start Task Manager`
* In Task Manager, select `File > New Task (Run...)`
* You should see a note that this will be run using administrative privileges. 

* Enter `explorer.exe` and hit enter.
You can now drag and drop files into other elevated windows with ease! 

###References
* <a href="http://blog.codinghorror.com/the-works-on-my-machine-certification-program/" >The "Works On My Machine" Certification Program</a> [<a href="http://codinghorror.com/" >CodingHorror</a>]
* <a href="http://www.howtogeek.com/forum/topic/how-to-run-explorerexe-shell-as-an-administrator-win7" >(Solved) - How To: Run explorer.exe [shell] as an Administrator - Win7</a> [<a href="http://howtogeek.com/" >HowToGeek</a>]
