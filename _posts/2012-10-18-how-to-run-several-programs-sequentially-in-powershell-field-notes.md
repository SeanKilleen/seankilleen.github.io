---
 
title: 'How To: Run Several Programs Sequentially in PowerShell [Field Notes]'
date: 2012-10-18 19:00:00.000000000 -04:00
comments: true
redirect_from: 
 - /2012/10/how-to-run-several-programs.html

references: 
 - title: "PowerShell - Pause Script While External Program Runs"
   url: http://stackoverflow.com/questions/8902585/powershell-pause-script-while-external-program-runs
   parenttitle: StackOverflow
   parenturl: http://stackoverflow.com/
 - title: Start-Process
   url: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-6
   parenttitle: TechNet
   parenturl: http://technet.microsoft.com/
---
### Problem:
I want to run several installation programs in order, and don't want them to step on each other.

I want to avoid errors such as "another setup program is already running" which result in the second install not completing.

### Solution

For files without arguments, run:

```powershell
$var1 = Start-Process -FilePath "[path]" -passthru
$var1.WaitForExit()
```

For files with arguments, run:

```powershell
$var1 = Start-Process -FilePath "[path]" -ArgumentList "[Args]" -passthru
$var1.WaitForExit()
```

In these examples, `[path]` is the full path to the file (e.g. `C:\SomeFolder\MyProgram.exe`) you want to run. `[Args]` is whatever you'd normally put after the path to the exe in the command line.

**NOTE**: Single quotes around the file path will ensure the command will not break if it includes a space in the path.
