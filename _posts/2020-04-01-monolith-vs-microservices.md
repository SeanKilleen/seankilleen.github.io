---
title: Monolith vs microservices
comments: true
tags:
  - Architecture
  - monolith
  - microservices
  - ''
date: '2020-04-01 12:02 -0500'
---
https://segment.com/blog/goodbye-microservices/My general take: "every problem can be solved by another level of abstraction, except too many levels of abstraction."

It's all about trade-off between service boundaries and good factoring -- two of the hardest problems to solve -- and how they relate to cognitive overhead, or the ability to reason about a system.

A monolith will grind to a halt if it's not well-factored, because the team will be unable to reason about it and unable to make quick progress.

A common reaction to this, rather than fix this problem, is to break something apart, but often people go into microservices and trade one problem for another. Now you have many small services that are easier to keep well-factored, but your overall system architecture complexity increases and reasonability decreases. You have a last-mile problem: how to bring all of those together in a composable user experience that degrades gracefully. How do to you ensure all of that stuff is traceable.

My opinion is that if organizations invested time in understanding domain boundaries, they'd be able to create well-factored monoliths that are much more sustainable, rather than trying to turn a domain problem into a system architecture problemBlog on mono vs micro

Asked for thoughts on https://segment.com/blog/goodbye-microservices/

My general take: "every problem can be solved by another level of abstraction, except too many levels of abstraction."

It's all about trade-off between service boundaries and good factoring -- two of the hardest problems to solve -- and how they relate to cognitive overhead, or the ability to reason about a system.

A monolith will grind to a halt if it's not well-factored, because the team will be unable to reason about it and unable to make quick progress.

A common reaction to this, rather than fix this problem, is to break something apart, but often people go into microservices and trade one problem for another. Now you have many small services that are easier to keep well-factored, but your overall system architecture complexity increases and reasonability decreases. You have a last-mile problem: how to bring all of those together in a composable user experience that degrades gracefully. How do to you ensure all of that stuff is traceable.

My opinion is that if organizations invested time in understanding domain boundaries, they'd be able to create well-factored monoliths that are much more sustainable, rather than trying to turn a domain problem into a system architecture problem

:+1: I think these articles generally make sense, but an important thing that they always tend to leave out is the fact that these decisions occur within a certain company's problem context.  microservices is completely valid if you are Netflix, have decomposed your domain into discrete pieces, and have serious scalability challenges. but stack overflow, which is one of the 50 most popular sites on the internet I think, runs on one well factored monolith, and doesn't even use the cloud

My approach:

 Start with a monolith -- always 
 Invest double the time in domain understanding than seems reasonable at first
 Look for boundaries and begin to understand them and their impacts
 Determine if splitting out based on a boundary makes sense, and what the impact is to overall app understanding
 Isolate the boundaries and develop contracts 
 Move the boundaries into their own service / deployment 

And throughout each of those steps, prioritize the ability of the team to reason about the system they're delivering

## the relationship to scaling agility

Scale into microservices once you're doing a monolith well -- otherwise you're just creating 100 tiny paper cuts and will have hell to pay

## The strangler pattern

One notable exception is legacy modernization and the strangler pattern. If you know which pieces you want to modernize first, breaking off a service with the purpose of creating that ability to modernize a piece at a time is fine.

## Todo: moving from one to the other

If you have monolith
And you have x / y / z pain points
And you are willing/prepared for x y z tradeoffs 
Then microservices can help you gain x/y/z

## don't forget: the goal at the end of the day is VALUE.

The goal is not to enable a ton of teams to independently deliver stuff. It's to work together to achieve value for users. Anything we do needs to originate from that place.
