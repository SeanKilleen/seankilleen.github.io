---
 
title: CruiseControl .NET, VisualSVN, and SSL Certificates [Field Notes]
date: 2012-05-01 17:58:00.000000000 -04:00


redirect_from: 
 - /2012/05/cruisecontrol-net-visualsvn-and-ssl.html
---
This is a quick post for my reference. Let me know if details would be helpful and I'll be happy to turn it into more of a tutorial style.

### Problem:

I am integrating CruiseControl.NET with VisualSVN. I'm using a self-signed https on VisualSVN that doesn't match. Because I can't get CruiseControl to accept the certificate permanently, I can't get it to check out files.

### Solution

* You should have a local user account for your build process (with only access to what it needs, of course). This is essentially a local service account.
* Log on to that service account on the local machine.
* Using the command line, check out the VisualSVN repository into a folder you created and accept the certificate. Something along the lines of `svn.exe checkout https://[servername]:8443/svn/[ProjectName] --username [user] --password [password]` should do it.
* The certificate message will then pop up. Type `p` to accept it permanently.
* Now you have an account that has the access you need.
* Go into `services.msc`
* Set the CruiseControl.NET service to run as the local build user service account, with the password.
* Restart the CruiseControl.NET
* It now should have access and acceptance of the certificate.
