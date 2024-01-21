---
title: Creating and Modeling "Sensible Happy Paths" for Dev Team Success
comments: true
excerpt: Happy paths compound over time.
tags:
  - culture
  - communication
  - leadership
date: 2023-09-03 14:25 -0400
header:
 overlay_image: /images/overlays/unsplash/timothy-dykes-yapM31BKJx8-unsplash.jpg
 overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
 caption: "Photo credit: [**Timothy Dykes @ Unsplash**](https://unsplash.com/@timothycdykes?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash)"

---
When Setting teams up for success with modern software delivery, I've found it helps to create "successful paths of least resistance". Here are some things I've tried, learned, and had success with in the hopes they might help someone else. I prioritize understanding the state of these things first if I don't see them in an environment I enter.

## Before We Begin: Start With Trust and Understanding

All of the tips I share below assume that you have built trust and spent a good chunk of time listening to people/teams and sensing patterns of possible improvement.

Software delivery is a team sport. Any approach that tries to improve things without caring about and for the people who will be impacted is a recipe for things to go wrong.

Not sure if you've done that enough? Here's a barometer: if you've listened enough, some of these suggestions will seem like great ideas and others will fall to the back of your backlog because you'll have a feeling they might not apply.

If you haven't worked to build trust and rapport with your team, do that first.

With that said, let's look at some techniques that have accelerated the happy path on teams I've led or been a part of.

## Modeling Behavior Around Feedback

A quick introductory note: when I say "modeling behavior", I mean "demonstrating the way you'd like your teams to act". [What you do is who you are](https://www.amazon.com/What-You-Do-Who-Are/dp/0062871331). Your actions will influence the actions of others on your team.

One of the most crucial things for a leader to nail early on is to encourage feedback, _especially_ if it's critical feedback. I had a leader I loved working with (thanks [Jeff](https://itsanicelife.com/) at [Excella](https://excella.com)!) who really believed that "feedback is a gift". His willingness to take blunt feedback allowed me to speak up many times and spark conversations that helped the organization or helped me to grow my understanding -- sometimes both!

Explicitly ask for feedback. Discuss ways people like to give and receive feedback. Authorize people in one-on-one settings to provide this feedback, especially in front of a group. And _celebrate the heck out of it_ when it happens. You will not always be perfect at this; I'm sure not! But working at it continuously will make you and your teams flourish.

## Modeling Behavior Around Visibility, Issues and "Code Flow"

* Demonstrating traceability is important. By creating issues/tickets/cards and asking others to do so, you'll start to drive visibility of the work your teams are doing. Going first here is important if it's not already being done, because it demonstrates the level of effort you expect and shows you're willing to do it even if you're already busy.
* Whenever an "all hands on deck" style issue pops up, even if its pre-production, try to keep track of things that would have helped while you're going through it. Turn those things into follow up tasks. This helps show the importance of iteration & learning.
* Remind people how important the visibility of the work is by ensuring there are places for work to be visible, regularly viewing it as a team, and ensuring that your work isn't somehow exempt from this.

I also have some thoughts on how I model [pull request creation]({% post_url 2023-08-07-my-process-for-submitting-pull-requests %}) and [PR review]({% post_url 2023-08-10-my-process-for-reviewing-pull-requests %}), for those who are operating in that place.

## Setting up "GitHub Flow" (Where Applicable)

I've found that [GitHub Flow](https://githubflow.github.io/) tends to hit a sweet spot for teams that didn't previously have a good happy path. One main branch with pull requests off of that main branch is a model that can fit into most developers' heads. This makes it easier to talk about how software is delivered.

**NOTE:** This won't work as well if, say, you're delivering multiple branches of software at a time (e.g. supporting 1.x and 2.x for various customers). It's important to recognize the practical limitations here; if you're in that situation, you've likely already discovered a different happy path.

## Break the Notion of "One Person to a Work Item"

Software development is a team sport. Teams self-organize. If people want to pair/mob on a problem because that will produce the best output, that's what I want. I try to think of a ticket assignee as an ambassador for the work; I'd like them to provide the update There's no competition for who can complete the most tickets. We succeed together or not at all.

## Implementing Pull Request CI

If this doesn't already exist, automating continuous integration on all pull requests can be a game changer. We can shift a lot of quality control "to the left", helping developers avoid bad merges before they happen. This sensible default provides a happy path that improves quality. You can then add on to it -- think about spell-checking for docs, or automated security review, or image optimization.

## Adding Automated Tests

If these don't exist, I try to -- at a minimum -- add the foundation and infrastructure so they can begin to exist. Then, I add a few basics. Over time I'll use these or will come across opportunities to help users use them.

## Defaulting to Squash Merge

GitHub and other tools allow developers a choice of merge styles when PRs are merged. I've found that in most cases, especially if adopting PRs and automating continuous integration on them, the "squash and merge" option is a great default. It squashes many small commits, keeps one commit per PR, still ties things back to the PR for future reference. This also frees developers to feel they can make many small commits (which I'm a fan of) without polluting the main branch when things are merged in.

