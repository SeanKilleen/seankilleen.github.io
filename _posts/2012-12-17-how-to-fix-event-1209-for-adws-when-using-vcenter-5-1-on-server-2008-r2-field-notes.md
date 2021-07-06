---
 
title: 'How to: Fix Event 1209 for ADWS when using vCenter 5.1 on Server 2008 R2 [Field
  Notes]'
date: 2012-12-17 17:00:00.000000000 -05:00

redirect_from: 
 - /2012/12/how-to-fix-event-1209-for-adws-when.html
 - /2012/12/how-to-fix-event-1209-for-adws-when.htm
 
references: 
 - title: "Active Directory Web Services encountered an error while reading the settings for the specified Active Directory Lightweight Directory Services instance. Active Directory Web Services will retry this operation periodically. In the mean time, this instance will be ignored."
   url: http://thesaffageek.co.uk/2010/07/05/active-directory-web-services-encountered-an-error-while-reading-the-settings-for-the-specified-active-directory-lightweight-directory-services-instance-active-directory-web-services-will-retry-this/
   parenttitle: TheSaffaGeek
   parenturl: http://thesaffageek.co.uk/
---
### Problem

I'm Running vCenter 5.1 and Windows Server 2008 R2. I notice a number of events in the event log with a source of "ADWS", event ID of 1209. The event text reads:

> Active Directory Web Services encountered an error while reading the settings for the specified Active Directory Lightweight Directory Services instance.  Active Directory Web Services will retry this operation periodically. In the mean time, this instance will be ignored. Instance name: ADAM_VMwareVCMSDS

### Cause

Apparently, VMWare doesn't create a proper registry value for one entry, which causes ADWS to throw an error

### Solution

To fix this:

* Back up your registry.
* Open `regedit.exe`
* Navigate to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\ADAM_VMwareVCMSDS\Parameters`
* Note that the `Port SSL` field is a `REG_SZ` Rather than a `REG_DWORD` and is empty
* Delete the `Port SSL` field.
* Create a new field called `Port SSL` of type `REG_DWORD`
* Double-click on that field and change the value to `636`.

At this point, the errors should stop and your EventLog is now free from 1440 events a day.
