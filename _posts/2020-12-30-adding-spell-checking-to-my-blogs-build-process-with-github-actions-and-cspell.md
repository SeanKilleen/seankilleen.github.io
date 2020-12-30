---
title: Adding Spell Checking to my Blog's Build Process with GitHub Actions and cSpell
comments: true
tags:
  - github
  - github actions
  - spellcheck
  - cspell
  - markdown
  - jekyll
  - github pages
date: 2020-12-29 22:33 -0500
---
I'm always worried I'll have a typo in my blog posts, and I suspected I had a few lying around in these pages. I don't like that, so I decided to fix it and automate it.

The solution involves:

- The great [cSpell](https://github.com/streetsidesoftware/cspell) tool
- A VS Code Extension, `Code Spell Checker` that gives me cSpell-based checking within the IDE
- A rules file to allow for ignoring some words/patterns or adding words to a dictionary
- A GitHub Action to run as part of my pull requests

## Installing the Code Spell Checker Extension

In the extensions window, search for `Code Spell Checker` and install it (extension ID: `streetsidesoftware.code-spell-checker`)

Now, you'll start getting feedback on what needs fixing when you have a file open. It's really helpful.

## Create a Rules File

- Add a `cSpell.json` file to the root of your repository to capture words to add to the dictionary. My example cSpell file [can be found here](https://github.com/SeanKilleen/seankilleen.github.io/blob/main/cSpell.json)

## Run As Part of a Build

We'll utilize GitHub actions for this.

- Create a GitHub Action workflow by creating a file in your repo at `.github/workflows/housekeeping.yml` (`.github` is a folder in this case.)

Add the following, changing the values as they suit you:

```yaml
name: Housekeeping

on:
  push:
    branches:
      - main # Modify if you use a different main branch name, such as the legacy "master" name.
  pull_request:
    branches:
      - main # Modify if you use a different main branch name, such as the legacy "master" name.

jobs:
  spellchecking:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        name: Check out the code
      - uses: actions/setup-node@v1
        name: Run spell check
        with:
          node-version: "12"
      - run: npm install -g cspell
      - run: cspell --config ./cSpell.json "**/*.md"
```

What's is this GitHub Action file doing?

- It runs on any main branch commit or any PR against my main branch
- It runs the GitHub action on an Ubuntu instance
- It checks out all my code for the blog, which includes all the markdown files
- It pulls a Docker container that is published to Docker Hub, which has been set up by someone else to set up Node (thanks, people who care about OSS!)
- It runs a command to install cSpell globally within the container
- It runs cSpell in the container on all my markdown files, using my config file. When it finds an error, it returns a non-zero exit code, which fails the build.

Once I committed this file to a PR, I saw the checking begin.

## Wash, Rinse, Repeat

The first time I enabled this with a PR, I got a lot of failures, as one might expect. I kept making small commits over time and eventually I got there. I ran `cspell --config ./cSpell.json "**/*.md"` from my terminal as I went and kept making changes until the issues dropped to zero.

## Voila!

Now, I get local spell-check support within VS Code and build time support via GitHub Actions. For free! [^1].

Happy spelling!

[^1]: By free, I mean thanks to someone else's very hard work that they are often under-compensated and under-supported for. Go look into contributing to open source projects, or consider donating to an author or group that has enabled you to work better.
