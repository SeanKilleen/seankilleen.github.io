---
layout: post
title: 'How To: Stop "Access Denied" errors in MVC Intranet Applications VS 2012/IIS
  Express [Field Notes]'
date: 2012-12-10 17:00:00.000000000 -05:00
comments: true

redirect_from:
 - /2012/12/how-to-stop-access-denied-errors-in-mvc.html
---
###Problem
* Using Visual 2012 and IIS Express
* Building an MVC4 Intranet project
* Authentication Doesn't appear to work; I always get an "Access Denied" screen on every page.

###Cause
This happens because IIS Express isn't configured by default for Windows Authentication.

###Solution
* Run your project.
* While it is running / showing you the error, find the IIS Express Icon in your system tray
* Right-click the icon and select `Show all Web Applications`.
* Click on your web application.
* Look at the `Config` property to find where your applicationhost.config file is stored.
* Stop your web site and open that applicationhost.config file for editing.
* Find the section where `WindowsAuthentication enabled` is set to `false` and change it to `true`. 
* Save the file.

###References


* [Access is denied in MVC 4 Intranet Application in VS 11](http://chanmingman.wordpress.com/2012/06/19/access-is-denied-in-mvc-4-intranet-application-in-vs-11/) [[Chanmingman's Blog]](http://chanmingman.wordpress.com/)
* [Activare “WindowsAuthentication” pe IIS Express 8 (VS2012)](http://maran.ro/2012/09/06/activare-windowsauthentication-pe-iis-express-8-vs2012/) [[Lucian Maran]](http://maran.ro/)
