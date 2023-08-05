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
* **Make use of suggestions**: TODO
* **Make use of review batches**: TODO

## Emojis I Tend to Use When Reviewing

* :warning: for items I think are important enough to definitely be changed
* :information_source: for additional information / context
* :question: When I have a question about something that may not need to be addressed but that I'd like more information on.
* :blue_book: for readability considerations, 
* :bulb: for ideas the PR made me think of (that I don't think need to be addressed now) 
* :trophy: / :tada: / :+1: for things I want to point out that I like.
* :pick: A nitpick. Something that matters to me but maybe only me. This is when I have the ruge to say it despite the fact that it may not be that important. (I'm human, too!)

## Some Common Areas I Review For

* **Wording**: TODO
* **Variable Names**: TODO
* **Comments that should be issues**: TODO
* **Checking Statuses**: TODO
* **Ensure the correct branch target**: TODO
* **Merging Strategy**: TODO

Happy coding!
