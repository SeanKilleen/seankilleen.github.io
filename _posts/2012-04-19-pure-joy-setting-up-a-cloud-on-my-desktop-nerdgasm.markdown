---
layout: post
title: 'Pure Joy: Setting up a cloud on my desktop [Nerdgasm]'
date: 2012-04-19 22:25:00.000000000 -04:00
---
I am currently running the following setup on my beast of a desktop:

* VirtualBox x64
* Two VMs of XenServer, each with 8 GB of RAM
* A guest OS of CentOS Desktop, one on each of the XenServers
* A VM of CloudStack via VirtualBox with 4GB of RAM, managing the XenServer servers
* Using XenCenter directly from the Desktop as another means of Managing the XenServers.

I'm pretty sure that's the beginning of a cloud right there, without ever having to leave 127.0.0.1.
