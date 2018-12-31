---
title: "New Year, New Look!"

date: 2018-12-31 17:00:00:00.000000000 -05:00
excerpt: "A fresh update to the blog for the new year."

comments: true
---

This blog, as it turns out, has been around for a little bit. :sweat_smile: The UI was feeling its age, and I thought: what better time to update things than the new year? And so, here we are.

I updated the [Minimal Mistakes](https://github.com/mmistakes/minimal-mistakes) theme that I use to the latest version, and threw out a lot of custom stuff so that I could start over as need be.

The old site has been preserved via [the Wayback Machine](https://web.archive.org/web/20180822005203/https://seankilleen.com/) -- what a great org / tool.

## What's Changed?

* Posts now show reading time, which I think is a nice touch.
* The "all posts" page is now nicely organized by year.
* The gross fonts & spacing have resolved themselves by just going with the defaults. I think it's much more readable now.
* Search functionality! The new theme allows me to use [lunr](https://lunrjs.com/), which is really helpful for putting links together during static site generation.
* The "references" section is gone from posts (for now). This was leftover from my old love of bibliographies, but the links are already in the post and I didn't get the sense that this would be missed at all.
* I got rid of a **ton** of extra includes, many of which I wasn't even using.
* The `atom.xml` and `rss.xml` (custom includes) are now gone in favor of the built-in Jekyll RSS generation of `feed.xml`. If you didn't see this page in your RSS, re-subscribe! :)
* I've added a [Credits page](/credits/) to thank those who've helped make the site a reality.
* I can use emojis now! :tada:

## Notes along the way

* It's amazing how out-of-date a site can get in 3-4 years.
* I no longer have the need to customize like I once did. This theme does almost everything I need to with minimal tweaking, so I think now that I've dug out from some of the cruft, I'll likely keep it clean.
* Remote themes for GitHub pages seem to be the way to go. It was really easy to switch things up without dealing with a mess of files. Deleting things rather than changing things felt good.
* To override files, I just needed to include my own local copy, which I could copy from the source repo.
* I had layouts specified in every post, which tripped me up. Jekyll's default layouts were definitely the way to go.
* GitHub metadata via Jekyll on GitHub pages is super sweet to experiment with! Loved that it makes things like the credits page and the edit links much easier.

## I'd love your feedback!

See something that needs fixing? Have a request? [Submit an issue](https://github.com/seankilleen/seankilleen.github.io/issues/new).

Or even better, submit a PR and get your place on the [Credits page](/credits/)!