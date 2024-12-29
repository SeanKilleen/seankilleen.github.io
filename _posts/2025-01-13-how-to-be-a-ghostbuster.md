---
title: How to be a Ghostbuster
comments: true
tags:
  - ghost-developer
  - culture
  - leadership
date: 2025-01-13 09:00 -0500
---
According to some research that was [announced in November](https://x.com/yegordb/status/1859290734257635439), "Ghost developers" are 0.1x[^1] devs who barely do any work, and may have multiple jobs. Apparently it's as high as 9% according to the research. I saw this when [Aaron Stannard](https://twitter.com/Aaronontheweb) pointed it out [in a LinkedIn post](https://www.linkedin.com/posts/aaronstannard_finally-we-have-a-term-for-the-green-commit-activity-7265391640683397121-KRW4).

I found that figure striking, given the teams I've worked with and worked to build over the years. I don't know that one of these developers could actually exist in the environments I've been lucky enough to be a part of. That such a situation could occur speaks to a massive failure of engineering leadership and process. So, I want to take a little time to dive into how to prevent these sorts of situations from occurring. Let's become Ghostbusters.

## Engineering Leaders Need to be Able to Understand What's Happening

* You should be able to look at commits, PRs, chats, etc. and know who is participating and who isn't. If your team is too big or unwieldy for that, solve this problem first so that you can be an effective engineering leader.
* You should be interacting with team members regularly. If you do, your instincts will tell you if there's somewhere you need to dive deeper around someone's contributions or growth. You can't be in the code almost all the time and still be an effective engineering leader.
* You should have some sort of daily communication where the team talks about their work with everyone. Standup meetings are great for this; chat can work too in a pinch. What did someone do yesterday, what did they do today, and where are they stuck? Occasionally follow-up on the claims that are made in these meetings.
* Someone shouldn't be able to bullshit you. You should know enough about the people and the work that you can verify claims about work.

## And They Need to be Willing to Lead.

This means interacting with the people who report to you.

* It means coaching and picking up on areas of improvement
* It means setting goals
* It means having hard conversations when an expectation isn't being met
* It means being visible to team members and asking for feedback for yourself and other teammates that enables the previously mentioned activities.

## Work Shouldn't be Invisible

* A pull request system makes it clear who is making contributions to the codebase and what they are
* As much as I previously didn't love ticketing systems (GitHub issues, Jira, etc.) they are a very effective way to show the progress of work (including non-code work) and can be implemented in ways that aren't painful to use.
* Peers should be checking each others' work, reasonably often. This is good not just for communicating about and socializing the work and learning from each other, but also helps prevent someone from being able to merge meaningless work.

If there isn't some kind of an artifact or byproduct of the work that's been done, oftentimes no work has been done at all.[^2]

## It Helps if You're Working on Things That Matter

Ghost engineers hide in the places where work doesn't matter enough to be accountable for it.

If people and teams can be working on things that don't have enough impact to rate checking to see if folks are showing up to do their job, that's a problem to solve that might be costing you even more than a ghost engineer's salary.

## Quick Digression: GitHub Commits Aren't the Only type of Contribution.

I was a little concerned about the way the study seemed to frame the contributions of engineers around specifically commits. So I'd like to push back on those being the primary measure of engineering work / effectiveness. But the other activities can be checked as well:

* If devs are pairing/mobbing and therefore not a part of the commit, observe a mob session and see how folks participate.
* If folks are doing docs editing or analysis, make that work visible via tickets or similar systems, or look for the modification history of documents / wikis.

My point is -- if you're collecting stats on folks, just remember there's more than one kind of stat to check. But you can still check them

## Almost all of the above can be made public!

None of these things need to be hidden from teams or your organization. Your team should embrace transparency as an experiment -- if people still actively resist, it's worth digging deeper.

Examples of transparency from my current team:

* We work from tickets on boards that are visible to the whole company. Anyone can look and ask questions.
* We make deployments visible via chat and GitHub releases.
* We send a weekly update on what we're doing.
* We have a daily standup meeting or chat where we run down the basics (yesterday, today, blockers) and we follow up with each other.
* We use pull requests to show the progress of work. PRs are tied to tickets which are visible on the board to ensure we can all see.
* PRs get reviewed by other developers

If someone came to me and said, "what did [x] do last week", I could provide a concrete answer within minutes.

You could also publish metrics (without attempting to influence them) -- PRs/commits per person, tickets closed, etc. I don't necessarily love this because it could lead to folks trying to game that data, but if I thought I had a ghost developer, it might be a way to root them out.

## Neither Good Nor Bad Developers Exist in a Vacuum.

Our workplaces are made up of systems with inputs and outputs. We have to be aware of the systems and leadership that enable the behaviors we want to embrace or improve.

Who you gonna call? Leadership.

I'd love to hear your thoughts on this in the comments.

[^1]: Not that I necessarily agree with the idea of 10x devs, but this is used to make a point.
[^2]: I say "oftentimes" here because leadership conversations, internal training, design sessions etc. can all have positive impact. However, I would argue that there are also artifacts produced by these activities.
