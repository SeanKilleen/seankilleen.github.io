---
title: When does it make sense to use containers in a development workflow?
comments: true
tags:
  - opinion
  - containers
date: 2020-07-26 16:02 -0400
---
Inspired by Immo Landwerth's tweet: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I’m using Azure App Service run my ASPNET Core app (Linux). What’s the benefit of using docker?</p>&mdash; Immo Landwerth (@terrajobst) <a href="https://twitter.com/terrajobst/status/1287458432547606529?ref_src=twsrc%5Etfw">July 26, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

I figured I'd add my (hopefully reasonably nuanced) opinion here.

* It might **not** make sense (or more sense) to use containers. They're not always a much better solution. That's rule number one of any opinion like this.
* Containers make a lot of sense when people might be using differing environmental setups, especially those that differ across OSes (node version differences, ruby with native gems, python environments). If everyone is using a standard environment or can easily configure an environment to match yours, this benefit is reduced.
* Containers make a lot of sense when you might have multiple dependencies. Does your app depend on a web site and SQL server database? You can ask someone to install SQL server, or use an alternative and update the connection string...or you can use docker-compose to wire up multiple containers together (one being a SQL server container) and start them up.
* Containers make a lot of sense when consistency is helpful. E.g. if I do a lot of local dev or system/environment configuration and I want that to be consistent across local and dev environments, this is a great way to do it.
* Deployments. Containers become a fundamental package / unit of deployment. Simplifies CI/CD. Once you have the container, it's just a question of pulling the image and overriding configuration in an environment.
* Quick dev workflow. Containers make it quick to get up to speed for a new dev. Pull the code, pull the container, get to work. This really only helps if the devs have an understanding of containers though. Otherwise, it could have the opposite effect and create a barrier to entry where someone has to understand containers and install Docker just to test their changes locally.
* It's possible -- but I'd need to confirm this -- that there could be cost advantages to running in a container instead of a tiny web app on Azure App Service, due to the reduced footprint. But again, I haven't confirmed that.
* If you need to support multiple versions of Linux or others' environments, Dockerfiles and tags seem to be a great way to do that.

So if you're writing an ASP.NET Core web app on Linux and it runs equally fine on windows and most of your devs will be able to easily get the .NET Core version you're using installed and there's not too much in terms of OS configuration that needs to happen -- there may not be much benefit at all. In some cases, I've found that providing a Dockerfile alongside the app and using that as the unit of deployment has made things pretty straightforward for me -- build the container, push to the registry, pull the tag, run the app. Some would argue that introducing a container registry into the mix is more complexity than necessary, and that's a valid point; I think it comes down to preference there.
