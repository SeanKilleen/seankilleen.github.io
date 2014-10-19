---
layout: post
title: 'How To: Change a Drive Letter With PowerShell [Field Notes]'
date: 2012-10-18 18:00:00.000000000 -04:00
comments: true
redirect_from: 
 - /2012/10/how-to-change-drive-letter-with.html
---
###Problem
I need to change the letter of a mounted drive via PowerShell.

###Solution
Start Powershell as an admin and run the following two lines, where 'x' is the current drive letter and y is the drive letter you'd like it to be:


{% highlight powershell %}
$drive = Get-WmiObject -Class win32_volume -Filter "DriveLetter = 'x:'"
Set-WmiInstance -input $drive -Arguments @{DriveLetter="Y:";}
{% endhighlight %}

###References
* <a href="http://blogs.technet.com/b/heyscriptingguy/archive/2011/03/14/change-drive-letters-and-labels-via-a-simple-powershell-command.aspx">Change Drive Letters and Labels via a Simple PowerShell Comamnd</a> [<a href="http://blogs.technet.com/">TechNet Blogs</a>]
