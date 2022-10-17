---
title: "Theming my #hactkoberfest 2022 contributions -- and how you can, too!"
comments: true
tags:
  - spellcheck
  - github actions
  - cspell
  - oss
date: 2022-10-17 11:33 -0400
excerpt: "Systematizing OSS contributions and steps for you to jump in."
#header:
# overlay_image: /images/overlays/unsplash/pawel-czerwinski-2dyR13FNg2I-unsplash.jpg
# overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
# caption: "Photo credit: [**Pawel Czerwinski @ Unsplash**](https://unsplash.com/@pawel_czerwinski?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
---

## Personal Criteria for This Year's Hacktoberfest Contributions

I wanted my Hacktoberfest contribution to:

* Not be huge lifts. I have limited time.
* Not be a drive-by or "tiny" change. Just feels like I can do a little better than that for targeted contributions.
* Be fairly "rote", because in downtime I find small repeatable tasks to be a nice way to relax.
* Be something that I could write up so that others could take and run with
* Apply to big and small projects alike, as well as both popular and obscure projects.

## ...And a Background Thought

I've been thinking for a long time about how we could benefit from more mutual aid within OSS. If we can systematize certain kinds of improvements, we can help teach others how to make those improvements, and we can help projects who would benefit from those improvements. Sounds like a true win-win for me, and I'd love to see a hub spring up to offer this sort of mutual aid. (and may just create one myself.)

## What I Chose: Spell-checking!

It seems small, but lots of development projects have docs. Many of those docs have spelling errors. And in my experience, lots of maintainers welcome the occasional spelling correction.

## How I Added Spell-checking to Projects (and how you can too)

### Adding a GitHub Actions Workflow and Empty cSpell Configuration file

First up, I add a file in `.github/workflows/spellcheck.yml` or similar, and tweak it for the main branch that the project is using:

```yaml
name: Documentation Checks

on:
  push:
    branches:
      - master #or main if that's what the project is using
    paths:
        # This ensures the check will only be run when something changes in the docs content
      - "content/**/*" # or whatever the path to the markdown / docs files happens to be
  pull_request:
    branches:
      - master 
    paths:
      - "content/**/*"
jobs:
  spellcheck:
    name: "Docs: Spellcheck"
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        name: Check out the code
      - uses: actions/setup-node@v1
        name: Setup node
        with:
          node-version: "16"
      - run: npm install -g cspell
        name: Install cSpell
      - run: cspell --config ./cSpell.json "content/**/*.md" --no-progress # Update for path to the markdown files
        name: Run cSpell
```

And then an template `cSpell.json` file in the root of the project or its docs:

```json
{
  "version": "0.2",
  "language": "en",
  "words": [
  ],
  "ignoreWords": [
  ],
  "patterns": [
    {
      "name": "Markdown links",
      "pattern": "\\((.*)\\)",
      "description": ""
    },
    {
      "name": "Markdown code blocks",
      "pattern": "/^(\\s*`{3,}).*[\\s\\S]*?^\\1/gmx",
      "description": "Taken from the cSpell example at https://cspell.org/configuration/patterns/#verbose-regular-expressions"
    },
    {
      "name": "Inline code blocks",
      "pattern": "\\`([^\\`\\r\\n]+?)\\`",
      "description": "https://stackoverflow.com/questions/41274241/how-to-capture-inline-markdown-code-but-not-a-markdown-code-fence-with-regex"
    },
    {
      "name": "Link contents",
      "pattern": "\\<a(.*)\\>",
      "description": ""
    },
    {
      "name": "Snippet references",
      "pattern": "-- snippet:(.*)",
      "description": ""
    },
    {
      "name": "Snippet references 2",
      "pattern": "\\<\\[sample:(.*)",
      "description": "another kind of snippet reference"
    },
    {
      "name": "Multi-line code blocks",
      "pattern": "/^\\s*```[\\s\\S]*?^\\s*```/gm"
    },
    {
      "name": "HTML Tags",
      "pattern": "<[^>]*>",
      "description": "Reference: https://stackoverflow.com/questions/11229831/regular-expression-to-remove-html-tags-from-a-string"
    }
  ],
  "ignoreRegExpList": [
    "Markdown links",
    "Markdown code blocks",
    "Inline code blocks",
    "Link contents",
    "Snippet references",
    "Snippet references 2",
    "Multi-line code blocks",
    "HTML Tags"
  ],
  "ignorePaths": []
}
```

A quick break-down on this:

* `words` represents valid words that we want spell-check to suggest
* `ignoreWords` represents words we don't want to show up as spelling errors, but that we also don't want tooling to suggest as valid replacements.
* `patterns` defines regex patterns that we want to show up

## Where did I contribute these changes?

You can see the contributions, as well as some of the questions and feedback I received along the way, and those repositories that did not find it helpful.

* [`prisma/docs`](https://github.com/prisma/docs/pull/3859)
* [`avaoloniaui/Documentation`](https://github.com/AvaloniaUI/Documentation/pull/348)
* [`dotnet/benchmarkdotnet`](https://github.com/dotnet/BenchmarkDotNet/pull/2144)
* [`n8n-io/n8n-docs` (rejected)](https://github.com/n8n-io/n8n-docs/pull/980)
* [`puppeteer/puppeteer`](https://github.com/puppeteer/puppeteer/pull/9083)
* [`mermaid-js/mermaid`](https://github.com/mermaid-js/mermaid/pull/3600)
* [`microsoft/playwright`](https://github.com/microsoft/playwright/pull/17919)
* [`unoplatform/uno`](https://github.com/unoplatform/uno/pull/10080)
