---
layout: post
title: 'Quick Tip: The "shell:" prefix in Windows 8.1 dialogs (Finding the Startup
  Folder in Windows 8.1 quickly and more!)'
date: 2014-01-18 22:34:00.000000000 -05:00
---
Every once in a while I'll Google for something relatively straightforward to see if there's a better way to do it.

Today, that was finding the startup folder with Windows 8.1 -- and I'm glad I looked!

I found an excellent Microsoft KB Article (unfortunately I lost the link). Apparently, you can just open a run dialog and type `shell:startup`:

![Run dialog with "shell: startup" in the box]({{site.post-images}}/2014_01_18_22_18_52_Blogger_SeanKilleen.com_Create_post.png)
<div align="center">It can't be this easy...can it?</div>

...and voila! The startup menu is there.

![The startup menu having appeared.]({{site.post-images}}/2014_01_18_22_19_51_Startup.png)

<div align="center">Holy cow, it IS that easy!</div>

A lot easier than remembering `C:\Users\Sean\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`, if I do say so.

I did some more digging and found [a great post on PeteNetLive](http://www.petenetlive.com/KB/Article/0000709.htm) that goes through some of the other shortcuts that exist as well.

And the potential exists for more! Per the article, you just have to open `regedit.exe` and navigate to `HKLM > Software > Microsoft > Windows > CurrentVersion > Explorer > FolderDescriptions`. In there is a menu with all of the GUIDs. Look at the `Name` property for the thing you'd have to type. I see a few interesting ones on mine, though your mileage may vary.

###References
* <a href="http://www.petenetlive.com/KB/Article/0000709.htm" target="_blank">KB 0000709 - "Where's the Startup Folder?"</a> <a href="http://www.petenetlive.com/" target="_blank">[PeteNetLive]</a>
