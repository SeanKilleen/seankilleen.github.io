---
title: 'Adventures in Azure Architecture: A Home Desktop Setup'
comments: true
tags:
  - azure
  - architecture
  - blueprints
date: '2019-08-09 08:24 -0400'
---
I recently connected with someone on Twitter who had some questions about architecture for a personal setup in the cloud. I thought the challenge was interesting, so below are the parameters of the question and how I went about trying to architect a solution for her (who I'll generally call "the client" from here on out, even though money isn't changing hands here).

## Background / Goal

The client is moving overseas and cannot take their desktop equipment with them because they'll have no place to store it. They previously used this desktop as a central machine -- VPNing into it during travel, etc. -- and are looking to re-create that sort of central place without being tied to the physical presence of desktop hardware.

## The Stated Constraints

* **Fully cloud-based**: client is looking to have her computing environment primarily based in the cloud
* **Data security is a must**: the client has had backup disasters in the past. Ensuring all of their data isn't going to disappear is paramount.
* **Windows workloads**: the client primarily uses Windows throughout the day.
* **Azure**: the client is primarily interested in Azure services

## Additional Questions I Asked

* **What kinds of data / information?** Occasional graphics-intensive workloads (think Adobe Photoshop & InDesign); Outlook e-mail files; Audacity music files
* **Budget**: Generally speaking, she'd like to keep this as expensive as new hardware would cost when spread over 3 years, so think $1k/year or $83/mo. 
* **Stretch budget**: Client mentioned that if the solution delivered, they could pay up to roughly $200/month, which does give us some wiggle room.
* **Where (roughly) will the client be located?** The client will be located in the UK, but has some data that can't cross boundaries, and so things can be located in the US (they're aware of the lag possibility).
* **How much time per day does the client anticipate using the machine?** Client uses the machine roughly 2-3 hours per day. We can use this to extrapolate costs assuming we can get the tooling in place.
* **Roughly how much data?** 6 TBs but the client feels they could pare it down to 2. This will affect our understanding of costs for things like VM backup

## My Approach

OK, that's a lot of good information to go on. Here's what I'm thinking:

