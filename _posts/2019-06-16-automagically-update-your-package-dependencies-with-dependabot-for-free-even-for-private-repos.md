---
title: >-
  Automagically Update Your Package Dependencies With Dependabot For Free --
  Even for Private Repos!
comments: true
tags:
  - tutorial
  - dependency management
  - devops
  - bots
date: '2019-06-16 16:56 -0400'
---
With the news that [Dependabot has been acquired by GitHub](https://dependabot.com/blog/hello-github/), I thought it was a good time to explain what a phenomenal help I find this tool to be, and how you can get it set up on your own repositories to keep your packages up to date without a sweat.

## Why Keeping Your Dependencies Updated Matters

* **Security issues:** Oftentimes when packages are updated, it's to remediate vulnerabilities. If you update your packages in small chunks all the time, these issues won't become headaches or major concerns.
* **Avoid big sweeping changes**: So many times, projects wait long times before updating their dependencies, which means that when the time comes, things break due to the differences in library APIs or usage. 

## The Hard Part About Keeping Dependencies Updated

But updating packages isn't exactly a breeze. A lot of teams hold off on upgrading dependencies because:

* **It could break things**: Updating all the dependencies could be risky. How do we know that things will still work after the upgrade? 
* **It's hard to know which update is problematic**: When updating all of your dependencies, if things break, you have to spend hours untangling to figure out which dependency change broke things. 
* **It often feels like a huge task**: When dependencies are so out of date, where do you start? You know it's going to be hours of pain, potentially.
* **Things get really out of date quickly**: It seems like as soon as you've finished reconciling all of this, there's another update. Gross!
* **It's boring work that doesn't feel valuable.** 

## Enter Dependabot

[Dependabot](https://dependabot.com) is a tool for keeping your dependencies -- npm packages, nuget packages, ruby gems, etc -- up to date in an incremental fashion. 

## What We'll Cover in This Article

* Setting up Dependabot for a Public GitHub repository
* Setting up Dependabot for a private GitHub Enterprise Repository using Docker
* Hosting a Docker image via Azure Container Instances 

## Setting up Dependabot for a Public GitHub repository

## Setting up Dependabot for a Private Repo with Docker
