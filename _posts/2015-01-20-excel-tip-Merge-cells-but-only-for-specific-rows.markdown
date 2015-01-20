---
layout: post
title: 'Excel Tip: Merge Cells, but for One Row at a Time'
date: 2015-01-20 09:07:00.000000000 -05:00
excerpt: "I might be late to the game, but I had no idea you could merge only for certain rows."
comments: true
---
##Problem
When using Excel, sometimes I have multiple rows that I want to Merge and center, but only within that row. 

![The rows prior to the merge.]({{site.post-images}}/01_PriorToMerge.png)

However, if I select them all and select `Merge and Center`, I see the following error:

!["Merging cells only keeps the upper-left cell value, and discards the other values."]({{site.post-images}}/02_ExcelMergeError.png)

This is because Excel things I'm trying to merge all of those cells as one blob, rather than two rows, each with their own centered/merged text.

##Solution

In Excel 2013 [^1], you can select the drop-down next to `Merge and Center` and Choose `Merge Across`, which will perform this function per row.

![Merging across lets you do a merge and center, but for multiple rows.]({{site.post-images}}/03_MergeAcross.png)

And now, you see two rows of text, each merged & centered separately.

![The finished product.]({{site.post-images}}/04_RowsMerged.png)


[^1]: (and possibly earlier versions, I haven't tested)