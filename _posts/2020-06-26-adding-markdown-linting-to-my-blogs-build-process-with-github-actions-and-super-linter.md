---
title: Adding markdown linting to my blog's build process with GitHub Actions
  and super-linter
comments: true
tags:
  - github
  - github actions
  - linting
  - markdown
  - jekyll
  - github pages
date: 2020-06-26 09:55 -0400
---
## Locally

* Install the markdown lint extension in VS Code
* `npm install markdownlint-cli -g`
* Add a `.markdownrc` file to capture rules

## As part of build

* Create `.github/linting` folder
* Create config file that maps to my local rules
* Create a GitHub Action for pull requests to run super-linter.

## Not Ready Yet? Just disable warnings!

You'll still get a good read on what issues you have.