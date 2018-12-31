---
 
title: 'How To: Use PowerCLI to find (and disconnect) all CD Drives on VMs [Field
  Notes]'
date: 2013-01-28 20:00:00.000000000 -05:00
comments: true
excerpt: "VMs that leave ISOs mounted cause problems. I'd like to find all the VMs that have CD-ROM drives loaded with ISOs, look over that list, and then remove them if necessary."
redirect_from: 
 - /2013/01/how-to-use-powercli-to-find-and.html
 - /2013/01/how-to-use-powercli-to-find-and-disconnect-all-cd-drives-on-vm
 - /2013/01/how-to-use-powercli-to-find-and-disconnect-all-cd-drives-on-vms
---
### Problem
VMs that leave ISOs mounted cause problems. I'd like to find all the VMs that have CD-ROM drives loaded with ISOs, look over that list, and then remove them if necessary.

### Solution (NOTE: Update)

**The first solution I provided here wasn't that great, so I'm updating this post.** The original contents have been changed because they previously would disconnect the entire CD-ROM drive, vs. just unmounting the ISO. As you can imagine, pulling the equivalent of ripping a CD-ROM drive out while a machine is running can cause some interesting behavior. The solution below outlines a much better way to do this.

Two one-line PowerCLI scripts will help us with this.

Firstly, to search for all Connected CD-ROMs for all VMs:

    Get-VM | Where-Object {$_.PowerState –eq “PoweredOn”} | Get-CDDrive | FT Parent, IsoPath

And as long as there aren't any you need to keep up, you can just select them all and then set the state to "No Media" for each CD-Drive:

    Get-VM | Where-Object {$_.PowerState –eq “PoweredOn”} | Get-CDDrive | Set-CDDrive -NoMedia -Confirm:$False

Note the `-Confirm:$False` to allow it to just proceed with what it needs to do.
