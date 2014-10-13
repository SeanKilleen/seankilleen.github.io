---
layout: post
title: 'Quick Tip: File Hashes with PowerShell Community Extensions'
date: 2014-02-12 18:00:00.000000000 -05:00
comments: true

---
###Problem
I need to calculate the MD5 and SHA hashes for a file from Windows and I'd rather not download 3rd-party GUI software that clutters my setup.

###Solution
I like the [PowerShell Community Extensions](http://pscx.codeplex.com/) for this.

1. Download [Chocolatey Nuget](http://chocolatey.org/) (it will make your life outside of this post easier, I promise).
1. From the Powershell command prompt, type `cinst pscx`. This will install the PowerShellCommunity Extensions.
1. Use the PSCX syntax to get the hashes. Some examples below:

{% highlight powershell %}
Get-Hash C:\Path\To\File.zip -Algorithm MD5
Get-Hash C:\Path\To\File.zip -Algorithm SHA1
{% endhighlight %}
