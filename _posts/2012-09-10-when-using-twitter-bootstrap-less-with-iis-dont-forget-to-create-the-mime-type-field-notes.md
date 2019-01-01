---
 
title: When using Twitter Bootstrap LESS with IIS, don't forget to create the MIME
  Type [Field Notes]
date: 2012-09-10 18:00:00.000000000 -04:00
comments: true
redirect_from: 
 - /2012/09/when-using-twitter-bootstrap-less-with.html
---
### Problem
I am using the Twitter Bootstrap LESS source with LessJS in an ASP.NET MVC3 Project that deploys to IIS.

* When I run my local source, the web site displays fine.
* When I run my build process, it completes fine.
* When I open the site on my development or production boxes, the CSS doesn't display.

### Solution
After making the problem much more complicated than it had to be, I realized that my LESS file wasn't being found by IIS -- not because it wasn't there or wasn't being deployed, but because I had never configured IIS to *serve* LESS files. Rookie move.

To ensure IIS can serve LESS files, take the following steps:

* Open the IIS 7 Manager application
* Navigate to your server.
* From the different options displayed, select `MIME Types`.
* On the right-hand side, from the `Actions` menu, select `Add...`
* In the `File name extension` field, enter `.less`
* In the MIME type field, enter `text/css`
* Click `OK` to add the MIME type.

Bingo! Now your server won't choke when trying to serve a .less file.
