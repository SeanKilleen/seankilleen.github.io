---
 
title: 'Bad UX Experience: MD MVA (2 for 1 deal!)'
date: 2012-12-14 10:13:00.000000000 -05:00


---
I know this comes as a shock to nobody, but MD's don't-call-it-the-DMV "Motor Vehicle Association" isn't the easiest to get around.

However, this one was a little puzzling.

### Bad UX Example

While attempting to fill out a change of address form on the web site, the new address is given only one line (no "street 2") address. And to make matters worse, the **address is limited to only 30 characters.** So, if you have a long street name and/or live in an apartment, this field will be a joy for you to fill out.

Even better: Since I had to get creative with the symbols in the name, I shortened the "BLVD" in my new street address to "BVD" (only way I could still fit the apartment in). It then tried to get me to accept the USPS standardized version, which either cut the apartment number's 3rd digit off, or cut out the "BLVD" portion entirely.

Eventually, I had to force it to use the original, so now it will read "BVD", and I'm sure it's only a matter of time before I'll have to get that corrected.

### Additional Bad UX Example

While writing this blog post, I attempted to link to the change of address form, so I right-clicked on the link titled "change of address form" and chose to copy the URL. When I pasted it just now, I got:

    javascript:__doPostBack('ctl00$btnChangeOfAddress','')

Really? We're still doing post-backs on buttons this way? I guess the best way to avoid link rot is to make sure your link is never a link in the first place.

### What can we as Developers Learn From This?

There are already great posts on falsehoods programmers believe about [names], [time], [networks], [geography], [build systems] -- It seems like one on addresses is long overdue. In the spirit of those posts, I'll begin one below based on my experience.

#### In the context of addresses, all of the following are wrong:

* The street address will be less than 30 characters
* The location will have a house number
* The city will be less than 30 characters
* The USPS address standardization will always be correct

[names]: http://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/

[time]: http://infiniteundo.com/post/25326999628/falsehoods-programmers-believe-about-time

[networks]: http://erratasec.blogspot.com/2012/06/falsehoods-programmers-believe-about.html

[geography]: http://wiesmann.codiferes.net/wordpress/?p=15187&amp;lang=en

[build systems]: http://pozorvlak.livejournal.com/174763.html
