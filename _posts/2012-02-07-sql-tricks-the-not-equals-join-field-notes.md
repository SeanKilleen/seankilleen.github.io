---
layout: post
title: 'SQL Tricks: The Not-Equals Join [Field Notes]'
date: 2012-02-07 11:32:00.000000000 -05:00
comments: true

---
### The Problem
I needed to pull back a list of dates in a certain range for each employee, but didn't have a common join criteria, as I wanted all the dates but they did not come from a table.

### The Solution
I knew that the dates would never equal the employee name, so in this case, I could actually use a "not-equal" join to connect the two. I always forget about this one, but it's handy.

I did something along the following (edited for brevity):

```sql
select * from (...) ActiveLabor 
    left outer join (...)DateRange 
    on (activelabor.laborcode != to_char(DateRange.DateItem))
```

This allows the left outer join only if the items are not equal (which we happen to know will always be the case).

The end result? As I expected -- the full list of dates showed up for each employee, just as I'd hoped.

**A Note:** Because I was comparing a date to a string, I had to cast the date as a varchar2 in the join statement. The date value itself still comes back as a date, but during the comparison we need to make sure we're giving Oracle an apples-to-apples comparison.