So in my teams, if a default hasn't been strongly established, I typically make "squash and merge" the default option. I've yet to hear a complaint.

## Introduce Dependabot

If you're on GitHub, you have the ability to use Dependabot to track and surface updates. Keeping dependencies up to date is normally forgotten until it's a big chore, so creating a sensible happy path around this will improve both security and the developer experience of your teams. It also will likely lead to a few (likely inexpensive) lessons on the importance of reading release notes before merging (or improving your CI system to better detect issues with some dependencies).

## README Files and Developer Onboarding

I always create or update the `README` file for a repository I'm going to be working in regularly. I add the information I wish I knew that's relevant to the code, and aim to give a new team member a smooth start. This might include conceptual introductions, tooling installation instructions / scripts, historical context, etc.

Zooming out a little bit from an individual codebase, I also think it's important to give new team members a landing page on day 1. I tend to ensure this includes a checklist of the things that need to be done -- both by them, and for them -- as well as helpful links and frequently asked questions. I try to make a new team member's first task be to improve the on-boarding page for anyone who comes after them; this explicitly empowers them to question things, which sets the tone for their tenure in addition to improving the content.

## ~~A Place~~ Places to Radiate Information

If they don't exist, I try to create paths of least resistance for people to radiate information -- to put things out there in ways that help synapses fire across the group or organization. This takes some experimenting to find what works for your specific context, but successes I've had in the past have been:

* Creating Slack channels when I notice a common topic that can stand on its own and I want others to be able to step into that stream at any moment
* Group chats -- for certain context, for my team, for inter-team touchpoints.
* Wiki pages
* Kanban boards for radiating work and its status
* A "things I learned" channel where people can put helpful tips and celebrate learning.
* Cultural fun spaces (joy can be radiated too!) Great examples I've seen of this include `#dadjokes` channel and a `#twinning` channel (for when people looked to be dressed the same IRL or in a virtual meeting).
* A `#megaphone` channel or similar, when you want people to re-post something or hype something up.

## Formatting / Rules Auto-enforcement

We can disagree on rules or formatting considerations all we want, and I find it best to be flexible in matters of style. But, there should be some tooling and process to auto -enforce the rules we care about.

One way to do this is to run your formatting tool all the time. For example, there's [a great GitHub Action for the `dotnet-format` command](https://github.com/marketplace/actions/dotnet-format). You can use it to run all the time and commit changes back to the branches. Now nobody has to think about the rules unless they disagree with them. And if you disagree, you can meet about it, update your `.editorconfig` file, and auto-format your codebase to be in-line with the new preferences.

## Normalize Asking for Help and Improving Things

One rule I like for this that I learned from somewhere a long time ago is the "30 minute rule". As in: don't ask for help until you've spent 30 minutes on trying to solve an issue yourself, but don't wait longer than 30 minutes to ask for help." I like it because it's an easy thing to remember and it applies to everyone regardless of seniority.

Similarly, improving things is important. Try to regularly hold retrospectives, or at least continually ask what can be improved and praise people when they note those opportunities. "Developer Experience" is a legitimate category of software development work, so I try to ensure it always exists somewhere as a formal bucket to capture suggestions.

## Wrapping Up

This is by no means a complete list, but I have to stop here lest I spend way too much time trying to wrack my brain for every tip I've seen or lived. Did I miss something important to you? Tell me in the comments!
