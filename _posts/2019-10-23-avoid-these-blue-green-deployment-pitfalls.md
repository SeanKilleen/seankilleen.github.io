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

Blue green -- at its core -- is a technique to enable teams to deploy faster and more often. If your team is not interested in decreasing its deployment lifecycle times or deploying more often, the complexities of blue/green deployments may outweigh the benefits.

For example: if you aim to continuously deploy to an environment in a backwards-compatible way, but plan to keep a 2 month release cycle, then you will need to ensure that 2 months of changes can be deployed to the "off" environment, including database changes, without breaking backwards compatibility. It also means that any configuration flags related to features or changes will need to remain in an environment for the next 2 months, creating additional cruft and risk that the context of those cleanups will be lost. The amount of discipline a team needs to have in this case is exponentially higher.

If you are approaching blue/green to ease your deployment pain, you may be approaching the next pitfall.

## Pitfall #2: Conflating blue/green with Minimal-Downtime Deployments

Minimal-downtime deployments can be achieved without blue/green architecture, particularly in low-traffic environments. A combination of configuration flags and taking servers out of the load-balancer to update them should be 

## Pitfall #3: Attempting to Coordinate blue/green across multiple apps

## Pitfall #4: Assuming blue/green won't require much change

## Pitfall #5: Not Considering the Database in blue/green planning

## Pitfall #6: Organizing blue/green as the server level

## Pitfall #7: Pinning blue and green environments to specific "states"

E.g. blue environments always being non-prod.
