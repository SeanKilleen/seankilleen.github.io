---
 
title: 'How To: Run VMWare PowerCLI (PowerShell) Scripts as a Scheduled Task [Field
  Notes]'
date: 2013-01-28 19:00:00.000000000 -05:00
comments: true
redirect_from: 
 - /2013/01/how-to-run-vmware-powercli-powershell.html
 
references: 
 - title: "Scheduled Powershell scripts not passing authentication to Connect-VIServer"
   url: http://powershellcommunity.org/Forums/tabid/54/aft/4295/Default.aspx
 - title: "PoSH Article of the Week! – Secure Credential Storage"
   url: http://professionalvmware.com/2009/04/posh-article-of-the-week-secure-credential-storage/
 - title: "Powershell VMWare Script not running from Scheduled Task"
   url: https://serverfault.com/questions/473072/powershell-vmware-script-not-running-from-scheduled-task/473086
---
### Problem
I need to create a scheduled task that runs a powershell script that takes actions against my VMWare environment.

For this article, we'll use the example of shutting down all VMs in a Non-Production folder when we're not scheduled to be at our desk (a real problem I'd faced).

### Solution
#### Before you Begin
This solution assumes that you've already got PowerCLI configured and know your way around a little bit of PowerCLI/PowerShell.

#### Step 1: Create a VMWare Credential Store in a File
Firstly, your script will need login permissions to connect to a VI server. We can set this up ahead of time by  creating an encrypted credential store for your server.

* Open PowerCLI as an Administrator.
* Run the following command:

```powershell
New-VICredentialStoreItem -host 'yourhost.yourdomain.com' -user 'yourusername' -password 'yourpassword' -file C:\Path\To\Store\TheFile\In.creds
```

**NOTES**: When creating the credential store, you'll want to create it as the same user that will eventually need to access it. If you create the credential file as user X but run the Scheduled Task as user Y, your task will be unable to read the file. Also, you don't need to have a file extension, but I use "creds" just to make it clearer to me. Obviously, replace the host, username, password, and path with something that makes sense to you.

#### Step 2: Create a Script that Uses the Credential Store

Create a PowerShell Script Similar to the following:

```powershell
#Stop an error from occurring when a transcript is already stopped
$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
 
#Reset the error level before starting the transcript
$ErrorActionPreference="Continue"
Start-Transcript -path C:\temp\Shutdown_NonProductionVMs.log -append
 
#Add the VMWare Snap-in
Add-PSSnapin -Name VMWare.VimAutomation.Core
 
#Get the Credentials
$creds = Get-VICredentialStoreItem -file  C:\temp\pscreds.creds
 
#Connect to the server using the credentials file
Connect-VIServer -Server $creds.host -User $creds.User -Password $creds.Password
 
#Get all VMs within the non-production VMs folder and then shut them down
#NOTE the -WhatIf tag, which will stop it from shutting down the VMs until we're sure the script is good.
 
Get-Folder -Name "03. Non-Production VMs" | Get-VM | Shutdown-VMGuest -WhatIf
 
#Clean Up
Disconnect-VIServer -Force -Confirm:$false
Remove-PSSnapin -Name VMWare.VimAutomation.Core
Stop-Transcript
```

#### Step 3: Set up the Scheduled Task

* Create a scheduled task in the task scheduler.
* Run the task with the highest privileges.
* In the action for the task, run the program/script `powershell.exe`. 
* For the arguments, use `"c:\Path\To\YourScript.ps1"` (with quotes in case of spaces -- good habit).

Test your task manually several times. Make sure the log output looks right.

#### Taking it Live: Removing the -WhatIf
When the task is scheduled and you're satisfied it will run as you intended it, edit the script to remove the `-WhatIf` line. This means the Guest OSes will actually be shut down.

#### Afterwards: Gotchas
I gained some insights from this process, mostly by trial and error. I thought I should share the fruits of my errors with you:

* Do not run a powershell script directly as a scheduled task. It does not work. Use the `powershell.exe "C:\Path\To\script.ps1"` format to execute.
