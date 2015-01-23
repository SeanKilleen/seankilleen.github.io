---
layout: post
title: 'Building a Build Process: Installing CruiseControl.NET'
date: 2012-05-03 00:48:00.000000000 -04:00
comments: true
series: building-a-build-process
redirect_from: 
 - /2012/05/building-build-process-part-7.html
 
references: 
 - title: "CruiseControl.NET Home Page"
   url: http://www.cruisecontrolnet.org/
 - title: "CruiseControl.NET Releases Page on SourceForge"
   url: http://sourceforge.net/projects/ccnet/files/CruiseControl.NET%20Releases/
 - title: "Installing and Configuring CruiseControl.NET"
   url: http://www.matthewbussa.com/2011/05/installing-and-configuring-cruise.html 
   parenttitle: "MatthewBussa.com"
   parenturl: http://www.matthewbussa.com
---

### Adding a HDD to your VM for CI Information
I find this makes it easier to keep your CI files separate, and it’s definitely a good practice in a production environment in my experience. Virtualization makes this easier as well because all the virtual hard drive files only take up as much space as they use. Definitely an upside to VMs.

To add a new HDD to the VM, do the following:

* Power down your Windows Build Server VM if it’s on.  
* Open VirtualBox  
* Right-click on your BobTheBuilder machine and select `Settings…`
* Click the `Storage` Section on the Left-hand side  
* Note the two icons next to the `SATA Controller` section. Click the one on the right (`Add Hard Disk`). The Hard disk wizard will open.  
* Click `Create New Disk`
* Choose your Disk Format (I left it as the default, VDI)  
* Choose `Dynamically Sized`  
* Name the Disk. I usually follow the format of `[MachineName]_[DrivePurpose]`, so in this case I chose `BobTheBuilder_CIDrive`  
* Set the size of the drive. I left the default (25 GB)  
* Next screen is the summary. Click create to create the drive.  
* Start the VM again and login.

Now we have a hard drive initialized, but we still need to format it before the OS can see it. To do this:

* Click start and type `diskmgmt.msc` to bring up the disk management utility.  
* You’ll see a dialog box to ask you to initialize the disk.  
* Select MBR for the type of initialization and click OK.  
* Now, right-click on the `Disk 1` entry to the bottom (the disk should indicate that it has 25 GB of unallocated space) and select `New Simple Volume`, which will open a wizard.  
* The amount of space for the drive will default to 100%. This is what we want, so click next.  
* Assign the drive letter of your choice. The default was `E:` for me, so I left it. Henceforth in this tutorial series, I’ll be calling it `E:` so you may want to choose `E:` to make it easier to follow along.  
* On the next screen, choose to format the volume as NTFS and give it the volume label of `CI`.  
* Click `Finish` to complete the process.After a few seconds, you should see the E: drive appear in your drives list. Open Windows Explorer and verify that it exists there, too.

### Creating a Home for Our CI Files
Now that we have a drive, it makes sense to create our directory structure.

On the E: drive, create the following directory structure:

	TestProject\
		CIArtifacts\
		WorkingDirectory\

`CIArtifacts` will store the output of our CI (logs, etc.); `WorkingDirectory` will be where we eventually check out the source code to automatically in order to act upon it.

### Downloading the CruiseControl.NET Binaries
* On the build server, head to the [CruiseControl.NET Releases Page on SourceForge]
* Click the newest release version (1.6 as of the time of this writing)
* Download the CruiseControl.NET executable and the CCTray executable.

### Installing CruiseControl .NET
* Run the CruiseControl.NET Setup executable as an administrator by right-clicking and selecting “Run as Administrator”. 
* Agree to the license agreement.
* All options are selected by default; leave them and continue.
* Leave both checkmarks checked to install the CruiseControl .NET dashboard and to install CCNet as a service.
* Leave the default installation directory or customize to your preference (I left the default for this setup)
* Leave the default value for the Program Files folder group and click `Next`. CruiseControl.NET will commence installation.
* Click `Finish` and exit the wizard.

### Installing CCTray
CCTray allows you to connect to one or more CruiseControl.NET projects and will keep you informed on their status.

You’ll want to repeat this process on the Build Server itself and on any desktops you’d like to see the status of the build on (for example, I have CCTray installed on my laptop’s desktop so I can quickly see if a build is broken).

To install CCTray, perform the following (don’t worry, we’ll configure it later):

* Run the CCTray setup file and click `Next` at the introduction.
* Agree to the license agreement.
* Leave all three options selected and click next.
* Click `next` through the installation location and start menu group name screens. The application will install.
* Click `next`, and then click `Finish`, leaving the checkbox selected to start the program.

Now CCTray is started (though not configured yet.)

### Install / Start the CCNet Dashboard in IIS
* `Click Start > Administrative Tools > IIS Manager`
* Expand the tree on the left-hand side to `[Server Name] > Sites > Default Web Site`.If you don’t see a directory under `Default Web Site` called `ccnet`, perform the following steps (otherwise, skip to after this bulleted list):

* Right-click on Default Web Site and select `Add Virtual Directory…`
* Give `ccnet` as the alias
* For the path, choose `[CCNet Install Directory]\webdashboard`. (e.g. for me, it was `C:\Program Files (x86)\CruiseControl.NET\webdashboard`)
* Click `OK`. The Virtual Directory will appear.
* Right-click the ccnet Virtual directory and choose `Convert to Application`.
* Click `OK` in the dialog box that appears.Now your ccnet virtual directory is set up. 

Keep going:

* Click on `Default Web Site`
* On the right-hand side Action menu, click `Start` to start the default web site (if it’s not already started).
* Open a web browser on the build server and navigate to http://localhost/ccnet

If a web site shows up at all, you’re good to go. Don’t worry about any errors within the web dashboard application, as we’ll be configuring CCNet later.

[Installing and Configuring CruiseControl.NET]: http://www.matthewbussa.com/2011/05/installing-and-configuring-cruise.html 

[CruiseControl.NET Releases Page on SourceForge]: http://sourceforge.net/projects/ccnet/files/CruiseControl.NET%20Releases/