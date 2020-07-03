---
 
title: 'Fix: Crystal Reports 2008: "Default printer is not available" and/or Un-expandable
  Collapsed Sections [Field Notes]'
date: 2012-01-09 17:36:00.000000000 -05:00
comments: true
redirect_from: 
 - /2012/01/fix-crystal-reports-2008-default.html
---
### Problem:

In Crystal Reports 2008, when opening up a report that came from elsewhere (usually another user's machine), I see:

> default printer is not available.

Oftentimes, this will be accompanied by a strange behavior that will cause reports (or sub-reports) to look completely collapsed, like the following image:

![Collapsed Crystal Reports]({{site.post-images}}//CrystalReports_CollapsedSectionProblem.png)

"Oh", you say to yourself, "I'll just expand those sections manually and carry on." Well *think again, renegade* -- Crystal Reports will have *none* of it. The sections appear frozen in place forever.

![Han Solo Ice Image]({{site.post-images}}//han-solo-frozen-in-carbonite_2.jpg)

Your report sections. It *is* as painful as it looks.

### Solution

Luckily, per usual, [StackOverflow was a big help here][SO Link].

This solution has two different parts -- you may only need one or the other, but I've found them both to be a pretty effective one-two punch in this situation.

#### Part 1: Change Your Printer Settings

* While in the report, click `File > Page Setup...`
* Check the box labeled `No Printer (optimize for screen display)`.
* Check the box labeled `Dissociate formatting page size and Printer Paper Size`.
* The box should look like below:

![Crystal Reports Printer Options]({{site.post-images}}//CR-Page-Settings.png)
That should do it.

#### Part 2: Change Display Options

In case you have some sub-reports, etc. that didn't quite get the message to *thaw out, bro*, it's likely because they were hidden before or hidden as a result of the printer situation being screwy.

Try the following:

* While in the report, click `File>  Options...`
* Click the `Layout` tab (usually visible by default in my experience)
* In the `Design View` section, check the "Show hidden sections" option. This will cause any unwieldy sections to fall in line and become visible.

[SO Link]: http://stackoverflow.com/questions/8714797/crystal-reports-2008-sections-are-collapsed-and-i-cant-expand
