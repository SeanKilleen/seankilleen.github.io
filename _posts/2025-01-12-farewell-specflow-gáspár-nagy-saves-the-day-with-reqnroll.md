---
title: Farewell, SpecFlow. Gáspár Nagy Saves the Day with Reqnroll!
comments: true
date: 2025-01-12 09:34 -0500
---
This is a quick appreciation post.

I became enamored with the idea of [gherkin-based](https://cucumber.io/docs/gherkin/reference) testing and writing human-readable examples that translated to code a long time ago. I think it was the excellent book on [Specification by Example](https://www.manning.com/books/specification-by-example) that first got me really thinking about it.

One of the biggest successes in my career came from using this technique. We were running a retirement benefit system with a ton of complex calculations where the stakes were high. We had to make some major changes, and even though there were automated tests, those weren't understandable (understandably!) to the actuarials and business professionals who were responsible for the requirements. They wanted 9 months to test the changes, because the stakes were that high. Instead, we were able to work toward a ubiquitous language for describing the actions that this calculation logic took. Once those were in place, we published the specs that we had applied, and invited the business folks to come up with as many exhaustive examples as they could. We were able to easily incorporate new examples. In the end, we made changes with a high degree of shared confidence and saved the entirety of that designated testing time.

The de facto tool for accomplishing this in .NET for a long time was SpecFlow.

## SpecFlow: A Tragic OSS tale

(_Ed. Note:_ to be clear, this is from an outside observer's perspective.)

SpecFlow was a labor of love for a few key contributors and a vibrant community surrounding them. They had a phenomenal OSS product, and commercial offerings and tooling built around that OSS.

Then, they were acquired by Tricentis, a company that provides test automation products. At the time, I very much considered this A Good Thing™️. The authors deserved a payday, and Tricentis promised to keep things open-source and moving along.

Tricentis then basically slapped the community in the face. Contributions and forward motion stopped and it was impossible to get a read on the state of the project. Then, not only did Tricentis announce a very small window of time to shut down the project, but it deleted the SpecFlow repository from GitHub. It could have chosen to open up all the tooling and archive it, but instead it did the selfish business thing that helped nobody. (Do you hear that sound? It's me crossing Tricentis off from the vendors I'll ever consider working with).

So, in a tale as old as time, an OSS project that seemed to have a great path to commercialization was instead rotted by corporate interests.

