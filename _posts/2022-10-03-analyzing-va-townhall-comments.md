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
* JQ
* VS Code
* Docker
* SQL Server (the Linux version, running in Docker)

## Step 1: Load the pages

* Load [the comments page](https://townhall.virginia.gov/L/ViewComments.cfm?GdocForumID=1953)
* Set the page size to `1000` comments per page and hit `Go` to bring back the first page.

## Step 2: Load Artoo

[Artoo.js](https://medialab.github.io/artoo/) is a delightful little client-side scraper. You load it into your browser via bookmarklet and it lets you to all sorts of stuff

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
