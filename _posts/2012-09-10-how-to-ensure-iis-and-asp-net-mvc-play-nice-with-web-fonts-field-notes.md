---
 
title: 'How to: Ensure IIS and ASP.NET MVC Play Nice with Web Fonts [Field Notes]'
date: 2012-09-10 18:00:00.000000000 -04:00
comments: true
redirect_from: 
 - /2012/09/how-to-ensure-iis-and-aspnet-mvc-play.html
references: 
 - title: Serving Web Fonts from IIS
   url: http://sebduggan.com/blog/serving-web-fonts-from-iis/
   parenttitle: Seb Duggan
   parenturl: http://sebduggan.com/blog/
---
### Problem:
I'm using ASP.NET MVC via IIS and would like to make use of Web Fonts.

### Solution
There are two steps:

* Make sure your Web Font files are going to be outputted by your build process.
* Make sure IIS can serve those web files.
#### Step 1: Make Sure Your Web Font Files are Going to be Outputted by Your Build Process
* In Visual Studio, select all your web font files (EOT, SVG, TTF, and WOFF files)
* Right-click on them and select properties or look at the properties window.
* Set the `Build Action` Property to `Content`
* Set the `Copy to Output Directory` property to `Copy Always`.

#### Step 2: Make Sure IIS Can Serve Your Web Font Files
In IIS, make sure you have the following file extensions and the corresponding MIME types:

* .eot &rarr; application/octet-stream
* .woff &rarr; application/x-woff
* .svg &rarr; image/svg+xml

and bingo! Build/deploy your package and it should be right as rain.
