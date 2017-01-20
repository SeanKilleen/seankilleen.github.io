---
title: "On Excella: Avoiding Primitive Obsession in Configuration -- My Approach"
layout: post
date: 2016-12-27 22:43:00.000000000 -05:00
excerpt: "A good blog post got my wheels turning."
references:
comments: true
---

I woke up this morning and saw [a great blog post by Arialdo Martini] that inspired me to blog a little bit (thanks, Arialdo!) 

In the post, he describes the problems of using primitive variables in your classes, and the pitfalls of using a service locator pattern to resolve those issues. It's a good read; I recommend checking it out. The conclusion he came to (and I'm greatly oversimplifying here) is that configuration settings work better as value objects, and shows some tricks for how to achieve this in a more painless way.

I definitely agree that a value object is better than a primitive when it makes sense. However, there are times when a collection of primitives does make the most sense. 

So, I thought I'd share some current thoughts on how I prefer to inject configuration into my classes.

[Read the rest of this post on Excella.com](http://linktotheblogpost.com)


[a great blog post by Arialdo Martini]: http://arialdomartini.github.io/primitive-obsession.html
