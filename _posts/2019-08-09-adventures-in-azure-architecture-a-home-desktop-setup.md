---
title: 'Adventures in Azure Architecture: A Home Desktop Setup'
comments: true
tags:
  - azure
  - architecture
  - blueprints
date: '2019-08-09 08:24 -0400'
---
I recently connected with someone on Twitter who had some questions about architecture. I thought the challenge was interesting, so below are the parameters of the challenge and how I went about trying to architect a solution for her (who I'll call "the client" from here on out).

## Background / Goal

The client is moving overseas and cannot take their desktop equipment with them because they'll have no place to store it. They previously used this desktop as a central workhorse -- VPNing into it during travel, etc. -- and are looking to re-create that sort of central place without being tied to the physical presence of desktop hardware.

## The Stated Constraints

* **Fully cloud-based**: my client is looking to have her computing environment primarily based in the cloud
* **Data security is a must**: the client has had backup disasters in the past. Ensuring all of their data isn't going to disappear is paramount.
* **Windows workloads**: the client primarily uses Windows throughout the day.
* **Media**: the client also mentions some audacity music files. 
* **Occasional graphics-intensive workloads**: think Adobe Photoshop & InDesign
* **Azure**: the client is primarily interested in Azure services
* **Budget**: Generally speaking, she'd like to keep this as expensive as new hardware would cost when spread over 3 years, so think $1k/year or $83/mo. 
* **Stretch budget**: client mentioned that if the solution delivered, they could pay up to roughly $200/month, which does give us some wiggle room.

## Extrapolated Requirements

OK, that's a lot of good information to go on. Here's what I'm thinking:

*
