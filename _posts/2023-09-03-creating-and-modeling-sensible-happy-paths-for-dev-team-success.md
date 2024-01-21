---
title: Creating and Modeling "Sensible Happy Paths" for Dev Team Success
comments: true
date: 2023-09-03 14:25 -0400
---
When Setting teams up for success with modern software delivery, I've found it helps to create "successful paths of least resistance". Here are some things I've tried, learned, and had success with in the hopes they might help someone else.

## Start With Trust and Understanding

All of the tips I share below assume that you have built trust and spent a good chunk of time listening to people/teams and sensing patterns of possible improvement.

Software delivery is a team sport. Any approach that tries to improve things without caring about and for the people who will be impacted is a recipe for things to go wrong.

Not sure if you've done that enough? Here's a barometer: if you've listened enough, some of these suggestions will seem like great ideas and others will fall to the back of your backlog because you'll have a feeling they might not apply.

If you haven't worked to build trust and rapport with your team, do that first.

With that said, let's look at some techniques that have accelerated the happy path on teams I've led or been a part of.

## Modeling Behavior Around Issues and "Code Flow"

A quick introductory note: when I say "modeling behavior", I mean "demonstrating the way you'd like your teams to act". [What you do is who you are](https://www.amazon.com/What-You-Do-Who-Are/dp/0062871331). Your actions will influence the actions of others on your team.

* Demonstrating traceability is important. By creating issues/tickets/cards and asking others to do so, you'll start to drive visibility of the work your teams are doing. Going first here is important if it's not already being done, because it demonstrates the level of effort you expect and shows you're willing to do it even if you're already busy.
* Whenever an "all hands on deck" style issue pops up, even if its pre-production, try to keep track of things that would have helped while you're going through it. Turn those things into follow up tasks. This helps show the importance of iteration & learning.
* Remind people how important the visibility of the work is by ensuring there are places for work to be visible, regularly viewing it as a team, and ensuring that your work isn't somehow exempt from this.

I also have some thoughts on how I model [pull request creation]({% post_url 2023-08-07-my-process-for-submitting-pull-requests %}) and [PR review]({% post_url 2023-08-10-my-process-for-reviewing-pull-requests %}), for those who are operating in that place.

## Setting up "GitHub Flow" (Where Applicable)

I've found that GitHub Flow tends to hit a sweet spot for teams that didn't previously have a good happy path. One main branch with pull requests off that main branch is a model that can fit into most people's heads. This makes it easier to talk about how software is delivered.

**NOTE:** This won't work as well if, say, you're delivering multiple branches of software at a time (e.g. supporting 1.x and 2.x for various customers). It's important to recognize the practical limitations here.

## Implementing Pull Request CI

If this doesn't already exist, CI on all pull requests can be a game changer. We can shift a lot of quality control "to the left", helping developers avoid bad merges before they happen. This sensible default provides a happy path that improves quality.

## Defaulting to Squash Merge

GitHub and other tools allow developers a choice of merge styles when PRs are merged. I've found that in most cases, especially if adopting PRs and CI on them, the "squash and merge" option is a great default - squashes many small commits, keeps one commit per PR, still ties things back to the PR for future reference.

So im my teams, if a default hasn't been strongly established, I typically make "squash and merge" the default option.

## Introduce Dependabot

If you're on GitHub, you have the ability to use Dependabot to track and surface updates. Keeping dependencies up to date is normally forgotten until it's a big chore, so creating a sensible happy path around this will improve both security and the developer experience of your teams.

## README Files and Developer Onboarding

TODO

## A Place to Radiate Information

TODO

## Formatting / Rules Auto-enforcement

We can disagree on rules or formatting considerations all we want, and I find it best to be flexible in matters of style. But, there should be some tooling and process to auto -enforce the rules we care about.

TODO: "dotnet fmt"

## Normalize Asking for Help and Improving Things

One rule I like for this is the "30 minute rule", as in: don't ask for help until you've spent 30 minutes on trying to solve it yourself, but don't wait longer than 30 minutes to ask for help." I like it because it's an easy thing to remember and it applies to everyone regardless of seniority.

Similarly, improving things is important. Try to regularly hold retrospectives, or at least continually ask what can be improved snd praise people when they note things. "Developer Experience" is a legitimate category of software development work.
