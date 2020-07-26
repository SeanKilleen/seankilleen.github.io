---
title: When does it make sense to use containers?
comments: true
tags:
  - opinion
  - containers
date: 2020-07-26 16:02 -0400
---
Inspired by Immo's tweet: https://twitter.com/terrajobst/status/1287458432547606529?s=20

* It might **not** make sense (or more sense) to use containers. They're not always a much better solution. That's rule number one of any assessment like this.
* Containers make a lot of sense when people might be using differing environmental setups, especially those that differ across OSes (node version differences, ruby with native gems, python environments). If everyone is using a standard environment or can easily configure an environment to match yours, this benefit is reduced.
* Containers make a lot of sense when you might have multiple dependencies. Does your app depend on a web site and SQL server database? You can ask someone to install SQL server, or use an alternative and update the connection string...or you can use docker-compose to wire up multiple containers together and start them up.
* Containers make a lot of sense when consistency is helpful. E.g. if I do a lot of local dev or system/environment configuration and I want that to be consistent across local and dev environments, this is a great way to do it.
* Deployments. Containers become a fundamental package / unit of deployment. Simplifies CI/CD. Once you have the container, it's just a question of pulling the image and overriding configuration in an environment.
* Quick dev workflow. Containers make it quick to get up to speed for a new dev. Pull the code, pull the container, get to work. This really only helps if the devs have an understanding of containers though. Otherwise, it could have the opposite effect and create a barrier to entry where someone has to understand containers and install Docker just to test their changes locally.
