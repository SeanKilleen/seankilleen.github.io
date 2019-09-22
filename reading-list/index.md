---
layout: single
author_profile: true 
title: My (Automated) Reading List
modified: 2019-01-14T09:25:00.000000-05:00
comments: true
---

I'm a big fan of blogs, of RSS readers, and of sharing, so I figured -- why not share my blog feed in a continuously updated way?

## Getting the File

[You can download the blog feed here](https://seanfeedlyopmlexport.blob.core.windows.net/opml-file/SeanKilleenBlogs.opml).

## What's in the file?

It contains a list of development and tech blogs that I follow -- I figured you didn't need to see my politics. :wink:

The categories specifically include my name so that they won't get intermingled with the rest of your feeds.

## So...What do I do with it?

The blog feed is in OPML (Outline Processor Markup Language) format, a standard format for these kinds of RSS feed exports.

Several blog readers -- such as [Feedly](https://blog.feedly.com/opml/) -- allow you to import OPML lists right into their contents.

Best of all, in most feed readers, the import process is idempotent -- meaning you should be able to keep importing this list in most feed readers without seeing duplicate entries for a given source.

## How Often is it Updated?

At least daily. If I add any feeds, you'll see them in the list. The whole thing is automated.

## Cool! How Did You Do This?

A mix of The Feedly API and Azure Functions, Azure Key Vault, and Azure Storage Blobs.

[Check out a tutorial to see how I did this step-by-step!]({% post_url 2019-01-14-tutorial-reading-list-feedly-azure-functions %})
