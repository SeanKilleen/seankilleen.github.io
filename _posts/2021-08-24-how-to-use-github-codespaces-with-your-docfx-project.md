---
title: How to use GitHub Codespaces with your docfx project
comments: true
tags:
  - docfx
  - github
  - codespaces
  - ""
date: 2021-08-23 20:37 -0400
---
A little over a year ago, we [re-launched the NUnit docs site](https://seankilleen.com/2020/07/announcement-i-am-now-the-lead-for-the-nunit-docs-project/) using the [docfx project](https://dotnet.github.io/docfx/). Since then, we've built out the workflow a bit -- adding spell-checking, markdown linting, etc. to allow us to consistently create better content.

But I wanted to take it to the next level. I wanted anyone to be able to spin up the docs in GitHub codespaces and have a fully working environment that did what needed to be done. 

So, dear reader, that's what we did. Below is how we made it happen.

## First Up: A Container

