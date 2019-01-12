---
title: "Sharing my reading list in real-time with Feedly and Azure Functions"

date: 2019-01-11 14:00:00:00.000000000 -05:00

comments: false
---

I've been a fan of RSS feeds for a long time. I love curating a collection of knowledge that streams to me at my pace, and I consider feeds to be a fundamental piece of how I keep up with technology and stay fresh. I currently use [Feedly](http://feedly.com) and have been a happy pro user for years.

But something is missing. As much as I like reading, I also like sharing.

## The Requirements

I think the requirements for this mini-project will be:

* **Only show my development-related feeds**. I've got a ton of RSS feeds, and as much as I'm sure everyone would like to see my politics :wink:, we'll want to filter the RSS feeds list to only those that would be relevant to developers.
* **Can continuously run with minimal intervention**. I need this system to be pretty low maintenance. It can't be held together with duct tape.
* **Cost-effective.** I don't want to spend a ton of money on this.

Luckily, with the benefits of Azure functions and APIs, I think we can make this work in a cost-effective way.

## The Ingredients

My solution is going to make use of:

* **The Feedly API.** Feedly is kind enough to provide a developer API for access to your feeds (I think even for non-pro users?). This is what will give us access to our feeds.
* **Azure Functions** is a perfect fit for this. A small, light-weight, cost-effective, easily-deployable solution to interact with APIs. We'll use functions to keep the Feedly auth token up to date (it needs to be refreshed), and to filter the OPML feed file to to the contents that we want.
* **Azure KeyVault**. Since we're dealing with authorization tokens, I'm not just going to be dumping them any old place, even though it would probably be pretty fast to dump them plain-text into a private Azure storage blob. Safety first!

## Getting Started

* Set up a functions account
* Get a Feedly API key

## Setting up a function to refresh the auth key

## Setting up a function to extract the OPML

## Getting the OPML file into my blog as a link
