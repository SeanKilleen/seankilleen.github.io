---
title: Creating and Modeling "Sensible Happy Paths" for Dev Team Success
comments: true
date: 2023-09-03 14:25 -0400
---

When Setting teams up for success with modern software delivery, I've found it helps to create successful paths of least resistance. Here are some things I've tried, learned, and had success with.

## Start With Trust and Understanding

All of the tips I share below assume that you have built trust and spent a good chunk of time listening to people/teams and sensing patterns of possible improvement.

Software delivery is a team sport. Any approach that tries to improve things without caring about and for the people who will be impacted is a recipe for things to go wrong.

Not sure if you've done that enough? Here's a barometer: if you've listened enough, some of these suggestions will seem like great ideas and others will fall to the back of your backlog because you'll have a feeling they might not apply.

With that said, let's look at some techniques that have accelerated the happy path on teams I've led.

## Modeling behavior around issues and "Code Flow"

* Demonstrating traceability is important by creating issues and asking others to do
* Talking about how important the visibility of work is.
* TODO: link to blog posts on PR creation and review

## Setting up "GitHub Flow" (Where Applicable)

I've found that GitHub Flow tends to hit a sweet spot for teams that didn't previously have a good happy path. One main branch with pull requests off that main branch is a model that can fit into most people's heads. This makes it easier to talk about how software is delivered.

NOTE: This won't work as well if, say, you're delivering multiple branches of software at a time (e.g. supporting 1.x and 2.x for various customers). It's important to recognize the practical limitations here.

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
