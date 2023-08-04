---
title: My Process for Submitting Pull Requests
comments: true
tags:
  - tips
  - process
  - oss
  - pull-requests
  - prs
date: 2023-08-07 09:00 -0400
---
I've been asked a lot of times about my process for submitting pull requests, so I figured I'd write it up!

## First -- A Few Caveats

* **This is my style; your might vary, and that's fine!** I think there are a lot of ways to do this well, and there's no sense in being dogmatic about it.
* **I don't follow this 100% every time**. I don't think you have to do these things exactly in order to be successful. It's better to adapt to your situation/context.
* **I'm assuming you're familiar with pull requests and how they work.** If you're not yet familiar with that, I recommend searching around and finding some great articles on that first, or some of this article might be confusing.

## Why Use Pull Requests at All?

I'm a big fan of working out loud. To me, pull requests represent a way of sharing your thoughts and code as early as possible. They also allow you to make notes on your thoughts as you go and make it easier for others to review. To be clear, I think that making things easier to review is great, but I think PRs are powerful even if there's no review process in place.

## It Starts With a Work Item

Typically, I like to start any pull request by creating an issue or work item in the system I'm using to track those things. This helps ensure the work is visible. It also allows discussion on the value of that particular work, and space to think about its implementation. Showing up with a pull request skips those valuable steps and might lead to re-work. Lastly, having a work item means I might be able to split the work into multiple small pull requests, allowing me to move work through faster by doing it in smaller batches.

## When to Create a Pull Request

I like to create a pull request as soon as possible rather than waiting until my work is done. This is because it broadcasts what I'm doing to others, allows people to jump in with thoughts, and lets me leave notes as I think through things out loud.

## Creating the PR

* I check out the main branch
* I create a branch. To keep it simple, I typically use the format `[WorkItemNumber]_description-text`, such as `123_add-spellcheck`. Different teams have different standards for branch names; I adapt as necessary.
* I make a single commit -- or sometimes even an empty commit with `git commit -m "my message" --allow-empty`.
* I create a pull request based on that branch so that it's available for others ASAP.
* I usually put `WIP` in the pull request title. This stands for "work in progress" and helps communicate that it's not ready for review/merge.
* I ensure the pull request is linked to a work item. In GitHub, means writing `Resolves #123` (if this PR will close that issue when it's merged) or `Supports #123` in the body of the pull request. In systems like BitBucket, it might mean putting the Jira work item number in the title of the pull request.

## Doing Work in the Pull Request

I make many small commits to the PR as I go. Making small commits lets me backtrack more easily if I need to, and shows my thought process as I add comments to the commits. I'm not worried about how many commits I make; I take care of that at the end (more on that later).

I treat my pull request like a diary - which is to say, I try to "think out loud". If I'm stumped, or if I consult a resource or article, or if I'm debating different directions, I might add that information in a comment. This provides historical context for anyone who might need it in the future.

## Checklists are My Friend

I often create checklists in the descriptions of my pull requests. This way I can jot things down quickly as I go and make sure that I finish everything that's needed before merging (or move it into a new work item). This lets me get it out of my head which helps me stay focused.

## Self Review

Regardless of whether anyone else will review the PR, when I think it's ready to submit or get feedback on, I try to do a "self review".

I'll put on my reviewer hat and review the PR as if I'd created it. This usually turns up some small tweaks I want to make, and also allows me to add more information, such as drawing attention to riskier areas of my work that need in-depth review, or explaining my thinking around the choices I made.

Again, the goal is communication. This provides more historical context and makes review conversations faster if reviews are being performed.

After I've done this, I typically remove the `WIP` from my pull request title, indicating it's ready for review/merge.

## What to Do With all of Those Small Commits?

I squash them!

Many small commits are helpful for review, but when the pull request is merged, I really only care about the sum of that work. Squashing is a merge strategy that turns all of those small commits into one commit. I use that strategy to keep my main branch's history from becoming cluttered, and so the code from each PR is more easily traceable.

## What's Your Process?

I'd love to hear about your process and where it differs from mine. Feel free to start a discussion in the comments.

Happy coding!
