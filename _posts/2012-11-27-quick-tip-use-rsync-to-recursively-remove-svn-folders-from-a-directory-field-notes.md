---
 
title: 'Quick Tip: Use rsync to recursively remove .svn folders from a directory [Field
  Notes]'
date: 2012-11-27 17:00:00.000000000 -05:00


---
### Problem

I have a directory structure that contains Subversion metadata folders (folders named ".svn").

I would like to remove those folders but "svn export" won't work.

### Solution

Rsync to the rescue. Let's say the folder containing .svn folder structures is named `problemfolder`. Do the following:

* In the same directory as the problem folder, create a "clean" folder to output the contents of `problemfolder` to eventually.

```cmd
"mkdir problemfolder_clean"
```

* Run `rsync`, excluding .svn folders and their contents, to copy the problem directory to the clean directory.

```cmd
rsync -avr --exclude='.svn*' /path/to/problemfolder/ path/to/problemfolder_clean
```

At this point, the contents of `problemfolder` (minus the .svn folders) will be in the clean folder you created.
