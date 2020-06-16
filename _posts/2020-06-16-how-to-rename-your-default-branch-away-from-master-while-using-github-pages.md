---
title: How to rename your default branch away from master while using GitHub pages
comments: true
tags:
  - github
date: 2020-06-16 16:21 -0400
---
There's been some discussion lately about the term `master` for a branch as insensitive and a term that can make others feel uncomfortable and rise to the level of a micro-aggression by default. 

My stance on this:

* It is a relatively easy and straight-forward change to make
* If it helps our codebases become even slightly more welcoming to under-represented groups, it is worth it.
* It is by no means the only thing we should be discussing or doing about racial injustice.
* Other initiatives being as important or more important is no reason to avoid making this change.

## Is it easy to do?

Yes, and a little bit no. 

Yes, in the sense that renaming branches and pushing them is easy. Less so in the sense that you have to account for the ecosystem around the branches (builds, deploys, other products, etc.) 

## So, let's jump in and do it! 

I did a stream to demonstrate this, and I'll post the steps below as well. 

The stream covers two repositories:

* My <https://SeanKilleen.com> site, which is a Jekyll-based blog that uses Netlify for previews, Netlify Admin as a CMS, and GitHub pages to publish the content.
* A public repository I've been working on that's a .NET core app packaged up into a container by Azure DevOps. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/WlLpZt5Is2Y" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Summary of Changes to my Jekyll / GitHub Pages site

* Add new branch (branch from `master`, name it `main`)
* Publish the branch
* In GitHub repository settings, change the default branch to `main` in the drop-down.
* Edit all pending PRs to change the base branch from `master` --> `main`.
* Attempt to change branch in GH Pages. Oops! In my case, I can't. My GitHub pages are served from `master` and this is currently un-modifyable. We'll have to get creative.
* Created [a GitHub Action to force-push all changes from the `main` branch into the `master` branch](https://github.com/SeanKilleen/seankilleen.github.io/blob/main/.github/workflows/push-main-to-master-for-github-pages.yml) so that GitHub Pages will publish them.
* Changed the configuration yaml for Netlify Admin to reference the `main` branch.
* Logged into Netlify and changed my site's build settings to use the `main` branch.
* Changed the edit link on the blog -- rather than using a built in helper link, modified it so that I could specify a default branch.
* Update old blog posta that referred to the old branch name. Found these by doing a search.
