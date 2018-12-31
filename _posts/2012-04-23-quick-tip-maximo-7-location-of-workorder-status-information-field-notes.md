---
 
title: 'Quick Tip: Maximo 7 -- Location of Workorder Status Information [Field Notes]'
date: 2012-04-23 11:53:00.000000000 -04:00
comments: true

---
A quick note for myself an anyone else who might be interested:

Maximo 7 has a few internal status codes, but custom statuses can easily be created. However, these have to map to one of the internal status codes.

I wanted to give our customers an overview of the internal status codes and their mappings. After some searching, I found the following method successful:

* Login to Maximo 7
* Click `Go To > System Configuration > Platform Configuration > Domains`
* Search for the `WOSTATUS` domain and expand it.

Here, you'll have a list of all statuses with internal and external values.

Hope this helps!
