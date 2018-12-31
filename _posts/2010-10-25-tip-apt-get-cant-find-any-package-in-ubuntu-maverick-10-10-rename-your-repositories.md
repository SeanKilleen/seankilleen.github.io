---
layout: post
title: 'Tip: apt-get can''t find any package in Ubuntu Maverick 10.10? Rename Your
  Repositories.'
date: 2010-10-25 11:29:00.000000000 -04:00
comments: true
redirect_from: 
 - /2010/10/tip-apt-get-cant-find-any-package-in.html
references: 
 - title: "Ubuntu 10.10 Maverick Server — apt-get install commands fail"
   url: http://serverfault.com/questions/194173/ubuntu-10-10-maverick-server-apt-get-install-commands-fail
   parenttitle: "ServerFault.com"
   parenturl: http://ServerFault.com
---
It appears that the shipped version of Ubuntu Maverick 10.10 (at least the server version) comes with repository server URLs that are incorrect -- or at least non-functioning. I discovered this the hard way after much trial, error, and self-doubt. I hope the masses benefit from my suffering. :)

### The symptoms:
* Can connect to the network
* Can run "sudo apt-get update"
* Can run "sudo apt-get upgrade"
* Cannot run "sudo apt-get install [package name]" for ANY package.

### The Solution:
* Open nano to edit the file:
>sudo nano /etc/apt/sources.list

* Edit all "http://us.archive.ubuntu.com" to "http://archive.ubuntu.com"
* Uncomment all the lines that start with "deb" or "deb-src" (if you know what you're doing). *NOTE:* Make sure that the text starts the line (i.e. don't leave a space -- bad practice).
* CTRL + X, Y to allow overwrite, enter to save to the current file name.

* Update packages:
> sudo apt-get update

* Upgrade:
> sudo apt-get upgrade

* Badda-bing, it works!

Not sure if this is an ongoing or temporary issue, but hopefully this will be fixed by the team in time one way or another.

**NOTE:** This is a bit of short-hand post, meant mostly as a reference for those who know their way around a little. If you have any questions, please ask in the comments, and I'll be happy to help! For the full discussion, please see [the thread on ServerFault.com][SF Thread]. 

Thanks for reading. Any clarifications or other tips regarding this? Sound off in the comments -- all are welcome! :)

[SF Thread]: http://serverfault.com/questions/194173/ubuntu-10-10-maverick-server-apt-get-install-commands-fail