---
 
title: 'How To: Compare Two Sets of Internet Explorer Security Settings [Field Notes]'
date: 2012-02-22 13:43:00.000000000 -05:00
comments: true
redirect_from: 
 - /2012/02/how-to-compare-two-sets-of-internet.html
references: 
 - title: "Aaron Margosis' Non-Admin, App-Compat and Sysinternals WebLog"
   url: https://docs.microsoft.com/en-us/archive/blogs/aaron_margosis/
   parenttitle: MSDN Blog Archive
   parenturl: https://docs.microsoft.com/en-us/archive/blogs/
 - title: IEZoneAnalyzer v3.5 with Zone Map Viewer
   url: http://blogs.technet.com/b/fdcc/archive/2011/09/22/iezoneanalyzer-v3-5-with-zone-map-viewer.aspx
   parenttitle: Microsoft's USGCB Tech Blog
   parenturl: http://blogs.technet.com/b/fdcc/default.aspx
---
### The Problem

A web application doesn't work correctly for a user, and from the description of the issue I think it might have to do with security settings. The application works fine for me.

How do I see what settings I have that the user doesn't?

### The Solution

Enter [Aaron Margosis][Aaron Link] 's excellent [IEZoneAnalyzer utility]. It allows you to do just that: view, export, and compare Internet Explorer Zone settings.

The steps I generally use are below:

1. **Download the utility**: visit the [IEZoneAnalyzer 3.5 page][IEZ Download Link], or use [this direct download link][IEZ Direct] (from the page).
1. **Unzip the utility**: It is a standalone .exe file; no installation necessary.
1. **Run the utility**. It will analyze some things as it starts up.
1. From the `File` menu, select `Export Local Settings...` and save under the filename of your choosing.
1. I usually then repeat this process on my machine so I have a snapshot to compare it to.
1. From the `File` menu, select `Import saved Settings...` and select the file with the snapshot. Repeat this for the user's snapshot and your own. **Pro Tip:** You can use `CTRL+Click` to select multiple files to import.
1. Under the `View / Compare Entire Collections of Settings` section, select your settings and click the `Add Set to Comparison List` button. Repeat the process for the user's settings.
1. Click the `View/Compare Sets` button.

At this point, the program will pop up a window with all the different zone settings, and any differences will be highlighted in yellow. You can export to CSV or Excel at this point.

And that's it! Thank you to Aaron for providing such an excellent utility.

[Aaron Link]: https://docs.microsoft.com/en-us/archive/blogs/aaron_margosis/
[IEZoneAnalyzer utility]: https://blogs.technet.microsoft.com/fdcc/2011/09/22/iezoneanalyzer-v3-5-with-zone-map-viewer/
[IEZ Download Link]: https://blogs.technet.microsoft.com/fdcc/2011/09/22/iezoneanalyzer-v3-5-with-zone-map-viewer/
[IEZ Direct]: https://msdnshared.blob.core.windows.net/media/TNBlogsFS/prod.evol.blogs.technet.com/telligent.evolution.components.attachments/01/5808/00/00/03/45/50/87/IEZoneAnalyzer.3.5.0.5.zip
