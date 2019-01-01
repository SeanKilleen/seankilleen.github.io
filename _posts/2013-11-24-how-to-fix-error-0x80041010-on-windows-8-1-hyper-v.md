---
 
title: 'How to: Fix error 0x80041010 on Windows 8.1 + Hyper-V'
date: 2013-11-24 17:47:00.000000000 -05:00
comments: true
redirect_from:
 - /2013/11/how-to-fix-error-0x80041010-on-windows.html
references: 
 - title: "Problem with CPU load and WMI errors when Hyper-V is Installed?"
   url: http://social.technet.microsoft.com/Forums/windows/en-US/4eca1f42-8630-48b4-85fa-e9569445d832/problem-with-cpu-load-and-wmi-errors-when-hyperv-is-installed
 - title: "Direct Link for Intel Network Adapter for Windows 8.1 v18.7"
   url:  https://downloadcenter.intel.com/confirm.aspx?httpDown=http://downloadmirror.intel.com/23071/eng/PROWinx64.exe&amp;lang=eng&amp;Dwnldid=23071&amp;DownloadType=Drivers&amp;OSFullname=Windows+8*
   parenttitle: Intel Download Center
   parenturl: https://downloadcenter.intel.com/Default.aspx?lang=eng

---
### Problem:

After upgrading to Windows 8.1 Pro recently, I opened my Event Log to show a ***TON*** of errors from WMI. Event showed as an error and had the following text:

> Event filter with query "SELECT * FROM __InstanceOperationEvent WITHIN 10 WHERE (TargetInstance ISA 'Msvm_ExternalEthernetPort') OR (TargetInstance ISA 'Msvm_VmLANEndpoint') OR (TargetInstance ISA 'Msvm_SyntheticEthernetPort') OR (TargetInstance ISA 'Msvm_ComputerSystem') OR (TargetInstance ISA 'Msvm_VLANEndpointSettingData')" could not be reactivated in namespace "//./root/virtualization" because of error 0x80041010. Events cannot be delivered through this filter until the problem is corrected.

### Solution
I did a little searching around and [found this link][Forum link] which suggested removing the network adapter and installing 8.1's default network adapter.

However, I decided to see if an update to the latest drivers would do the trick.

I have the P8Z68 V/Pro motherboard (which I love), which comes with an Intel 82579V card. I hopped over to the [Intel Download Center][DL Center] and found the Windows 8.1 Network Adapter Driver v18.7 ([direct link here][Adapter Link]).

Sure enough, installing the updated version of the adapter was enough -- no need to replace it with the generic Windows 8.1 adapter. The errors have stopped and I'm seeing a performance gain as well. 

If you were experiencing the same issue, I hope this helps! Feel free to let me know how you fared in the comments.

[Forum link]: http://social.technet.microsoft.com/Forums/windows/en-US/4eca1f42-8630-48b4-85fa-e9569445d832/problem-with-cpu-load-and-wmi-errors-when-hyperv-is-installed

[DL Center]: https://downloadcenter.intel.com/Default.aspx?lang=eng
[Adapter Link]: https://downloadcenter.intel.com/confirm.aspx?httpDown=http://downloadmirror.intel.com/23071/eng/PROWinx64.exe&amp;lang=eng&amp;Dwnldid=23071&amp;DownloadType=Drivers&amp;OSFullname=Windows+8*
