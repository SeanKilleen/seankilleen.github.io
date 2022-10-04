---
title: "How I Extracted VA Townhall Comments to further analyze them"
comments: true
tags:
  - artoo
  - javascript
  - docker
  - sqlserver
  - sql
  - vscode
date: 2022-10-03 11:33 -0400
excerpt: "Analyzing Reaction to Glenn Youngkin's Proposed policy changes around transgender students."
# header:
#  overlay_image: /images/overlays/unsplash/isaac-smith-AT77Q0Njnt0-unsplash.jpg
#  overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
#  caption: "Photo credit: [**Isaac Smith @ Unsplash**](https://unsplash.com/@isaacmsmith?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
---

Virginia's Governor Glenn Youngkin has recently made news by announcing a rollback to policies that previously sought to affirm the identity of transgender youth. I've placed my take on the policy at the end of this article, but that's not what I want the article to be about.

One of the thing that's been eating at me as public comments poured in is that I want the ability to analyze things better, and the VA Townhall site appears to be an old cold-fusion app with only basic CRUD abilities. Is there a way I could get it into a format where I could query the data?

So I decided to do that, and I'm going to list the steps I took here in case you'd like to do the same.

## First: Some Disclaimers

* I didn't see anything anywhere saying I couldn't do this, and the site itself appears to be public. If I've run afoul of any regulations, I'll remove this post, but as far as I can tell I'm in the clear.
* This post is quick &amp; dirty. I'm trying to get the information out there. If something seems hasty, that's because it is. Feel free to add questions & observations in the comments.
* I fiddled with this stuff a bunch over the course of an evening. Don't want anyone to get the impression that I just turn this sort of thing out stream-of-consciousness. :smile:

## The Ingredients today

I used the following to help me out today:

* Artoo.js
* jq
* VS Code
* Docker
* SQL Server (the Linux version, running in Docker)

## Step 1: Load the pages

* Load [the comments page](https://townhall.virginia.gov/L/ViewComments.cfm?GdocForumID=1953)
* Set the page size to `1000` comments per page and hit `Go` to bring back the first page.

## Step 2: Load Artoo and Figure out how to scrape a page

[Artoo.js](https://medialab.github.io/artoo/) is a delightful little client-side scraper. You load it into your browser via bookmarklet and it lets you do all sorts of fun stuff.

In this case, I fiddled around to understand how to extract things. The Townhall site leaves a little to be desired in terms of element naming etc, so some of it's a bit funky.

This script was a one-liner in my browser console window, but I've expanded it here to help make sense of it and explain things.

```javascript
// Comment box has a class of Cbox
var pageNum = artoo.$('#vpage').val();

artoo.saveJson(artoo.scrape('.Cbox', {
    date: function($, el) {
        // normally it's not this hard but their site isn't awesome and I had to do some cleanup
        return $(el).children('div > div').text().split('\n')[1].trim()
    },
    commenter: function($, el) {
        // you get a reference to jQuery and the element so you can do all the things you need
        return $(el).children('div:nth-of-type(2)').text().split('\n')[2].trim()
    },
    subject: function($, el) {
        return $(el).children('div:nth-of-type(2)').text().split('\n')[4].trim()
    },
    comment: function($, el) {
        return $(el).children('div.divComment').text().trim()
    },
    commentId: {
        // or you can simplify it if you don't need a whole big function
        sel: 'a.linklight',
        method: 'text'
    }
}), {
    // easily save out to files -- does JSON, CSV, Text, HTML, etc.
    filename: 'page' + pageNum + '.json',
    pretty: true
})
```

## Step 3: Repeat Step 1 above...for every page.

There are currently 55,000+ comments on this policy.

That meant that for each one of the 56 pages, I had to:

* Click `Next` (this causes a refresh. Thanks, Townhall!)
* Click the bookmarklet to load Artoo
* Hit the up arrow in my browser console to run the scrape again

It wasn't fun, and I'm sure I could have automated it, but I did it manually while I thought about automating it and got through it pretty quickly.

But I was definitely thinking "Hmm, I'll only want to do this for new comments in the future without creating duplicates", so I built that into later steps.

## Step 4: Combine those JSON files

I love `jq` as a tool for processing JSON files.

## My Personal Feelings on the Policy

I wanted to make this blog post more about enabling anyone to analyze the comments, but my personal opinion is that I 100% stand with the transgender community.

[My comment can be found here officially](https://townhall.virginia.gov/L/viewcomments.cfm?commentid=179497), but I'm re-posting it here as a matter of record as well.

> This policy's callousness is matched only by its cowardice.
>
> It seeks to roll back existing protections and affirming policies -- ones that support children -- at a time when mental health and well-being is most crucial for students. It denies a student the name of their choice, and the pronouns of their choice. Who benefits from this? Who is made safer? Which students are more supported and accepted and cared for as a result? NONE. Furthermore, this policy cowardly approaches the changes under the guise of empowering parents, which adds additional insult to its transparent bigotry. This parent would like to make it clear that I expect Virginia schools to honor their students -- which means honoring their choices around their identity.
>
> As a white, cisgender man, I don't check many "diversity" boxes. Which is why I want it to be clear and on the record that I wholeheartedly renounce this policy. I know and have known several trans people so far in my life, and one common theme in all of their threads is an incredible and painful struggle to come to the realization, despite societal and institutional pressure, that their identity is not what had been assigned at birth. I have known their joy as they have finally discovered and began living as their true selves. And I have seen the toll it has exacted on them and their families. Their story is one of bravery and resilience and an often painful journey of self-actualization.
>
> I stand with trans people, and I want trans and queer youth reading this to know that you are not alone. You deserve to be yourself as you define, and no matter how this administration might try to couch it in other language, we see right through it, too. "These are good days for bad people", but your living your full lives well -- as your true selves, on your own terms -- will be the best revenge on these backwards policies and those who seek to implement them. Glenn Youngkin and his administration may fail you, but you may yet still thrive. May this policy and his administration be consigned to the rubbish bin of history where they belong.  And may you shine on.
