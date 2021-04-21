---
 
title: 'Crystal Reports Error: "A subscript must be between 1 and the size of the
  array." [Field Notes]'
date: 2011-11-01 16:48:00.000000000 -04:00
comments: false
redirect_from: 
 - /2011/11/crystal-reports-error-subscript-must-be.html
---
### Problem:

A long-standing Crystal Report (being run out of SAP Business Objects XI v12) suddenly started generating an error along the lines of:

```output
Error in File [File Name]: Error in formula [Formula Name]: 'left(split({[Field Name]},"/")[2],3)'

A subscript must be between 1 and the size of the array.

Details: errorKind
```

(The bracketed values were specific to the report itself)

### Solution

In this case, the formula is looking for a `/` to split the string. On a hunch, I decided to query the database, and sure enough, some of the fields in the database had been modified and no long included a `/`, causing the formula to bomb out.

#### Two solutions here:

* If the `/` is a business requirement and is supposed to be there, modify the data.
* Otherwise, modify the formula to include branching logic that takes other steps if a `/` is not detected.
