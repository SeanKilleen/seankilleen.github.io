---
layout: post
title: 'Building a Build Process: CruiseControl.NET Preparation'
date: 2012-05-03 13:36:00.000000000 -04:00
comments: true
series: building-a-build-process
redirect_from: 
 - /2012/05/building-build-process-part-8.html
references: 
 - title: PsExec Website
   url: http://technet.microsoft.com/en-us/sysinternals/bb897553
---

###Choosing Whether to Run as Network Service or another user
This was brought up as an excellent point by Bahrep on a recent blog post of mine, and I thought it was worth sharing for this series. 

Essentially, the issue is that CruiseControl.NET runs under the network service user (which makes sense), but in order to accept an SVN certificate, you need to be logged in as that user and check out a copy of the repository once to accept the certificate before CruiseControl will be able to connect to the repository as itself.

There are two ways you can go about this. The more visible way is to create a local user account on the server (i.e. “CI”) which you then tell CruiseControl to run as. You give CI the permissions it needs, including signing on to that user account once , checking out the repository, and accepting the certificate.

The second option is to download and install PsExec, which lets you run programs under other user accounts. You then use PsExec to run the checkout command as the network service user and accept the certificate. No extra user account, no changing how the service runs. It’s a simpler solution, but a much less visible change that you’ll want to document. 

Directions for both options are shown below. For what it’s worth, **I now prefer option 2.**

###Option 1 Part 1: Creating a Local User for CI Purposes
* Click start and type `compmgmt.msc` to bring up Computer Management.  
* In the left-hand navigation, choose `Local Users and Groups >Users`  
* Right-click and select `New User…`  
* Name the user `CI` or something related to the purpose at hand.  
* Give the user a password.  
* Uncheck `User must change password`
* Check `password never expires`.  
* Create the User account.  
* Right-click the new account and select Properties.  
* Click the `Member Of` tab.  
* Add the user to the `Administrators` Group. **NOTE:** This is **not** ideal for the purposes of production. Normally, you’d want to ensure this user account only has access to what it needs for CC.NET (this is why I’m leaning towards option 2).  
* Now is also a good time to install TortoiseSVN on the build server, if you haven’t yet. (be sure to install the command-line client tools as well!)

####Option 1 Part 2: Accepting the SVN Certificate as the CI User
* Log off the Administrator account and sign in as your new CI account.  
* Run the command prompt  
* Run `svn info` to accept the certificate. This can be done by running: 

        svn info https://[repo URL or hostname]svn/TestProjectRepo –username svnuser1 –password passw0rd1

* Type `p` to accept the certificate permanently, and you’re all set!

####Option 1 Part 3: Run the CruiseControl.NET Service as the CI User
* Log off the CI account and back into the Administrator account.  
* Run `services.msc`  
* Right-click the `CruiseControl.net` service and choose `Properties`  
* Click the `Log On` tab.  
* Click the `This account` radio button.  
* Click Browse and Type CI. THe resulting username entry will be `.CI`
* Enter the password you created for the CI account and click apply.  
* You will see a message that it has been granted the “Log On as a Service" Right.

###Option 2: Using PsExec to Accept the SVN Cert as the Network Service User
**NOTE**: At points during this process, you may receive a warning from your antivirus program. This is because PsExec can be dangerous when misused, and viruses have used it in attacks in the past. We know our usage is legitimate here, so we can unblock/ok PsExec operations when we’re working with it.

* Visit the PsExec Website and Download the application (actually will be a zip file of all the PSExec tools)  
* Unzip the PsExec zip file  
* open a command prompt and navigate to the folder of PsTools  
* Run `psexec -u "nt authoritynetwork service" cmd.exe.` This will run the command prompt as the network service user.  
* Run svn info to accept the certificate. This can be done by running:

        svn info https://[svn ip or hostname]/svn/TestProjectRepo –username svnuser1 –password passw0rd1
  
* Type `p` to accept the certificate permanently, and you’re all set!

###Add a CI User to the Repository
* Open your CentOS source code management VM
* Taking advice from our [Subversion & Apache article]({% post_url 2012-04-17-building-a-build-process-part-4-source-code-management-via-subversion-and-apache-on-centos %}), we’ll run the following command to add a new CI user without deleting the old ones: 

        htpasswd -sb /var/www/svn/auth/svn.htpasswd ci passw0rdci
        
Now you’re set to allow CruiseControl to pull down files under its own again (just around the bend in this series when we configure CCNet).

###Copying the Microsoft Targets to the Build Server
When dealing with this elsewhere, [I discovered this problem](). We’ll avoid it in advance here.

* You have to copy the two files from your local development machine (with VS installed) to the Build Server.
* Copy the directory `C:\Program Files (x86)\MSBuild\Microsoft\VisualStudio\*.*` to the same location on the build server.

###Copying the Reference Assemblies to the Build Server
When dealing with this elsewhere, [I discovered this problem]({% post_url 2012-05-01-cruisecontrol-net-gotcha-moving-microsoft-webapplications-targets-to-the-server-field-notes %}). We’ll avoid it in advance here.

* On your local development machine, copy `C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\*.*` to a folder on your build server. For me, it was `E:\ContinuousIntegration_ReferenceAssemblies` so that it could keep it common for any future builds.

In the next part in the series, we’ll finally configure CruiseControl.NET and get it to build. Thanks for hanging out with me on this epic journey towards build awesomeness!