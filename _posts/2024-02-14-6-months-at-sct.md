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

NONE of these things happen without an awesome team and environment, but I'll list things I had at least a large part in.

## People

* Hired two awesome developers. This included:
  * [Building a new automated hiring system using Jira]({% 2024-01-23-how-i-created-an-automated-and-humane-hiring-process-using-jira %}).
  * Introducing an intentionally different format of job description.
  * Sourcing candidates from my network with no recruiting assistance.
  * Owning the interview & hiring process from first contact to offer acceptance.

## Process & Communication

* Introduced Kanban boards to make work visible
* Introduced daily stand-ups (Our team of 11 still manages it in under 20 minutes!)
* Created / shaped the overall process flow of our work
* Created & automated a high level Kanban board allowing stakeholders to see big picture and drill down as desired
* Created places to radiate information -- Product FAQs, a company-wide shared glossary
* Created a standard for documenting certain kinds of information and a repository for that information to live, which is now part of the standard of how we operate.
* Got the team used to working out loud. Pull requests, reviews, pairing/mobbing, and more.

## Infrastructure

* Built a CI/CD pipeline for continuous delivery of CloudFoundry-based applications to SAP BTP Cloud
* Discovered a technical limitation of CloudFoundry and to get ahead of it, re-platformed our applications to Kubernetes (SAP BTP Kyma) in 5 working days. This included
  * Containerizing all of our .NET applications
  * Essentially learning Kubernetes on the fly. I'd poked around the edges a lot, but I had to really get into it.
  * Making BTP cloud services work in a new environment
  * Updating application configuration for zero dev down-time while we transitioned to new platform, configuration, etc.
* Scripted all of our infrastructure via Terraform
* Introduced Akka .NET and the actor model where I saw the need for building a reactive application. This included working with my team to port most of the application code, as well as procuring production support, training, etc.
* Scripted the majority of our customer environments
* Introduced caching via Redis and S3-compatible storage via MinIO to allow us to bring these capabilities within our Kubernetes cluster.
* Added geocoding capabilities to our application -- vendor selection, API implementation, caching for effectiveness.
* Successfully introduced OAuth 2.0 authentication, integrating with SAP BTP's CIS product.

## Observability

* Deployed Seq into our environment to quickly get a handle on some of our logging insights.
* Deployed OpenTelemetry collector, Prometheus, Grafana, Tempo, and Loki in our environment (fully scripted via Terraform)
* Added business-level metrics to application code to see which clients & carriers are experiencing issues or utilizing our premium services
* Adding activities and spans to improve traceability across our tooling.

## Security & Compliance

* Introduced 1Password for secure password references and sharing within our organization.
* Became a key figure in responding to client concerns and questions around security & compliance, and working to systematize that process.
* Automated security scanning within our CI/CD pipeline.

## Developer Experience

* Wired up all of our infrastructure into a docker-compose file locally so devs could run `docker-compose up` and have everything they need.

## Other stuff

* Introducing automated testing and bringing the team on board to a place where we now have hundreds and hundreds of tests running every build
* Diagnosed a complex issue that ended up pinpointing a bug in the Envoy proxy (used by Istio). Ended up going to the HTTP/2 spec to figure it out.
* Facilitated an end-of-year half-day session on continuous improvement.

## What's Next?

I feel like I'm doing some of the best work of my career, and I can't wait to see what will happen in the next 6 months. There are plenty of ways for me to grow and learn still, and plenty left to achieve. I'm excited.
