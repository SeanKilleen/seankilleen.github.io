---
layout: post
title: 'Fix: CentOS 5.x hangs during VirtualBox install [Field Notes]'
date: 2011-11-29 20:12:00.000000000 -05:00
comments: true

---
###Technology Involved
* Win7 Pro x64
* VirtualBox 4.1.x
* CentOS 5.x


###Problem
When attempting to install a CentOS Guest VM from a VirtualBox Win7 x64 host, the installation appears to hang shortly after beginning.

The last line of text on the screen is:
> NET: Registered protocol family 2

###Solution
Per [this thread](https://forums.virtualbox.org/viewtopic.php?f=9&amp;t=23900) (referencing an older version of VirtualBox but still relevant), the fix is as follows:

* Go into the settings of the VM
* Click the `System` section.
* Check `Enable IO APIC`.
* Save the settings.

When you start the install again, it will proceed normally.

###References
* [Failure Installing CentOS 5.4 on VB 3.0.8](https://forums.virtualbox.org/viewtopic.php?f=9&amp;t=23900) [[VirtualBox Forums](https://forums.virtualbox.org/index.php)]
