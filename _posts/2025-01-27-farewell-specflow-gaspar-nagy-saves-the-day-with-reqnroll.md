---
title: Farewell, SpecFlow. Gáspár Nagy Saves the Day with Reqnroll!
comments: true
tags:
  - OSS
  - SpecFlow
  - .net
  - dotnet
  - testing
  - community
date: 2025-01-27 09:00 -0500
# cSpell:words Tricentis,Gáspár,Reqnroll
---
This is a quick appreciation post.

I became enamored with the idea of [gherkin-based](https://cucumber.io/docs/gherkin/reference) testing and writing human-readable examples that translated to code a long time ago. I think it was the excellent book on [Specification by Example](https://www.manning.com/books/specification-by-example) that first got me really thinking about it.

One of the bigger successes in my career came from using this technique. We were running a retirement benefit system with a ton of complex calculations where the stakes were high. We had to make some major changes, and even though there were automated tests, those weren't understandable (understandably!) to the business professionals who were responsible for the outcome. They wanted 9 months to test the changes, to ensure there would be no issues. Instead, we were able to work toward a ubiquitous language for describing the actions that this calculation logic took. Once those were in place, we published the specs that we had created, and invited the business folks to come up with as many exhaustive examples as they could. We were able to easily incorporate new examples. In the end, we made changes with a high degree of shared confidence and saved the entirety of that designated testing time. I was hooked.

The de facto tool for accomplishing this in .NET for a long time was [SpecFlow](https://specflow.org/). It was easy to use, had great tooling, great docs, and a really helpful team.

## SpecFlow: A Tragic OSS tale

(_Ed. Note:_ to be clear, this is from an outside observer's perspective.)

SpecFlow was a labor of love for a few key contributors and a vibrant community surrounding them. They had a phenomenal OSS product, and commercial offerings and tooling built around that OSS.

Then, they were acquired by Tricentis, a company that provides test automation products. At the time, I very much considered this A Good Thing™️. The authors deserved any kind of payday, and Tricentis promised to keep things open-source and moving along.

Tricentis then basically, over a long time, slapped the community in the face. Contributions and forward motion stopped and it was impossible to get a read on the state of the project. Then, not only did Tricentis announce a very small window of time to shut down the project, but it deleted the SpecFlow repository from GitHub. It could have chosen to open up all the tooling and archive it, but instead it did the selfish business thing that helped nobody. (Do you hear that sound? It's me crossing Tricentis off from the vendors I'll ever consider working with).

So, in a tale as old as time, an OSS project that seemed to have a great path to commercialization was instead rotted by corporate interests.

## Enter Gáspár Nagy and Reqnroll

[Gáspár Nagy](https://gasparnagy.com/) was one of the prior creators of SpecFlow. He saw the stagnation in the repository and the writing on the wall a year in advance. Rather than writing it off or waiting, he got to work on behalf of the community. He created [Reqnroll](https://reqnroll.net/) to fill the gap, and it does so very well.

It is _amazing_ how easy it was for me to switch my current org's codebase from SpecFlow to Reqnroll -- a lot of care was taken for users to achieve that. The whole thing took me around 20 minutes.

## With Great OSS Comes Great Responsibility

I didn't notice what was happening with SpecFlow because I was in "consumer mode" with it. I'd become complacent and took the tool for granted. I had stopped checking in on the GitHub repo. I wasn't following the creators online as closely as I should have. So I didn't see what was happening and couldn't contribute. This was less than ideal from both and community perspective and even a supply chain perspective for my organization.

I'm trying to fix that this go-round. I'm following the creators, I'm subscribed to the repo, I'm meandering my way through a PR, and I'm trying to pay attention to where help is needed. I'm also looking to create some donation infrastructure in my current organization.

## In Closing: Gratitude

I am grateful to SpecFlow for the time was here and what it enabled me and others to accomplish for so long.

I am beyond grateful to Gáspár for saving this important tooling for the community and building a bridge while many of us hadn't even realized the last one was burning.

And I am grateful for the reminder, once again, that if we want OSS community, we have to build it and sustain it.
