---
title: My Process for Reviewing Pull Requests
comments: true
tags:
  - process
  - pull-requests
  - prs
  - review
  - github
date: 2023-08-10 09:00 -0400
---
I often do a lot of code reviews and pull request reviews. As a follow-up to [my article on submitting pull requests]({% post_url 2023-08-07-my-process-for-submitting-pull-requests %}), I wanted to talk about how I review them as well.

## First -- A Few Caveats

* **This is my style; yours might vary, and that's fine!** I think there are a lot of ways to do this well, and there's no sense in being dogmatic about it.
* **I don't follow this 100% every time**. I don't think you have to do these things exactly in order to be successful. It's better to adapt to your situation/context.
* **I'm assuming you're familiar with pull requests and how they work.** If you're not yet familiar with that, I recommend searching around and finding some great articles on that first, or some of this article might be confusing.
* **This advice is geared less toward public OSS projects.** In those cases, there are additional requirements for review IMO, because the OSS authors will have to maintain that code in perpetuity after the change is merged, and the original author may or may not available. This article assumes we're talking about a team project.

## Before Beginning -- the Right Mindset

I try to always keep a few things in mind prior to reviewing code:

* **Reviewers should be rooting for those they're reviewing**. I should want the person whose code I'm reviewing to succeed.
* **Code always has a context, and no code/author is perfect.** This perspective is important, I think. Too often, we review pull requests outside of the context in which they're offered.

I find reminding myself of these things put me in the right mindset to add constructive, helpful comments.

## Tips I Use While Reviewing

* **Look for things I like, too**. PR reviews aren't only about critical comments.
* **Use Agreed-upon or common emojis**. More on this below, but I find that including an emoji at the start of a code review item helps provide quick context and understanding to the author.
* **Make use of suggestions**: World-class collaborative coding platforms allow the ability to suggest changes during reviews (get with it, BitBucket!) Of these, I like GitHub's UX the best. Suggesting changes shows the author exactly what you'd suggest changing, and allows them to incorporate your suggestions with one click if they agree. The best part about this for me is the suggestion can be combined with a comment explaining why you're making the suggestion. Even if you're the admin, suggesting the change and then incorporating it provides some nice additional context.
* **Make use of review batches**: Most collaborative coding platforms allow the ability to store up multiple review notes and deliver them all at once, instead of individual notifications (again, BitBucket lags behind here). Where possible, such as in GitHub, I do my best to "start a review", make review comments/suggestions, and then submit all of the review content at once.

## Emojis I Tend to Use When Reviewing

* :warning:: Items I think are important enough to definitely be changed
* :information_source:: Additional information / context
* :question:: When I have a question about something that may not need to be addressed but that I'd like more information on.
* :blue_book:: Readability considerations
* :bulb: Ideas the PR made me think of (that I don't think need to be addressed now but might need to put out there somewehre)
* :trophy: / :tada: / :+1:: Things I want to point out that I like.
* :pick:: A nitpick. Something that matters to me but maybe only me. This is when I have the urge to say it despite the fact that it may not be that important. (I'm human, too!)

## Some Common Areas I Review

In addition to basic correctness and whether the pull request achieves its intended purpose, I tend to look at:

* **Checking Statuses**: Are all of the automated builds / checks passing for that pull request? I try to look at that first and if something is failing, I try to provide insight.
* **Wording**: I care a lot about wording/phrasing, which likely comes from having spent several years as a writing tutor. So I try to call out opportunities to be clearer with any wording that's being used.
* **Variable Names**: I try to ensure variable names are correct and descriptive.
* **Comments that should be issues**: If there are comments in the code similar to `// TODO`, I will try to get those addressed in the PR or moved into a separate work item in our work tracking tool.
* **Checklist Items**: If the project or author is using checklist items, I make sure the checklists are complete.
* **Ensure the correct branch target**: Nobody likes to accidentally merge something to the wrong spot. I usually glance at this -- or better yet, use simpler branching strategies that don't cause confusion in this regard.
* **Merging Strategy**: I usually check to ensure the project's defined merging strategy is being followed. For example, if a project requires one commit for a PR, I make sure the commits have been squashed, or that the automated strategy can be used (such as in GitHub's UI).

Happy coding!