* **Office365**: I think the client will benefit from an Office365 subscription. This will set her up for a lot of web access to office apps that she might need on the go, and will also get her 1 TB of OneDrive storage (more on this in a bit).
* **OneDrive for data storage**: I think a cloud sync service makes a ton of sense, and I think that going with OneDrive as the central file storage point has several advantages. Any files added there will already be synced, and Microsoft has invested tons of money/effort in the resiliency of this system. I'd trust a company that has those resources over my own home-grown solution. Plus, if we set up OneDrive on the desktop, we only need to sync the files that we actually use, meaning that a lot of the data can live in the cloud without costing money on a VM hard drive. And lastly, if she goes for the Office365 subscription, she gets 1TB storage included for $99/year which is a sweet deal in my opinion. And if you're one person, OneDrive technically gets you 5 TB storage. You can create up to 5 accounts, each which 1 TB storage, and share folders between them.
* **VM Choice**: I'm thinking a `D4s v3` VM will make the most sense from what I've heard. 4 CPUs and 16 GB RAM should be good enough for most processing in a pinch.
* **Another option: A second, heavy-workload VM**: Set up similarly but used less often, the heavy workload VM could have higher specs. This would allow the client to incur a lower cost daily and then pop over to the higher spec VM when needed in order to do more intensive work. If we're storing most data in the cloud already then a few minutes of sync time and occasional app upgrades / maintenance should be all that's needed to get things up to date there.
* **Additional Data Option: VM HDD**: Since data protection is of particular concern for this client, she may choose to have data backed up in multiple places. One way they could do this would be to have a low-performing HDD on the VM and ensure that OneDrive keeps a copy of all files on that hard drive. They'd pay for the storage space, but they'd now have the files in two locations always.
* **Additional Data Option: Backblaze**: The client could also add a Backblaze subscription and ship those files to the Backblaze cloud. In that case, she'd have one cloud provider where her files live, a copy on the VM in case that cloud becomes accessible, and an additional backup in backblaze (which could also ship her a hard drive in a pinch if she needs to pay for it)
* **Additional Data Option: VM HDD Backup**: I believe with a VM HDD you can also geo-replicate that as a backup
* **Chocolatey package management**: I recommend installing apps via Chocolatey (a lovely, free tool) because you can export a file that would then let you setup your VM's apps very quickly again, should you need to recreate your setup for some reason.
* **Additional Protection: VM Backup**: You can backup the full VM in Azure.
* **Scheduling shut-downs**: To ensure needless costs don't rack up, we'll want to shut down the VM outside of anticipated usage hours. This is doable via the Azure Portal (assuming a schedule actually works for the client's hours).
* **Quick & Easy on/off**: The client should be able to easily prepare the machine for use when needed and shut it down when they're done, because VMs are billed per second and so any second spent not using it is money saved. Since we'll be in Azure, I'm thinking we'll set up either an Azure function or bot framework deployment linked to some sort of incoming channel (e-mail, text message) so that the client can easily send on/off commands to power up or shut down the VM. This lets it become a natural part of their daily usage without needing to incur the costs of an "always on" machine.

## Trade-Offs

* **Data security concerns vs. Cost Effectiveness**: Client raised the (totally reasonable) point that MS holds the encryption keys to OneDrive storage and so they normally keep minimal files there. However, a 2 TB disk attached to an Azure VM -- excluding backup costs -- will likely run $80-100/mo, which bumps up against the budget constraints. 
* **Graphics**: The client mentioned Adobe Photoshop / InDesign, etc. One of the areas this solution is weak in is that the machines in this setup don't have discrete graphics cards. I'm not sure what to do about that, nor am I sure what the impact will be overall. 

## Calculating the Cost

I used the [Azure pricing calculator](https://azure.microsoft.com/en-us/pricing/calculator/) to attempt to whip up an estimate.

| Item                       | Using OneDrive Storge | No OneDrive | Notes                                                                                                            |
| -------------------------- | --------------------- | ----------- | ---------------------------------------------------------------------------------------------------------------- |
| **Regular VM**             |                       |             |                                                                                                                  |
| Machine                    | $36.55                | $36.55      | 2 vCPU, 8 GB RAM. Assumes 6 hours use per day.                                                                   |
| Storage                    | $19                   | $82         | This is a Standard HDD; SSD would be $153. 256 GB assumed if using OneDrive since most if it stays on the cloud. |
| VM Backup                  | $10                   | $50         |                                                                                                                  |
| **"Intense Use" VM**       |                       |             | Used less often, for more demanding workloads                                                                    |
| Machine                    | $3.78                 | $3.78       | 4 vCPU, 32 GB RAM. Assumes 6 hours use _per month_.                                                              |
| Storage                    | $9.60                 | $9.60       | SSD, 64 GB (assuming she'll use this for work and then store things elsewhere).                                  |
| VM Backup                  | $10                   | $10         |                                                                                                                  |
| **Backblaze Subscription** | $0                    | $6          | Recommended if not primarily storing things on an automatically backed up system like OneDrive                   |
|                            |                       |             |                                                                                                                  |
| **Total**                  | $89                   | $198        |                                                                                                                  |

Looks like we came in reasonably under budget!

## Elbow Grease & Other Suggestions

* **This assumes we build a small trigger to turn a VM on/off**: To implement this solution, we'll have to get our hands dirty with Azure Functions or Bot Framework, which should be essentially free to implement but will take a little time to figure out.
* **Find tiers of data importance**: Family photos aren't the same as e-mails that are already stored on another server. For the most important stuff, put it in OneDrive and on a backed up VM disk. Then you'll have a cloud sync, a separate location, and a backup of that separate location. If you add in Backblaze on the VM disk, that gives you an additional backup provider as well.

## How'd I Do? What Did I Miss?

This was a fun exercise. But dear readers, how does this solution shape up? Anything you would have planned/done differently? I'd love to hear about it in the comments!
