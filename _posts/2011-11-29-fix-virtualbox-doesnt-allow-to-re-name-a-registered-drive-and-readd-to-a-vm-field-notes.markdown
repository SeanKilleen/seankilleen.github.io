---
layout: post
title: 'Fix: VirtualBox doesn''t allow to re-name a registered drive and readd to
  a VM [Field Notes]'
date: 2011-11-29 23:23:00.000000000 -05:00
comments: true

---
###Problem
In VirtualBox, if you take the following steps:

* Have HDD1.vdi and HDD2.vdi as storage
* Remove HDD1.vdi (and delete it) 
* Rename HDD2.vdi to HDD1.vdi
* Attempt to add the (new) HDD1.vdi to the VM

You will receive an error along the lines of:

> Failed to open the hard disk `[Path to your VDI file]`. Cannot register the hard disk `[Path to your VDI file]` {`[UUID of your new VDI file]`} because a hard disk `[Path to your VDI file]` with UUID {`[UUID of your old VDI file`} already exists.

###Solution
* In VirtualBox, select `File > Virtual Media Manager`.
* Click the hard disk in question.
* Click `Release` and then `Remove` to remove from the media library.

You will now be able to add your renamed VDI file.
