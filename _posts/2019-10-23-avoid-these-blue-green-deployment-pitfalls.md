---
title: Avoid These Blue/Green Deployment Pitfalls
comments: true
tags:
  - ci
  - cd
  - deployments
  - infrastructure
  - blue green
date: '2019-10-23 11:24 -0400'
---
I've seen organizations make some interesting decisions lately around the concept of "blue/green deployments". I think in some cases, these changes can lead to some pretty big pitfalls, so I wanted to write up some thoughts here so that I could refer to them later.

## A Quick Introduction: What do we mean by "blue/green deployment"?

Blue/green deployments -- generally speaking -- refers to an approach to deployments in which there are "blue" and "green" environments in production, with a load balancer that points to one of the environments at a time. Deployments are continuously made to whichever environment is not "on" -- in a backwards-compatible way -- and then the load balancer is switched. These switches may happen per change, but generally happen after a short amount of time. If a problem happens upon switching, the environment can be switched back, removing the issue.

There are a ton of benefits to blue/green deployments -- the ability to quickly deploy fixes and features, a built in belt-and-suspenders system if a deployment goes wrong, and reducing fear of deployment and change across an organization.

## Pitfall #1: Not Understanding the Goals of blue/green

blue/green -- at its core -- is a technique to enable teams to deploy faster and more often. If your team is not interested in decreasing its deployment lifecycle times or deploying more often, the complexities of blue/green deployments may outweigh the benefits.

For example: if you aim to continuously deploy to an environment in a backwards-compatible way, but plan to keep a 2 month release cycle, then you will need to ensure that 2 months of changes can be deployed to the "off" environment, including database changes, without breaking backwards compatibility. It also means that any configuration flags related to features or changes will need to remain in an environment for the next 2 months, creating additional cruft and risk that the context of those cleanups will be lost. The amount of discipline a team needs to have in this case is much greater than when employing blue/green.

If you are planning to utilize blue/green purely to ease your deployment pain, you may be approaching the next pitfall.

## Pitfall #2: Conflating blue/green with Minimal-Downtime Deployments

Blue/green is often touted as "the way to zero-downtime deployments". But while it is certainly one way to achieve that end, it is not the only way. 

Minimal-downtime deployments can be achieved without blue/green architecture, particularly in low-traffic environments. A combination of configuration flags and taking servers out of a load-balancer to update them could be sufficient. When combined with automation, this could look like:

* A deployment is kicked off. 
* Backwards-compatible database changes are run
* Server by server:
* A server is taken out of the load balancer
* Software is deployed to the server
* Feature flags are set
* The server is returned to the load balance pool

Many teams, for example enterprise teams, have much more leeway beyond that. They could:

* Use their deployment tooling to schedule a deployment out of hours
* Take the application offline for 5 minutes using a flag or convention such as `offline.html`
* Deploy database changes 
* Update all servers at once
* Remove the offline flags

This is minimal downtime, scoped within the business's actual constraints. It's still 100% automated and the risk is only slightly higher.

Consider your application's actual needs. You may wish to start with minimal downtime deployments before attempting zero-downtime deployments.

## Pitfall #3: Attempting to Coordinate blue/green across multiple applications

I see this sometimes in enterprise applications. Large business system `x` and large business system `y` interact with each other. One system may make updates that the other depends on. Surely, we need to ensure the blue and green environments on these systems match! 

There's a lot of pain in that statement.

Large systems should not have to match each other in case something changes. Those systems should consider each other to be clients, meaning that any changes they make should be made in a backward-compatible and/or feature-toggled way. And these systems should have specified contracts or interfaces such that changes are known in advance and communicated to necessary stakeholders.

System `x` should be able to evolve itself in a blue/green way even if system `y` doesn't, because the key is that the developers will be considering system `y` to be a customer of their system.

Businesses who attempt to keep all systems aligned in blue/green also end up deploying based on the lowest common denominator. Now, instead of evolving as quickly as possible, the systems are actually further coupled together! Whoops. 

## Pitfall #4: Assuming blue/green won't require much change

For many development teams, the shift to blue/green isn't a shift in process or tooling -- it's a paradigm shift in how they think about deploying software. It often comes alongside other development practices such as feature flagging and trunk-based development (as opposed to longer feature branches or gitflow). There's also a consideration for backward-compatibility (and the maintenance that goes with it) that needs to be actively in the mind of the development team.

These practices -- while excellent and worthy of pursuit -- take time to adjust to, especially if your team is unfamiliar with them. Mistakes will happen, and adjustments will need to be made. It's important to ensure that your company's culture is fine with focusing on short recovery times vs never having a problem occur (for more information on this, I recommend the book Accelerate.)

## Pitfall #5: Forgetting about tests in blue/green deployments

As I mentioned above, mistakes will be made. If you're continuously deploying to your "off" environment so that you can switch over at any time, you need to have the confidence that the deployment pipeline is stable and you won't be introducing problems. 

I highly recommend that you have an automated test suite that provides you with as much of a safety harness as possible prior to attempting blue/green deployments. This way, the flipping of a switch for deployments becomes a nothing event with no cause for concern. "Move fast and break things" is not a strategy I'd advise for most teams.

## Pitfall #6: Not Considering the Database in blue/green deployments

Databases often throw a wrench into thinking about blue/green deployments. What do migrations mean when they need to be backward compatible?



## Pitfall #7: Organizing blue/green as the server level

## Pitfall #8: Pinning blue and green environments to specific "states"

E.g. blue environments always being non-prod.
