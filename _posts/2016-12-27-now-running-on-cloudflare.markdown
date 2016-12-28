---
title: "Now Running On CloudFlare! Here's How I did it."
layout: post
date: 2016-12-27 20:30:00.000000000 -05:00
excerpt: "Good advice leads to a great result"
references:
 - title: "CloudFlare"
   url: https://www.cloudflare.com/
 - title: "Github Pages"
   url: https://pages.github.com/
 
comments: true
---
As of a few hours ago, this site runs on `https` by default and likely pretty darn fast. That's all thanks to [CloudFlare](https://www.cloudflare.com/), and to [my] [brother] [ryan], who showed me how easy it was to get up and running with CloudFlare on an upcoming project of ours.

## What I'm Getting Out of this
This site is already run on [Github Pages](https://pages.github.com/) using Jekyll, so I get a pretty fast site generated automatically and served via Github pages, which runs on Github's own infrastructure. That's already bullet-proof. 

So, why introduce this extra component?

* **Full SSL support**. 
* **Caching**. Github Pages is already pretty well cached, but Cloudflare is known for their caching capability and built-in CDN. 
* **It's free for me**. Which is very helpful from "why not?" perspective.

[my]: http://RyanKilleen.com
[brother]: http://Github.com/RyKilleen
[ryan]: http://twitter.com/deathbypapercut