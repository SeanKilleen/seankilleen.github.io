---
title: Taking a Moment to Celebrate
comments: true
tags:
  - reflection
  - leadership
  - accomplishments
date: 2024-02-14 10:00 -0500
---
As of today, I've been in my current role as VP of Innovation & Products at SCT Software for 6 months. I think that's a nice chunk of time, and I wanted to take some space to reflect on what I[^1] have been able to accomplish, because I feel like I've been doing some of the best work of my life and I don't want to forget this moment. Since [I advocate for keeping a "Good Stuff" list](https://seankilleen.com/2018/12/you-should-keep-a-good-stuff-list/), I thought I'd share some of mine here.

## Infrastructure

* Established CI/CD pipelines
* Introduced Dependabot and Rennovate bot to keep our Nuget packages, GitHub Actions, containers, Helm charts, and Terraform providers up to date.
* Established Deployment in SAP BTP CloudFoundry infrastructure.
* Moved our entire infrastructure to Kubernetes (SAP BTP Kyma).
* Introduced Terraform and iteratively used it to build our infrastructure, including SAP BTP cloud.
* Snyk security scanning


## Architecture and Code

* Introduced and implemented the actor model via Akka.NET after understanding & validating the need for reactivity in one of our applications.
* Got OAuth 2.0 security working correctly for all of our use cases, including some tweaks I needed to make to the SAP BTP identity configuration.
* 500+ automated tests

## Developer Experience

* Docker-compose local developer systems

## Security and Compliance

* 1Password implementation


## Process

* Immediately began a weekly progress report to leadership
* Established product backlogs for 2 different products, infrastructure, and general Innovation & Products work. This made work visible.
* Introduced and on-boarded the team to GitHub Flow
* Began lean daily stand-ups
* Invented Jira board for managing visibility into our overall workstream, connected to the actual work with automation
* SOP for off-boarding and archiving user accounts, freeing up licenses while maintaining compliance
* INP onboarding checklist
* Jira recruiting board
* Definition of ready/done
* Carrier information wiki pages
* Analysis process


## Leadership & Culture

* [Created & automated a hiring process](TODO: Blog link)
* On-boarded 2 new developers
* Wiki pages
* Teams integrations with activity updates
* Product FAQs for internal use and being able to answer customer questions


## Other Notes

* 1.5x’d an audio book on Kubernetes during my nightly walks and feel relatively confident in the subject matter now.
* Containerized
* Release notes
* At one point today I was remoted into a container running Debian Linux, deployed in a Kubernetes pod, updating the OS to install curl so that I could make localhost http calls and then check the logs
* Tooling to handle encrypting/decrypting from/to SAP BTP credential store
* In roughly 7-8 working days (albeit longer days 😆), we re-platformed our BTP apps from CloudFoundry into Kyma, all scripted via Terraform and thus repeatable for future environments.
* Began capturing detailed financials to pinpoint product-related costs
* Introduced metrics
* Akka .NET Cluster
* Seq for quick logging visibility
* Prometheus / OTel / Grafana / Tempo
* Carrier plugin system using Scrutor
* Facilitated the end of the year process improvement meeting
* Actor model took 224 commits on a PR but didn't disrupt anyone's work
* Reporting on items completed in past 7 days
* Surfaced PowerAutomate as a way of automating some of our more complex interactions with the SAP GUI
* Upgraded to .NET 8 on the day of its launch
* Redis for Caching
* S3-compliant in-k8s storage
* Cached Geocoding
* Wiki page for terms
* Automated benchmark test for allocations on a hot path.
* Health Checks for our services and dependencies
* onboarding wiki to help with orientation and checklists for things to do
* Custom metrics
* Onboarding e-mails with what to expect on the first day etc.



[^1]: Obviously, nobody does these things alone, but I like to capture where I've had a major hand, and it's easier as a convention to say "I".
