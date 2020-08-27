---
title: Getting Started With PowerShell Core in Windows Terminal
comments: true
tags:
  - powershell
  - powershell core
  - windows terminal
  - shells
  - chocolatey
date: 2020-08-27 07:47 -0400
---
I believe in scripting and automation, and I have come to love PowerShell for its eloquence, especially in a Windows environment.

PowerShell Core really takes this to the next level. It is what PowerShell will be going forward. It is cross-platform (works on Windows, Mac, Linux), and [is open-sourced](https://github.com/PowerShell/PowerShell) (something I particularly love).

So, I wanted to work it into my [Windows Terminal](https://github.com/microsoft/terminal) installation and make sure I'm using it by default so I can get used to any differences. Here's how I did it!

* I use [the Chocolatey package manager], so I installed windows terminal via `choco install windows-terminal`.
* I installed PowerShell Core by running `choco install powershell-core`. 
* I opened Windows Terminal and check the list of shells. Great, PowerShell Core is in there!

TODO: Image of powershell highlighted

But, it's not yet my default. Let's fix that.

* Click the settings icon in the terminal, which opens a settings file (in VS code, in my case, because it's a `.json` file.)

TODO: Image of settings icon

* Find the section that lists my profiles:

TODO: Screenshot of settings

* Find the entry for `Windows.Terminal.PowershellCore` and copy the guid

TODO: Image of guid

* Scroll up to the `defaultProfile` setting, and paste the guid.

TODO: Image

* Restart Windows Terminal, and bingo -- my default shell is now PowerShell Core!

TODO: Image

Happy shelling!