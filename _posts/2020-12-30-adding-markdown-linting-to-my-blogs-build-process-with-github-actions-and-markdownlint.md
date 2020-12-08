---
title: Adding Markdown Linting to my Blog's Build Process with GitHub Actions and markdownlint
comments: true
tags:
  - github
  - github actions
  - linting
  - markdown
  - jekyll
  - github pages
date: 2020-12-30 10:00 -0500
---

## Locally

- Install the markdown lint extension in VS Code
- `npm install markdownlint-cli -g`
- Add a `.markdownrc` file to capture rules

## As part of build

- Create `.github/linting` folder
- Create config file that maps to my local rules
- Create a GitHub Action for pull requests to run super-linter.

## Not Ready Yet? Just disable warnings!

You'll still get a good read on what issues you have.
