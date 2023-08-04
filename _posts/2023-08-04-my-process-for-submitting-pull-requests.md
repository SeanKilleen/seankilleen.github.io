---
title: My Process for Submitting Pull Requests
comments: true
tags:
  - tips
  - process
  - oss
  - pull-requests
  - prs
date: 2023-08-04 09:32 -0400
---
I've been asked a lot of times about my process for submitting pull requests, so I figured I'd write it up!

## First -- A Few Caveats

* **This is my style; your might vary, and that's fine!** I think there are a lot of ways to do this well, and there's no sense in being dogmatic about it.
* **I don't follow this 100% every time**. I don't think you have to do these things exactly in order to be successful.
* **I'm assuming you're familiar with pull requests and how they work.** If you're not yet familiar with that, I recommend searching around and finding some great articles on that first, or some of this article might be confusing.

## Why Use Pull Requests at All? 

I'm a big fan of working out loud. To me, pull requests represent a way of sharing your thoughts and code as early as possible. They also allow you to make notes on your thoughts as you go and make it easier for others to review. To be clear, I think that making things easier to review is great, but I think PRs are powerful even if there's no review process in place.

## It Starts With a Work Item

Typically, I like to start any pull request by creating an issue or work item in the system I'm using to track those things. This helps ensure the work is visible. It also allows discussion on the value of that particular work, and space to think about its implementation. Showing up with a pull request skips those valuable steps and might lead to re-work. Lastly, having a work item means I might be able to split the work into multiple small pull requests, allowing me to move work through faster by doing it in smaller batches.

## When to Create a Pull Request

I like to create a pull request as soon as possible rather than waiting until my work is done. This is because it broadcasts what I'm doing to others, allows people to jump in with thoughts, and lets me leave notes as I think through things out loud.

## Creating the PR

* I check out the main branch
* I create a branch. To keep it simple, I typically use the format `[WorkItemNumber]_description-text`.