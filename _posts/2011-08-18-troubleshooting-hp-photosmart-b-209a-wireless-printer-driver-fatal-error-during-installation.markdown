---
layout: post
title: 'Troubleshooting: HP PhotoSmart B-209a Wireless Printer Driver "Fatal Error
  During Installation"'
date: 2011-08-18 21:35:00.000000000 -04:00
comments: true

---
I recently re-installed Windows 7 x64 on my laptop due to purchasing an SSD. I expected fantastic speed &amp; performance, more productivity, etc.

What I didn't expect was for HP Driver setup to make me want to tear my hair out.

What follows is a brief and too-technical tale of how I vanquished the foe, for my own reference. If you're less-than-technical or think they could help you, just ask me for details or screenshots in the comments and I'll be happy to provide them.

###The Problem
HP Driver setup for a wireless printer already configured on your network yields a generic "Fatal Error During Installation" message. Though my Antivirus/Firewall were disabled and I ran the downloaded installer as Administrator, I still received the message whenever I ran the setup program.

###Applies To
I have not tested this in any other environments, so I'm assuming it applies to:

* HP PhotoSmart B-209a printers that have already been configued on the wireless network
* Win 7 Professional 64-bit

###The Solution Steps
* **Disable Your Antivirus Applications (Firewalls are OK).** Though not the root cause of the issue, Antivirus programs can still muck with the process. Best to temporarily disable. Firewalls on the other hand, you would like to have running so that you can ensure you allow the network connections necessary for the device.
* **Take ownership of your local temp directory.** I did this by running the command: 
>takeown /f C:\Users\Username\AppData\Local\Temp /r /d y

where `Username` is your own username.

* **Remove all restrictive attributes from the Temp directory.** This can be done by running:

>attrib -R -A -S -H C:\Users\Username\AppData\Local\Temp /S /D

where `Username` is your own username.

* **Find where your installation is located in the Temp directory**. For me, it was `C:\Users\Username\AppData\Local\Temp\7zS08A6"` where `Username` is your username. The exact folder may be different but I'm hoping they kept it the same.
* **Run the actual setup program as Administrator.** Within the installation directory you found in the last step, right-click on `setup.exe` and select `Run as Administrator`

With those steps (and a little bit of luck and/or voodoo magic) the install should complete successfully.

Hope this helps someone! If you have any questions or would like more detail, feel free to ask in the comments.

Happy Troubleshooting!
