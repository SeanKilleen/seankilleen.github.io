---
 
title: 'Fix: Crystal 2008 Doesn''t Refresh After Adding Columns [Field Notes]'
date: 2011-11-09 11:50:00.000000000 -05:00
comments: true
references: 
 - title: "Adding New Fields To Stored Procedure And Updating It In Crystal Reports"
   url: http://it.toolbox.com/blogs/programming-life/adding-new-fields-to-stored-procedure-and-updating-it-in-crystal-reports-30072
   parenttitle: Toolbox.com
   parenturl: http://toolbox.com
---
### Problem

Crystal Reports 2008 Designer does not reflect changes made to views or stored procedures, even after refreshing the database and those views/procedures within Crystal.

### Solution

While a horrible user experience, there is a proper method to accomplish this.

Based on trips from [this helpful article]:

* From the `Database` menu, click `Verify Database`.
* If dealing with a stored procedure, you will be asked to enter parameters; enter correct ones.
* Crystal Reports will undergo a verification process, during which time it will find the extra fields and adjust the report accordingly.

No idea why this is separate from (and ambiguously named compared to) a right-click and "refresh", but it does the job.

[this helpful article]: http://it.toolbox.com/blogs/programming-life/adding-new-fields-to-stored-procedure-and-updating-it-in-crystal-reports-30072
