---
title: "My Tenets of Operational Support"
layout: default
date: 2018-12-28 22:00:00.000000000 -05:00
excerpt: "Building it is nothing if you can't support it."

comments: true
---

I had this drafted for a while as notes I'd sent to a colleague, and I figured I would write it up here.

Building something isn't enough; you have to be willing to see it through to production and also support it in the real world. This is part of being a responsible development team. With that in mind, I drafted some quick notes on some things to look out for as part of performing operational support for an application. This is written in the form of a contract with users or clients.

## Before Something Goes Wrong

* We will attempt to spot leading indicators of a problem with monitoring and analytics.
* We will ensure a clear "chain of custody" for any potential production issues. Who will be on duty? Who will receive it? We'll make sure we know that stuff and that you know it, too.

## When Something Goes Wrong

* We will not hide it.
* It will be everyone's responsibility.
* We will make sure you know about it quickly
* We will radiate information as we progress
* We will attempt to favor signal over noise
* We will track any questions or confusion that gets in our way
* We will own it.

## After Something Goes Wrong

* We will work to resolve it in a *repercussion-less* way. Sometimes people say "blameless", but I think it's healthy for someone to be able to say "nope, this was totally my fault." -- leadership more than anyone.
* We will work rapidly and diligently to understand root causes
* We will create follow-up tickets to address any competing causes. These can be prioritized by the business according to the impact of the production issue.

# Information in a Production Support Ticket

This is the format I've found to work well so far; I'm open to improving it.

#### The Original Request

Whatever the incoming request is, in its original format. This is helpful sometimes to see how far away from the original report the issue ends up being (which can be something to improve).

#### The Symptoms

Current symptoms end users are experiencing.

#### Scope (optional)

Does this apply to a subset of users? all users? only certain systems / regions? can be helpful to include this.

#### Root Cause(s)

This might start out as "TBD". But the goal is to arrive at root causes eventually.

#### Next Actions

A bulleted list of next actions and who / which groups are responsible for them. You can then check these off as you go.

#### Fixes for Symptoms

Is there something that can be done to alleviate symptoms of the problem? Some adjustment for bad data? Redirecting users to an offline page? Spinning up more servers? Note that here.

#### Fixes for the Root Cause

What the end result fix will be for the issue. Normally starts out as "TBD". 

#### "Whys"

Questions that pop up as you go.

* "Why are we seeing this other error? Is it related?"
* "Why didn't we see this earlier?"
* Why were we prevented from accessing system x?
* Why didn't communication go out about this more quickly?

Be liberal with these. They represent a gold mine for future prevention / mitigation.

#### Prevention / Mitigation suggestions

Starts out TBD. This happens after the ticket is completed. You look at the root cause and the "why" questions and lead to one or more actions that think will prevent this issue in the future or could have reduced the time to resolution or overall impact. Turn these into tickets in your backlog to be prioritized by the business.

# Something Happens: The Timeline

* A report of a production issue is received by anyone.
* That person creates a production support ticket (on my client, this is a ticket with a `fixVersion` of "Production Support"). If you have a group at the ready, someone says "I'm creating the ticket".
* The ticket includes the original request, our understanding of symptoms & root causes, and a list of next actions which likely at this point just includes "look into the problem". Most sections of the ticket might read as TBD.
* That person adds a list of watchers to the ticket -- predetermined or best guess. 
* That person communicates via e-mail or to some larger group that the ticket has been created, with a link so that people can subscribe.
* **FROM THIS MOMENT FORWARD**, all conversation about the incident should be on the ticket as much as possible. E-mails get redirected to the ticket or copied / pasted in as comments. Requests for updates are referred to the ticket. Ticket becomes the one source of radiating information.
* One or more people forms a tiger team to look into the issue. This is a mob, not 10 people working & updating separately. Too much noise.
* The team works to understand the symptoms -- adds comments, updates the ticket body as we know more.
* As root cause is determined, the ticket is updated.
* Throughout the process, people are asking questions in the "why" section and announcing their actions or intentions via ticket comments.

Phew! The issue is resolved. Next up:

* A post-mortem if warranted: Why did the issue happen, and let's work through all of the "why" questions associated with the root cause and the rest of the things we surfaced.
* Next actions for prevention / mitigation are generated, added to the ticket.
* Other tickets are created to reference those actions, referring back to the original problem ticket. 
* Those are prioritized according to how much we think the actions would help & how much the business truly cares to take them into account.

# Your turn

What are your team's tenants for operational support? Sound off in the comments!
