---
title: Troubleshooting my desktop's upgrade to Win10 v2004
comments: true
tags:
  - win10
  - upgrade
  - troubleshooting
date: 2020-08-11 23:14 -0400
---
* Froze at 60%
* Checked the logs, see failure (TODO: capture error code)
* Download and run SetupDiag.exe from MS.
* Check the logs
* Get more info

Steps to attempt to troubleshoot:

* Disabling anti-virus
* Running DISM: `DISM /online /cleanup-image /restorehealth`
* Running SFC: `sfc /scannow`
* The incantation of stopping windows update services, removing downloaded files, etc. -- wrote a powershell script to do it.

```powershell
# TODO: Paste here
```

* Downloaded an off-line version of the Upgrade
* Disabling devices -- wrote a powershell script to do it

```powershell
# TODO: Paste here
```

* Detaching all peripherals (including mouse & keyboard -- used an old classic USB keyboard)