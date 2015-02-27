---
title: "Learning to Love RegEx: a Find and Replace example"
layout: post
date: 2015-02-27 10:45:00.000000000 -05:00
excerpt: "A text editor and a little regex know-how can save a lot of time."
comments: true
---
# Problem
Someone in my blog publishing pipeline -- Github, Jekyll, etc. -- Changed how headings are formatted. Instead of `#Heading`, I had to specify `# Heading`. This makes sense, I just had converted this blog from elsewhere and it wasn't high on my priorities at first. But all of a sudden things broke, so I had to change a lot of headings quickly.

# Solution
I needed to find any instances of `##[Any Character]` and add a space in-between, across all of my blog files.

This kind of thing always sets off a light bulb in my brain for regular expressions. I'll be honest, I'm not a RegEx wiz in any sense of the word, but with some Googling I was able to figure it out.

## Creating the RegEx
The requirements are to find two pound signs `##` Followed by any letter (uppercase or lowercase).

The RegEx for this is `##[A-Za-z]`

## Adding the Capture Group

In order for Notepad++ to be able to replace the RegEx (rather than just find it), we have to create a capture group to capture that first letter (so that `A` becomes `A ` with a space)

To do this, we wrap the first character portion in parentheses, giving us `##([A-Za-z])`. This will create a capture group note that Notepad++ can refer to using `\1`.

## Replacing the text

* In Notepad++, we open the Find & Replace window. 
* We Search for `##[A-Za-z]`
* We replace it with `## \1` (the original heading, plus a space, plus the first character)
* We make sure that the search mode is RegEx
* We perform the find and replace across all files.

This took care of a huge amount of changes for me and probably saved an hour or two of my life. Really makes one appreciate the value of RegEx.

Hope this is helpful!