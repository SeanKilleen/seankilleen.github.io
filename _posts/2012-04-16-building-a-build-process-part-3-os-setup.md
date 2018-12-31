---
layout: default
title: 'Building a Build Process: OS Setup'
date: 2012-04-16 22:28:00.000000000 -04:00
comments: true
series: building-a-build-process
---

Alright, this is a little bit of a cheat post but I wanted to emphasize the simplicity of these setups. 

#### Installing the OSes on our VMs
#### Windows
* Select whichever edition of Windows Server you'd like to install if prompted.  
* Follow the default setup options or customize as you like. Allow it to use the full space of the Virtual HDD we created.
#### CentOS
* **Start up the VM** and proceed through normal, default setup options.
* **Allow the OS to use the standard partition format** and use the entire virtual disk when it asks.
* **You will have to set up a root password and an additional user.** For memory's sake in the demo, I made the root and user password the same, and made the user my first name. This is, again, ***not recommended*** for a production environment. Use a very secure password for the root user, and don't be a dunce about your user account's password, either.
* **Disable the Firewall and SELinux**. These are both important components, and I may turn them on again after everything is configured, but due to my own limitations on their intricacies and the demo purposes, we'll leave them. **IMPORTANT: DO NOT** **run a production system without these turned on**. I'll likely do a follow-up post later indicating ways to do this more securely.
* I chose the Gnome desktop environment because it was the default. Choose the flavor that suits you. 
* When presented with the option for additional components, I checked off `Server - GUI`. To be honest, I'm not even sure what exact capabilities this gives us; it just seemed like a good gut choice. I'll try to look up more on that later (maybe)

### After Installation
#### Windows

##### IE 9 -- But not through Windows Update
You should have IE 9 on a Windows Server. To be honest, I'm not sure why, but it feels right to have the OS-supported "standard" available, even if it's not your first go-to browser. IE 9 on Windows Server provides a great layer of protection over potentially harmful actions, so I use it when I'm in "caution mode". 

However, you'll likely want to obtain IE via [my method described here]({% post_url 2012-04-16-quick-fix-windows-server-2008-r2-internet-explorer-windows-update-issue-field-notes %}), because as of this writing the MS Installer on Windows Update is screwed up.  

##### An alternative browser to IE
You should also have a browser on your machine for those I-know-what-I'm-doing-and-just-get-out-of-my-way-damnit times when you don't feel like dealing with IE's extra protection. I use [Google Chrome], but pick whichever browser suits you.  


##### VirtualBox Guest Additions
This is as easy as clicking `Devices` from the VirtualBox host window (the window that surrounds your VM), and then clicking `Install Guest Additions`. 

VirtualBox pops up an installer on the screen. Follow the default steps to install, or select custom options.

##### IIS WebPI
I highly recommend downloading the [Web PI (Web Platform Installer) from Microsoft][WebPI]. It’s got a great interface for quick configuration of applications and installs.

##### WebPI Downloads – Install the following packages:
* .NET Framework 4.0  
* IIS 7 recommended settings  
* ASP.NET MVC 3

#### CentOS
##### VirtualBox Guest Additions
* Click `Devices` from the VirtualBox Host screen (the screen surrounding your VM) and click `Install Guest Additions…`
* This will bring up a link to a CD on your CentOS desktop, indicating the CD is mounted.
* From there, [follow these directions][Instructions]. Leave a message in the comments if you’d like me to expound on the subject.

### On Both OSes
#### Updates and Patches!
This is very important. I did the following.  
##### On Windows
* Run Windows Update. Restart. Run Windows Update.  
* Repeat this process until there are no more updates available.
##### On CentOS
* Go to the Software Updater, which you can access via `Applications  > System Tools > Software Updater`, as seen below:

![Software updater screen]({{site.post-images}}/05-CentOS-Updates.png)

* Click "Apply Updates" for all available updates.  
* Restart (if necessary).  
* Repeat process until there are no more updates available.
### Initial VM Snapshot
This is optional, but I find that it's always helpful to be able to go back to the beginning when necessary, so I always take a snapshot of VMs after they're created.  

* First, shut down all your VMs so you get a clean snapshot state.
* Click on an image and then click the `Snapshots` button at the upper-right corner, shown below:

![Snapshots button]({{site.post-images}}/07-252520-252520Details-252520and-252520Snapshots_thumb.png)


* Right-click on `Current State` and select `Take Snapshot`, as shown below. You’ll be asked to save the snapshot; I choose the name “Initial Setup” the first time I go through the process.

![Take snapshot button]({{site.post-images}}/08-252520-252520Take-252520Snapshot_thumb-25255B1-25255D.png)

That’s it! Next, we’ll look at setting up our source code management system.

[Google Chrome]: http://google.com/chrome
[WebPI]: http://www.iis.net/webpi
[Instructions]: https://forums.virtualbox.org/viewtopic.php?t=4960