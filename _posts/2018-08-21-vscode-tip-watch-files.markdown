---
title: "VSCode Tip: Watching Files"
layout: post
date: 2018-08-21 13:00:00.000000000 -05:00
excerpt: "Yet another VSCode is helpful as my editor of choice."

references:
 - title: "Log Viewer"
   url: https://marketplace.visualstudio.com/items?itemName=berublan.vscode-log-viewer
   parenttitle: "VS Marketplace"
   parenturl: https://marketplace.visualstudio.com
 - title: "VS Code Can Do That?!"
   url: https://vscodecandothat.com/

comments: true
---

File this under [VS Code Can do That?!](https://vscodecandothat.com/)

Sometimes I need to watch a log file or other file for changes, whether it be on my local machine or a remote server. On windows this can be a bit of a pain, and you oftentimes have to dump out of your IDE to make it happen.

So on a whim one day, I said "I wonder if VS Code can do that". I search the extensions, and lo and behold, VS Code *can* do that!

## Enter VS Code and the Log Viewer Extension

* Open VS Code
* Click on the `Extensions` button
* Type `Log Viewer` in the search box
* Find the [Log Viewer Extension](https://marketplace.visualstudio.com/items?itemName=berublan.vscode-log-viewer) and install it.

## Setting up the Extension

* In VS Code, ppen the Command Bar (for me, `CTRL + Shift + P` does this)
* Type `Workspace Settings` or similar and then select `Preferences: Open Workspace Settings`
* In the settings, add a section for `logViewer.watch` that defines some titles and patterns for files that you'd like to watch. Below is an example of watching two separate files on different servers. I add the below and save my preferences

```json
{
    "logViewer.watch": [
        {
            "title": "Server 1 IIS",
            "pattern": "\\\\servername\\C$\\inetpub\\logs\\LogFiles\\W3SVC2\\u_ex180718.log"
        },
        {
            "title": "Server 2 IIS",
            "pattern": "\\\\servername2\\C$\\inetpub\\logs\\LogFiles\\W3SVC2\\u_ex180718.log"
        },
    ]
}
```

## What are the Results?
The log viewer opens a screen, and we can see all the applicable watches and view their updates as they change.

![Results]({{site.post-images}}//2018-08-21_vscode-logviewer-watches.png)

## What do you Think?
Hope you enjoyed this tip! Drop your other favorite tips in the comments, and check out [VS Code Can do That?!](https://vscodecandothat.com/) for a lot of other great tips!