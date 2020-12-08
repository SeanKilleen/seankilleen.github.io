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

I'll confess, reader. My markdown formatting was messy. I decided to fix it and automate it.

The solution involves:

- The great [markdownlint](https://github.com/DavidAnson/markdownlint) tool
- A VS Code Extension that gives me linting within the IDE
- A rules file to allow for some exceptions in cases where I truly need them
- A GitHub Action to run as part of my pull requests, to keep me honest.

## Installing the Markdownlint Extension

In the extensions window, search for `markdownlint` and install it (extension ID: `davidanson.vscode-markdownlint`)

## Create a Rules File

- Add a `.markdownrc` file to the root of your repository to capture rules. You can turn off various rules as things fail if you need to. My example rules file [can be found here](https://github.com/SeanKilleen/seankilleen.github.io/blob/main/.markdownlintrc)

## As part of build

- Create `.github/linting` folder
- Create config file that maps to my local rules
- Create a GitHub Action for pull requests to run super-linter.

## Not Ready Yet? Just disable warnings!

You'll still get a good read on what issues you have.
