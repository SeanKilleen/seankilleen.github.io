---
title: "Now Running On CloudFlare! Here's How I did it."
 
date: 2016-12-27 21:10:00.000000000 -05:00
references:
 - title: "CloudFlare"
   url: https://www.cloudflare.com/
 - title: "Github Pages"
   url: https://pages.github.com/
 - title: "RyanKilleen.com"
   url: http://RyanKilleen.com
 - title: "RyKilleen on Github"
   url: http://Github.com/RyKilleen
 - title: "DeathByPapercut on Twitter"
   url: http://twitter.com/deathbypapercut
  
comments: false
---
As of a few hours ago, this site runs on `https` by default and likely pretty darn fast. That's all thanks to [CloudFlare](https://www.cloudflare.com/), and to [my](http://RyanKilleen.com) [brother](http://Github.com/RyKilleen) [Ryan](http://twitter.com/deathbypapercut), who showed me how easy it was to get up and running with CloudFlare on an upcoming project of ours.

## What I'm Getting Out of This

This site is already run on [Github Pages](https://pages.github.com/) using Jekyll. So, I get a pretty fast site generated automatically and served via Github Pages, from my markdown content, which runs on GitHub's own infrastructure. That's already bullet-proof.

So, why introduce this extra component?

* **Full SSL support**. Anyone who's configured this for a web site before knows what a pain in the butt it can be. I'd held off on it because of hosting limitations.
* **Easy page re-writes and rules**. CloudFlare has a ton of built-in rules, such as quickly converting all `http` requests to `https`.
* **Converting mixed content to https**. After serving a site over `https`, often other content (links, CSS, JavaScript, images) is still served over `http`, which causes trouble. CloudFlare re-writes this content on the fly, which is hugely helpful during a conversion process.
* **The ability to insert "apps"**. I use Google Analytics, and also am thinking about NewRelic. Using CloudFlare, I can add them with one-click setup and CloudFlare will ensure those components are always present on my web site.
* **Caching**. Github Pages is already pretty well-cached, but Cloudflare is known for their caching capability and built-in CDN.
* **It's free for me**. Which is very helpful from a "why not?" perspective.

## The Steps to Make it Happen

These are surprisingly few & easy.

* **Sign up for a CloudFlare account**. This is quick and easy via the CloudFlare site.
* **Add My Site to CloudFlare**. CloudFlare automatically pulls in the DNS settings from my current site, so that when I cut over to their service there won't be any pain. Really nice experience.
* **Convert my Nameservers to CloudFlare's Nameservers**. I was using Namecheap's default nameservers, so I used their docs to do this.
* **Wait until CloudFlare said it was active.** This didn't take long -- a few minutes, definitely under 30.
* **Change the Security Setting to "Full".** This is easily done from CloudFlare's control panel, and automatically generated a certificate (that will auto-renew).
* **Wait for the Cert to become active**. This took around 15 minutes.
* **Test that my site could be reached over `https`**. It worked, but some of the mixed content didn't display correctly (as expected).
* **Turned on the setting to redirect mixed content**. This makes sure that all the CSS, JS, etc. renders correctly without security warnings.
* **Test the site by manually going to the `https` version**. This ensured there wouldn't be any issues once I enforce it.
* **Create a page rule to enforce `https`**. This was as easy as adding a rule for `http://*SeanKilleen.com*` and setting the rule to always force https.

And then....actually, that's it. After these few small steps, I was completely done and running via CloudFlare and my site was being served by https by default. It took longer to write this post than it did to make the conversion.

## A New Era

I have to say, following these steps, I was amazed at how easy CloudFlare has made it to commit to their platform and all of its benefits. I'm familiar with the pain that can be involved in a transition like this, and to feel none of that throughout the process was surprising and delightful.

Very excited about platforms like CloudFlare that are paving the way to a better web.

## Issues? Comments?

Does any piece of this site give you a hiccup when loading via https? Do you have any thoughts about CloudFlare on a site such as this? Are you my brother chiming in to tell me how right he was? Sound off in the comments!
