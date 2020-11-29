---
title: Getting Started With PowerShell Core in Windows Terminal
comments: true
tags:
  - powershell
  - powershell core
  - windows terminal
  - shells
  - chocolatey
date: 2020-11-30 10:00 -0500
---
I believe in scripting and automation, and I have come to love PowerShell for its eloquence, especially in a Windows environment.

PowerShell Core really takes this to the next level. It is what PowerShell will be going forward. It is cross-platform (works on Windows, Mac, Linux), and [is open-sourced](https://github.com/PowerShell/PowerShell) (something I particularly love).

So, I wanted to work it into my [Windows Terminal](https://github.com/microsoft/terminal) installation and make sure I'm using it by default so I can get used to any differences. Here's how I did it!

* I use [the Chocolatey package manager], so I installed windows terminal via `choco install windows-terminal`.
* I installed PowerShell Core by running `choco install powershell-core`.
* I opened Windows Terminal and check the list of shells. Great, PowerShell Core is in there!

![The shell list in Windows Terminal, showing PowerShell Core in the list]({{site.post-images}}/getting-started-with-powershell-core-in-windows-terminal/01_PowerShellTerminalInList.png)

But, it's not yet my default. Let's fix that.

* Click the settings icon in the terminal, which opens a settings file (in VS code, in my case, because it's a `.json` file.)

![The settings link in in the shell list]({{site.post-images}}/getting-started-with-powershell-core-in-windows-terminal/02_Settings.png)

* Find the section that lists my profiles:

![The settings file showing the location of the profiles list]({{site.post-images}}/getting-started-with-powershell-core-in-windows-terminal/03_ProfilesListInSettings.png)

* Find the entry for `Windows.Terminal.PowershellCore` and copy the GUID

![The profile entry for powershell core in the terminal settings, showing the unique identifier for it]({{site.post-images}}/getting-started-with-powershell-core-in-windows-terminal/04_FindingGuid.png)

* Scroll up to the `defaultProfile` setting, and paste the GUID.

![The unique identifier pasted into the default profile setting]({{site.post-images}}/getting-started-with-powershell-core-in-windows-terminal/05_PastingGuid.png)

* Restart Windows Terminal, and bingo -- my default shell is now PowerShell Core!

![Windows terminal opened with an icon that indiciates that powershell core is the default]({{site.post-images}}/getting-started-with-powershell-core-in-windows-terminal/06_ItWorks.png)

Happy shelling!
