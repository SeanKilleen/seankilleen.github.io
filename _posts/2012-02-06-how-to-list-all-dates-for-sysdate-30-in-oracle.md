---
layout: post
title: 'How To: List all Dates for sysdate +/- 30 in Oracle'
date: 2012-02-06 16:33:00.000000000 -05:00
comments: true

---
Discovered an answer to [a StackOverflow question I'd posted][SO Link], and wanted to share.

### The Problem
I needed to, within a view, dynamically generate a list of dates before or after sysdate. I wanted to do this so that I could limit some of the records coming back (we have millions but the date range will always be between 31 days before sysdate or 31 says after.

### The Solution
In Oracle, the SQL to do this is as follows:

```sql
SELECT *
FROM   (SELECT TRUNC(SYSDATE - ROWNUM) DateItem
        FROM   DUAL
        CONNECT BY ROWNUM < 32
        UNION
        SELECT TRUNC(SYSDATE + ROWNUM) DateItem
        FROM   DUAL
        CONNECT BY ROWNUM < 32)DATERANGE; 
```

This SQL does the following:

* Uses the dual table (a special table in Oracle as I understand) to scroll through x amount of rows (in this case, 32, because we want to make sure it includes 31 days)
* For each of those, it returns the `sysdate - [the number of rows]`, or `sysdate + [the number of rows]` in the case of the second query. It calls this column `DT`.
* It unions those two queries together, to give the full range of values. This also has the nice effect of removing duplicate dates from the results.
* I then wrap it in a `select *` statement so I can call it what I want and refer to it later.

Learning Oracle as I go, and I'm enjoying discovering these little tricks.

[SO Link]: http://stackoverflow.com/q/9166877/316847