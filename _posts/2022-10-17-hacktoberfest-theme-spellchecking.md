---
title: "My #hacktoberfest Theme: Adding Spellcheck to Docs. Join Me!"
comments: true
tags:
  - spellcheck
  - github actions
  - cspell
  - oss
  - hacktoberfest
date: 2022-10-17 11:33 -0400
excerpt: "Systematizing OSS contributions, and steps for you to jump in."
header:
 overlay_image: /images/overlays/unsplash/chris-lawton-5IHz5WhosQE-unsplash.jpg
 overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
 caption: "Photo credit: [**Chris Lawton @ Unsplash**](https://unsplash.com/@chrislawton?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
---

I love [Hacktoberfest](https://hacktoberfest.com) each fall -- a time when I try to consciously contribute back a little bit to the OSS world that's given us all so much.

This year I was thinking about how to approach Hacktoberfest a little differently than I've done in years past. Below is my experience; maybe it will unlock something for you, too!

## My Personal Criteria for This Year's Hacktoberfest Contributions

I wanted my Hacktoberfest contributions to be:

* Not a huge lift. I have limited time right now to contribute back.
* Not a drive-by or "tiny" change. Just feels like I can do a little better than that for targeted contributions (and I do those regularly whenever I see them.)
* Fairly "rote", because in downtime I find small repeatable tasks to be a nice way to relax.
* Something that I could write up so that others could take and run with
* Something that could apply to big and small projects alike, as well as both popular and obscure projects.

## ...And a Background Thought

I've been thinking for a long time about how we could benefit from more "mutual aid" within OSS, and about marketplaces of needs. If we can systematize certain kinds of improvements, we can help teach others how to make those improvements, and we can help projects who would benefit from those improvements. Sounds like a true win-win for me, and I'd love to see a hub spring up to offer this sort of mutual aid. (and may just create one myself.)

## This Year's Choice: Spellchecking!

It seems small, but lots of development projects have docs. Many of those docs have spelling errors. And in my experience, lots of maintainers welcome the occasional spelling correction, and likely appreciate preventing errors going forward.

## How You can Add Spellcheck for OSS Docs

I did the following to make it happen:

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
* `patterns` defines regex patterns that we want to be able to ignore, which we then place in `ignoreRegExpList`.
  * :information_source: This is actually something I learned during the creation of my pull requests this year! Before that, I was using comments, which was messy since JSON isn't really supposed to have them.
* `ignorePaths` is for excluding files or globs from the cSpell check.

### Create a "Work in Progress" Pull Request

I believe in creating pull requests as early as possible so that I can use them as a running journal of small commits and thoughts that I leave in the form of comments on the pull request. This serves a few functions:

* If someone isn't interested in my contribution, they can tell me and save us both a bunch of time.
* If someone has questions, they can ask them along the way.
* They can see individual commits and what my reasoning is behind a change.

### Running cSpell

Next, I:

* Installed node 16 (I use nvm, so it was `nvm install 16.x` and then `nvm use [version I installed]`).
* Installed cSpell globally (`npm i -g cSpell`)
* Ran the same cSpell command locally that I'd set up GitHub Actions to do, e.g. `cspell --config ./cSpell.json "content/**/*.md" --no-progress`
  * The `--no-progress` cuts down on noise a lot when you're just looking for errors, since it doesn't output every file name.

### The Fun Part: Addressing Findings!

Look over the cSpell results. If you're using VS Code, you can click on a finding and it'll take you right there in the editor.

cSpell findings typically fell into a few categories:

* Actual spelling errors. These can be fixed as a one-off or done via find & replace across files in the case of a common misspelling.
* "Standardizations", e.g. `colour` in the British spelling vs `color` in U.S. English. In these cases, I typically note them and ask whether the author would like me to revert them. I use cSpell's defaults in my default approach, which uses U.S. English.
* Terms that may not be intended as words but as other terms, e.g. a variable name. I solve this by trying to format them according to their doc system's preference, which is often to place back-ticks around the term.
* Whole files that might be excluded, e.g. large release notes files where the text is copied from issues and might be misspelled. Or markdown pages that mostly contain HTML.
* Code snippets that aren't highlighted as such. I use the appropriate markdown to add code fences when I come across these.
* Something cSpell shouldn't have picked up on but did because a regex ignore pattern was missing. I try to fix that when it happens and add the pattern.
* Words we want to add to the dictionary. These might be domain-specific words that authors use, or other common words that don't happen to be in cSpell's dictionary. cSpell's VS Code integration gives you the lovely ability to hit `CTRL + .` to bring up a spell-check menu that you can use to add the word to the `cSpell.json` file you've created.
* Words we want to ignore; they're not correct, but we don't want them to be suggested. Typically names fall into this category, though I'll often put the author's names into the "words we want to add" category.
  * :information_source: cSpell's VS Code integration doesn't have a way to add words to the ignore list, so I usually so a pass on the `words` list in `cSpell.json` after and separate them out myself.

### The Important Last Part: Adapting to Feedback

Spelling and word choice is a personal thing. I take the position that as long as the maintainers are making a choice consciously and consistently, it isn't "wrong'. And any spell-check systems should adapt to that. Any push-back I have on maintainer preferences is minimal. It's not about correcting someone; it's about being helpful.

* I do a self-review on my PR on GitHub
* I call attention to things that the maintainers may want to weigh in about
* I explicitly ask for feedback and adapt to it.

## Where did I contribute these changes?

You can see the contributions, as well as some of the questions and feedback I received along the way and those repositories where it wasn't a good fit.

* [`ChilliCream/hotchocolate`](https://github.com/ChilliCream/hotchocolate/pull/5461)
* [`prisma/docs`](https://github.com/prisma/docs/pull/3859)
* [`avaoloniaui/Documentation`](https://github.com/AvaloniaUI/Documentation/pull/348)
* [`dotnet/benchmarkdotnet`](https://github.com/dotnet/BenchmarkDotNet/pull/2144)
* [:x: `n8n-io/n8n-docs`](https://github.com/n8n-io/n8n-docs/pull/980)
* [:x: `puppeteer/puppeteer`](https://github.com/puppeteer/puppeteer/pull/9083)
* [`mermaid-js/mermaid`](https://github.com/mermaid-js/mermaid/pull/3600)
* [`microsoft/playwright`](https://github.com/microsoft/playwright/pull/17919)
* [`unoplatform/uno`](https://github.com/unoplatform/uno/pull/10080)
* [`abpframework/abp`](https://github.com/abpframework/abp/pull/14374)
* [`dotnet/maui`](https://github.com/dotnet/maui/pull/10774)
* [`dotnet/benchmarkdotnet`](https://github.com/dotnet/BenchmarkDotNet/pull/2144)

## The Next Part is Up To You!

Looking for something to complete your #hacktoberfest challenge while feeling good about it? Want to make a difference in the docs of a large project?

Try this approach and let me know how you do! I'm also happy to get you un-stuck; tag me into any PR where you're hitting an issue on this. Show us your progress in the comments!
