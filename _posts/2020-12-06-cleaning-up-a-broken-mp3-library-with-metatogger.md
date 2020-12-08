---
title: How to Clean up a messed up MP3 library With Metatogger
comments: true
tags:
  - tools
  - music
  - mp3
  - organization
date: 2020-12-06 10:14 -0500
---
[Metatogger](http://www.luminescence-software.org/en/metatogger) is my favorite .NET app of the week after it helped me recover my Mother-in-Law's MP3 collection. I figured I'd talk a little bit about how I used it to fix things up.

## Background / Challenge

iTunes on Windows is hot garbage. Aside from being not so user friendly, when things get out of sync, it can be a big challenge. For normal users this is compounded by the fact that the iTunes catalog is a reference to files on disk; confusion about this can lead to files being incorrectly moved, duplicated, etc.

Through a series of unfortunate events (no fault of her own I'm 99% sure), my MIL's library was experiencing:

* Duplicate files both on disk and in the iTunes library
* Some missing files
* Some files only on her iPod somehow, that we were able to recover, but with cryptic 4-letter file names like "AJDF.mp3".
* Inconsistent metadata

Additionally, my Father-in-law had some MP3's he'd extracted from tape. These had file names he wanted, but no metadata.

Got it? Okay, let's do this.

## Gathering the files and adding them

So as not to mess anything up unintentionally, I created a staging area, and copied every MP3 there that I could find (including the cryptically-named files from the iPod). I also created a "Finished" folder where I would output the MP3s eventually once they were cleaned up.

## How Metatogger works

Metatogger allows you load files and to make a number of changes within its space. Then, once you save the collection, those files are persisted to disk and any of the metadata changes are actually applied.

## Correcting the metadata / tags

I sorted by album, since in most cases I would want to clean up one or two albums at a time. I made the following corrections:

* **Splitting the Track Numbers**: Many files had track numbers like `1/10`, `2/10`, etc. but I didn't want to keep the total number of tracks, partly because I'd be using this in the file names later. In the "Scripts" section, there was already a handy script to split the track numbers. I applied this to all tracks and saved.
* **Using two-digit track numbers**: Similarly, there was a script to convert all track numbers to use two digits. Consistency! I applied it to all tracks and saved.
* Artist names

* Metadata correction with CDDB / audio fingerprinting
* Updating filenames and locations based on metadata and using filtering to remove them as we go
* Importing some metadata based on file names and locations
* Cleaning up garbage tags