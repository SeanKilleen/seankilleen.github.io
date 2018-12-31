---
layout: post
title: 'Crystal Reports 2008 Gotcha: Subreports with multiple parameter values [Field
  Notes]'
date: 2011-12-15 09:38:00.000000000 -05:00
comments: true
redirect_from: 
 - /2011/12/crystal-reports-2008-gotcha-subreports.html
references:
 - title: "Crystal Reports 2008 - Trouble resetting a shared variable"
   url: http://stackoverflow.com/questions/8514709/crystal-reports-2008-trouble-resetting-a-shared-variable
   parenttitle: StackOverflow
   parenturl: http://stackoverflow.com
---
### The Setup
* I have a report in Crystal Reports 2008.
* The report uses a few different sub-reports.
* The report links the subreports to the main report by passing the main report parameter to the subreport parameter.

### The Problem
* When calculating totals, it works correctly if I pass in a single parameter value to the main report.
* However, if I pass in multiple values for a parameter to the main report (think multiple work order numbers for a WONUM parameter), the subreport calculates totals for all the fields

### The Solution
At first, it seemed like the issue was due to me not resetting the subreport total calculations on each page. But, I knew that I was doing this, and doing it correctly according to multiple reference points.

However, the issue (and thus, the solution) was simpler.

Because I was passing the main report parameter to the sub-report, Crystal was passing all parameters that I passed into the main report into the subreport, so the subreport was being told to calculate across all those values each time.

Instead, I changed the link to the subreport parameter. Instead of passing it the main report's parameter, I passed it the main report field that contained the work order number, thus assuring that it would only receive that one work order as a parameter.

See [the StackOverflow discussion][SO Link] for more references and comments.


[SO Link]: http://stackoverflow.com/questions/8514709/crystal-reports-2008-trouble-resetting-a-shared-variable