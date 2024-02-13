---
title: "A Relfection: 6 Months in my New Position"
comments: true
excerpt: Taking stock.
tags:
  - personal
  - reflection
  - leadership
  - goodstuff
date: 2024-02-14 07:00 -0500
header:
  overlay_image: /images/overlays/unsplash/ali-syaaban-42-pw-XP5UQ-unsplash.jpg
  overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
  caption: "Photo credit: [**ali syaaban @ Unsplash**](https://unsplash.com/@zylo25?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash)"
---

It's Valentine's Day! I'm grateful for all the love I've got in my life. Today also marks 6 months since I started at [SCT Software](https://sctsoftware.com) as Vice President of Innovation & Products. That represented a big move for me -- becoming responsible for leading an emerging engineering organization.

I'm a big believer in [keeping a "good stuff" list]({% 2018-12-29-you-should-keep-a-good-stuff-list %}). My experience so far has felt phenomenal, and I figured I should take my own advice and take stock here.

Below are some of the highlights of the past 6 months. I'll try to lump things together into some general categories.

## People

* Hired two awesome developers. This included:
  * [Building a new automated hiring system using Jira]
  * Introducing a new format of job description.
  * Owning the interview process end to end.

## Infrastructure

* Built a CI/CD pipeline for continuous delivery of CloudFoundry-based applications to SAP BTP Cloud
* Discovered a technical limitation of CloudFoundry and to get ahead of it, re-platformed our applications to Kubernetes (SAP BTP Kyma) in 7 working days. This included
  * Containerizing all of our .NET applications
  * Essentially learning Kubernetes on the fly. I'd poked around the edges a lot, but I had to really get into it.
  * Making BTP cloud services work in a new environment
  * Updating application configuration for zero dev down-time while we transitioned to new platform, configuration, etc.
* Scripted all of our infrastructure via Terraform
* Introduced Akka .NET and the actor model where I saw the need for building a reactive application. This included working with my team to port most of the application code, as well as procuring production support, training, etc.
* Scripted the majority of our customer environments

## Observability

* Deployed Seq into our environment to quickly get a handle on some of our logging insights.
* Deployed OpenTelemetry collector, Prometheus, Grafana, Tempo, and Loki in our environment (fully scripted via Terraform)
* Added business-level metrics to application code to see which clients & carriers are experiencing issues or utilizing our premium services
* Adding activities and spans to improve traceability across our tooling.

## Security

* Introduced 1Password for secure password references and sharing within our organization.

## Developer Experience

* Wired up all of our infrastructure into a docker-compose file locally so devs could run `docker-compose up` and have everything they need.

## Other stuff

* Introducing automated testing and bringing the team on board to a place where we now have hundreds and hundreds of tests running every build

## What's Next?

I feel like I'm doing some of the best work of my career, and I can't wait to see what will happen in the next 6 months. I'm optimistic.
