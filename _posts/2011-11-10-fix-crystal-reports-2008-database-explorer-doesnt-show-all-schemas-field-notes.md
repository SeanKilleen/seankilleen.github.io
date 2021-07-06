---
 
title: 'Fix: Crystal Reports 2008 Database Explorer Doesn''t Show All Schemas [Field
  Notes]'
date: 2011-11-10 21:17:00.000000000 -05:00


references:
 - title: SQL Developer
   url: http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/index.html
 - title: DBVisualizer
   url: http://www.dbvis.com/

---
### Problem:

In Crystal Reports 2008, I am attempting to add a ODBC datasource (connecting to an Oracle 11g database) so that I can change field links, etc.

However, when I go into the Database Explorer and create an ODBC connection, certain system and user schemas show up, but mine is not in the list, despite the fact that I can view and query that schema/user in many other Oracle clients such as [SQL Developer] or [DBVisualizer].

### Solution

This seems to be a strange bug. According to this helpful (but obscure) forum post (_Ed. Note_: unfortunately, the link has been lost to time), the way to resolve the issue is to:

* On the menu bar, select `File > Options`
* Click the `Database` tab.
* Uncheck the `Stored Procedures` option.

I have no idea why this fixes the issue, but it certainly did. Very happy to have this one behind me.

[SQL Developer]: http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/index.html
[DBVisualizer]: http://www.dbvis.com/
