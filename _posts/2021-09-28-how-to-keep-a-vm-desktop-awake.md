---
title: How to Keep a VM / Desktop "awake"
comments: true
tags:
  - shortcuts
  - scripts
  - autohotkey
date: 2021-09-28 15:17 -0400
---
I had a situation where I was working partly on a development VM but also doing research on another machine.

Every few minutes, the VM would lock me out. It was also the only place where MS Teams reported my status, and I hated that I couldn't use my main machine for more than a few minutes before my Teams status would show as idle / away. I'm right here!

I looked for some quick app-based solutions, but none of them inspired confidence. One exception is [the PowerToys Awake app](https://docs.microsoft.com/en-us/windows/powertoys/awake), but it requires a specific version of windows that not all VMs (e.g. server VMs) are updated to just yet.

## Solution: AutoHotkey and a Tiny Script

* Install AutoHotkey: you can head to [their site](https://www.autohotkey.com/), or use  `choco install autohotkey` if you're using [Chocolatey](https://chocolatey.org/).
* Right-click anywhere in windows explorer and choose "new AutoHotkey script". Or, create a file anywhere you want with the extension `.ahk`
* Open the file you created.
* Add the contents of the script as below:

```plaintext
#Persistent
SetTimer, PressTheKey, 120000
Return

PressTheKey:
Send, {F15}
Return
```

* Right-click the script and select `Run`. AutoHotkey will run and put the script in the system tray.

## What is This Script Doing?

Let's take it line by line:

* `#Persistent` [keeps an AutoHotkey script permanently running](https://www.autohotkey.com/docs/commands/_Persistent.htm).
* `SetTimer, PressTheKey, 120000` says to call the `PressTheKey` function (defined below) every 120,000 milliseconds (or ~2 minutes).
* `Return` indicates the end of that script (which will be a permanent loop at that point).
* `PressTheKey:` defines the function that we call in the script.
* `Send, {F15}` presses the `F15` key on the keyboard. More on this below.

## Why the F15 Key?

You'll note that most keyboards only go up to `F12`. But `F13-F15` are valid keys from the olden days. Chances are they're not mapped to anything already, because they're not on most keyboards. F15 is a solid way to mimic a keyboard press without actually pressing keys that could matter (when you're in the middle of typing or have a window open, for example.)

Hope this helps!
