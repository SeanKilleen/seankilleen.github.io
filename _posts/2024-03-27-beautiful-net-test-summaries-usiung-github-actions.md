---
title: Beautiful .NET Test Summaries usiung GitHub Actions
comments: true
tags:
  - devops
  - ci
  - cd
  - github
  - githubactions
  - azuredevops
  - azdo
date: 2024-03-27 11:01 -0400
---
I know some folks who would like to move to GitHub Actions from Azure DevOps, but would really miss the "Test View" within Azure DevOps. Let's see if we can work some magic with GitHub Actions to get us close.

## Goals

* Show test results within a pull request
* Show difference in number of tests
* When tests fail, be able to quickly see which tests failed, and the failure/trace
* Understand test coverage
