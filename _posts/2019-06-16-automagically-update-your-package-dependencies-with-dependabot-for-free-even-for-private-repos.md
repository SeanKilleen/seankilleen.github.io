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

Some things I love about Dependabot:

* **It updates dependencies incrementally**: Rather than in one fell swoop, or upgrading a package to the absolute latest version, Dependabot gets you where you need to go in a steady, incremental way, ensuring that you're less likely to suffer breakages.
* **It does the work for you**: What I _absolutely love_ about Dependabot is that it will actually make the pull request for you, along with information about the update and whether it anticipates breaking changes. So you don't even have to do most of the work.  
* **It provides handy tooling**: Did another PR cause a conflict somehow? Dependabot is smart enough to rebase its changes. 
* **It stores its configuration along with the repo**: You can set it up from Dependabot's interface, but you can also save the configuration in a YAML file right alongside your code.

So, combined with a CI pipeline that executes tests to ensure things work well, Dependabot is part of a balanced coding breakfast -- it allows you to keep things updated with minimal hassle. 

## What We'll Cover in This Article

* Setting up Dependabot for a Public GitHub repository
* Setting up Dependabot for a private GitHub Enterprise Repository using Docker
* Hosting a Docker image via Azure Container Instances 

## Setting up Dependabot for a Public GitHub repository

* Head to [http://dependabot.com to sign up for an account](http://dependabot.com).
* In the [Dependabot app](https://app.dependabot.com), click `Add Repos` from the top menu:

> ![Dependabot menu with a button for adding repos](/images/post-images/01_addrepo.png)

* Grant access to a repository
* Add each language the package uses, with a reference to the configuration file (e.g. to your `gems` file, or your `package.json` file, or your `packages.config` file)
* Set up your preferences for the repository
* ...sit back and wait! Dependabot will now start making pull requests on your behalf.

## An example Dependabot PR

Here's [a recent PR that dependabot opened for my blog's repo](https://github.com/SeanKilleen/seankilleen.github.io/pull/352). It contains some really helpful information:

* Release notes from the update
* A list of commits that were made by the authors as part of the update
* A compatibility score based on all the other projects that Dependabot has made this update for, and whether they worked. 97% compatibility? Nice -- even more confidence!
* A list of commands I can run with Dependabot right within the PR to help me out.

Beautiful! My blog has a CI/CD process via Netlify -- if Netlify can run and generate a preview, that tells me we're probably doing OK. So in the end, I see a PR with notes and tests passing, and a preview of my blog. That helps me feel pretty good about the changes.

## Setting up Dependabot for a Private Repo with Docker
