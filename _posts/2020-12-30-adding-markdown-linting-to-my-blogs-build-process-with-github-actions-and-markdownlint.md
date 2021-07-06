---
title: Adding Markdown Linting to my Blog's Build Process with GitHub Actions and markdownlint

tags:
  - github
  - github actions
  - linting
  - markdown
  - jekyll
  - github pages
date: 2020-12-30 10:00 -0500
---

I'll confess, reader. My markdown formatting was messy. I don't like messy, so I decided to fix it and automate it.

The solution involves:

- The great [markdownlint](https://github.com/DavidAnson/markdownlint) tool
- A VS Code Extension that gives me linting within the IDE
- A rules file to allow for some exceptions in cases where I truly need them
- A GitHub Action to run as part of my pull requests, to keep me honest.

## Installing the Markdownlint Extension

In the extensions window, search for `markdownlint` and install it (extension ID: `davidanson.vscode-markdownlint`)

Now, you'll start getting feedback on what needs fixing when you have a file open. It's really helpful.

## Create a Rules File

- Add a `.markdownrc` file to the root of your repository to capture rules. You can turn off various rules as things fail if you need to. My example rules file [can be found here](https://github.com/SeanKilleen/seankilleen.github.io/blob/main/.markdownlintrc)

## Run As Part of a Build

We'll utilize GitHub actions for this.

- Create a GitHub Action workflow by creating a file in your repo at `.github/workflows/linting.yml` (`.github` is a folder in this case.)

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
  linting:
    name: "Markdown linting"
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        name: Check out the code
      - name: Lint Code Base
        uses: docker://avtodev/markdown-lint:v1
        with:
          args: "**/*.md"
```

What's is this GitHub Action file doing?

- It runs on any main branch commit or any PR against my main branch
- It runs the GitHub action on an Ubuntu instance
- It checks out all my code for the blog, which includes all the markdown files
- It pulls a Docker container that is published to Docker Hub, which has been set up by someone else to run markdownlint (thanks, people who care about OSS!)
- It passes in the argument to the container of which files to run within Markdown lint
- When it runs, it automatically sees and respects the `.markdownlintrc` rules file, keeping it consistent with my local environment.

Once I committed this file to a PR, I saw the linting begin.

## Wash, Rinse, Repeat

The first time I enabled this with a PR, I got a lot of failures, as one might expect. I kept making small commits over time and eventually I got there.

## Voila!

Now, I get local linting support within VS Code and build time support via GitHub Actions. For free! [^1].

Happy linting!

[^1]: By free, I mean thanks to someone else's very hard work that they are often under-compensated and under-supported for. Go look into contributing to open source projects, or consider donating to an author or group that has enabled you to work better.
