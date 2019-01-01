---
 
title: 'Tip: Suppress #DIV/0 errors in Excel with a formula'
date: 2011-12-02 11:41:00.000000000 -05:00
comments: true

---
### Problem:
If you ever receive a `#DIV/0` error in Excel that you expect to be there (i.e. calculating percentages from other data which may not have accumulated yet), you can suppress  it by using an `IF` statement in the formula.

Let's say you have three columns -- `A`, `B`, and `C`. `C` calculates the percentage of `B` and `A` (i.e `B/A`), but if `A` is 0 or empty, you'll get the `DIV/0` error which throws off formulas, coloring, highlighting, etc.

### Solution
Instead of `= B1/A1`, do something along the lines of the following:

    =IF(A1=0, 0, B1/A1)
or:

    =IF(A1=0, "", B1/A1) 

This does a simple check first: If `A` is zero, it will substitute a default value. Otherwise, your calculation will go on as planned.

I've used this tip many a time to help with the presentation of an Excel sheet.
