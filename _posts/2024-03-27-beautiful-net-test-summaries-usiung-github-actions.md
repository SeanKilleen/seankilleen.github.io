---
title: Beautiful .NET Test Summaries Using GitHub Actions
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
I know some folks who would like to move to GitHub Actions from Azure DevOps, but would really miss the "Test View" that Azure DevOps provides. Let's see if we can work some magic with GitHub Actions to get us close to that within GitHub.

## Goals

* Work entirely within GitHub Actions
* Show test results within a pull request
* Show difference in number of tests
* When tests fail, be able to quickly see which tests failed, and the failure/trace
* Understand test coverage

## Sample Project

I've created [a sample project that uses these techniques](https://github.com/SeanKilleen/ExampleTestResultsWithGithubActions) at <https://github.com/SeanKilleen/ExampleTestResultsWithGithubActions>. Feel free to submit a pull request to see it in action!

## Project Structure

For the sample, I created a basic project structure that you might find in the wild:

```console
ExampleTestResultsWithGithubActions.sln
src
  /Project1
  /Project2
test
  /Project1.Tests
  /Project2.Tests
```

