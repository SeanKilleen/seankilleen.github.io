---
title: >-
  Building an Azure Functions Application to Share Author LinkedIn Posts via
  IFTTT
comments: true
tags:
  - azure
  - functions
  - serverless
  - linkedin
  - integration
date: '2019-06-04 08:39 -0400'
---
## Background / Challenge

I write blog posts sometimes, right here. I use if-this-then-that (IFTTT) to share these posts on twitter automatically. IFTTT used to do the same thing with LinkedIn, but then someone decided that didn't matter so much and now it's gone.

I'd like to recreate it. IFTTT can hit a URL, and LinkedIn has an API. Let's cook something up!

## What We're Building

We're going to build an open-source Azure Function application -- that you can deploy for your own use -- to set LinkedIn updates on your behalf.

## First up: Registering an Application

OK, LinkedIn makes you jump through some hoops here. You'll need to add a company to LinkedIn, and then you'll need to register an app for that company. Unfortunately you can't register them to an individual. So that's...a bummer. But for the sake of this example, we'll do it.

* Head to the LinkedIn developers page at <https://www.linkedin.com/developers/apps>. 
* Click the `Create App` button
