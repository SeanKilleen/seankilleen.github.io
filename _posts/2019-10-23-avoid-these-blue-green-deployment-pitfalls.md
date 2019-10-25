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

For many development teams, the shift to blue/green isn't a shift in process or tooling -- it's a paradigm shift in how they think about deploying software. It often comes alongside other development practices such as feature flagging and trunk-based development (as opposed to longer feature branches or "git flow"). There's also a consideration for backward-compatibility (and the maintenance that goes with it) that needs to be actively in the mind of the development team.

These practices -- while excellent and worthy of pursuit -- take time to adjust to, especially if your team is unfamiliar with them. Mistakes will happen, and adjustments will need to be made. It's important to ensure that your company's culture is fine with focusing on short recovery times vs never having a problem occur (for more information on this, I recommend [the book _Accelerate_](https://www.amazon.com/Accelerate-Software-Performing-Technology-Organizations-ebook/dp/B07B9F83WM/ref=sr_1_3).)

## Pitfall #5: Forgetting about tests in blue/green deployments

As I mentioned above, mistakes will be made. If you're continuously deploying to your "off" environment so that you can switch over at any time, you need to have the confidence that the deployment pipeline is stable and you won't be introducing problems. 

I highly recommend that you have an automated test suite that provides you with as much of a safety harness as possible prior to attempting blue/green deployments. This way, the flipping of a switch for deployments becomes a nothing event with no cause for concern. "Move fast and break things" is not a strategy I'd advise for most teams.

## Pitfall #6: Not Considering the Database in blue/green deployments

Databases often throw a wrench into thinking about blue/green deployments. What do migrations mean when they need to be backward compatible?

Consider how you might go about renaming a column in a database from `ColumnA` to `ColumnB`. Rather than a migration that simply does that in one shot, you'll now need to:

* Add a feature toggle that treats writes to `ColumnA` as writes to both `ColumnA` and `ColumnB` (toggle it off).
* Add commit with a migration that creates a column `ColumnB` and populates it with existing data, and that toggles the flag on.
* A commit that turns off the feature flag to write to both columns and instead now writes only to `ColumnB`
* A commit that adds a migration that deletes `ColumnA`

As you can tell, that's a tiny bit more complex than one migration.

## Pitfall #7: Trying to do database changes prior to code changes

One strategy -- normally due to a long deployment lifecycle (pitfall #1) -- is the idea that database changes will be done separately from the code, and will be done in advance of the deployment. 

But let's allow this to play out. Someone now has to:

* Understand the upcoming work one release in advance. Monthly release cycle? Hope you know the database changes associated with it an extra month in advance!
* Make the change 
* Ensure you don't accidentally utilize that change for a month
* Now pick up the story, a month later, and remember to appropriately utilize the prior change
* Wait another month afterward to do any cleanup

## Pitfall #8: Flipping blue/green switches at the server level instead of a load balancer

Organizations sometimes try to identify "blue" and "green" servers at the server level -- that is to say, you attach certain servers to always having an identity of "blue" or "green", rather than configuring a load balancer to point to those pools of servers.

When this happens, you oftentimes end up attempting to drop files in certain locations on a server to have them inserted or removed from a load balancer pool. This is prone to error, and can result in a server incorrectly being in the active or non-active environment. 

Better instead to add these servers to `green.myapp.com` and `blue.myapp.com` and then configure your load balancer's instance to point to one DNS pool or the other. 

## Pitfall #9: Pinning blue and green environments to specific "states"

I've seen some organizations get nervous about the idea of toggling back and forth to different environments. In response to this, they set a group of servers to always be considered "blue" or "inactive", and attempt to consider the green servers to always be the "active" servers. 

In this case, pitfall #8 comes into place as well, and organizations attempt to move servers into and out of blue and green groups as part of a deployment, rather than flipping the switch on a load balancer.

## Pitfall #10: Not continuously deploying to your "off" environment

In places where deployment has a high visibility or fear level -- usually prior to instituting proper continuous deployment practices or building up confidence in the code -- _going to production_ :TM: carries a lot of weight. 

In that situation, why would anyone ever deploy to your prod environment, even the inactive one?

Deploying to the non-production environment often is how we force small changes over time rather than larger, riskier changes. It's also how we get very quick feedback on whether our "backwards compatible" changes really are, indeed, compatible.

If those changes collect in a non-production environment, you're not necessarily testing them with real users, and even with a massive acceptance test suite, it will be hard to know if anything is actually broken. Then when you do deploy to your inactive production environment and something breaks, it's _Panic Time_ :TM:.

## Pitfall #11: Attempting to Minimize Failure Instead of Recovery Time

As I mentioned earlier, mistakes will be made. One of the key pitfalls a group can make is aiming to maximize the time between problems rather than minimize the time it takes to get past problems when they inevitably occur. 

If a group is trying to prevent failure with blue/green, they're likely not fully understanding the promise of blue/green deployments. On the other hand, a group that fully embraces continuous delivery knows that sometimes things will go wrong. They will aim to be able to fix that in a matter of minutes, learn from it, and build up the tooling and knowledge to ultimately prevent many more issues from occurring.

If a culture is not, realistically, a learning culture that values progress over a perfect track record, many of the benefits of blue/green deployments will be lost on the organization.

## A Tale of Two Teams

Let's contrast two hypothetical teams -- one that is hitting these pitfalls, and one which has not fallen into these traps.

#### The Team Hitting the Pitfalls

This team is stressed about their deployments. Even though they're supposed to be zero-downtime, it feels like their deployments haven't gotten much faster. Multiple people need to be available to coordinate load balancer activities and switch the servers over from blue to green. They deploy to the inactive production site the day before launch, but everyone is tense because there's almost always a backwards compatibility issue that they have to scramble to fix. Their customers are complaining that stories are taking so much longer, but what can they do -- the backwards compatibility is important. 

On top of the stress about deploying, stories aren't moving faster. Stakeholders still have an intense prioritization system where there's a lot of fear about whether something will be tested enough to go out the door. Large chunks of work are still done off of the main branch in long-running branches that are painful to integrate.

Wasn't this supposed to get better?

#### The Team That Avoids the Pitfalls

Deployments are a non-event. The team learned about the steps they'd need to take to ensure backwards compatibility before beginning. The good news is, because deployments are happening all the time, these backwards compatibility changes can happen pretty quickly back to back so nobody forgets about them.

There was a problem with one of the backwards compatibility changes last week, but luckily since the whole pipeline is streamlined and moving to production, all it took was the time to write the fix and review the code change before it went out to production and resolved the issue. Way better than the scrambling over down-time before! 

They also had some pain points with testing -- it turns out they were over-confident about some of their code once or twice. Luckily, a quick deployment for the fix combined with lessons learned means there's a lot more knowledge on the overall team about what to look for and test for in their code. The stakeholder's confidence is high because issues are resolved quickly, and bugs aren't re-appearing because the code test coverage is improving. Plus, it's worth the trade-off anyway to not have to wait months for releases!

Since deployments are a non-event now, users see new value on a regular basis, and nobody has to argue about whose changes are making it into which release. The team has a lot more leeway, because "it will be in production soon" now has a long track-record of success.

Even better, the little stuff now gets done much faster. Since we're collaborating at the speed of our users, we can fix a problem or satisfy a request in an hour as long as the product owner is on board with it, saving a ton of time on prioritization, ticket write-ups, etc. It's even made collaboration a bit more fun -- it's empowering for the team and for users to fix a problem and then just watch it work in production.

Things feel...better.
