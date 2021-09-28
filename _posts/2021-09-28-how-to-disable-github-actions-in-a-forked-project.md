---
title: How to Disable GitHub Actions in a Forked Project
comments: true
tags:
  - github
  - github actions
  - automation
  - tips
date: 2021-09-28 15:08 -0400
---
Some GitHub repositories have [GitHub Actions](https://github.com/features/actions) with helpful automation. Because actions are stored in the `.github` folder within a codebase, they come over along with any forks that are created. In many cases, this could be really helpful, as you get a great level of automation out of the box.

However, when you fork the project in order to contribute back or for your own purposes, you don't necessarily want those actions to run in _your_ repository (such as attempting to publish releases).

## To Turn Off GitHub Actions for a forked repository

* Open the repository
* Click `Settings`
* In the left-hand navigation menu, click `Actions`

You can then set your preferences to disable actions in the repo, or only allow certain actions.