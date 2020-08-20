---
title: Adding CI/CD for a Python Django Webapp and Heroku -- with Azure DevOps
comments: true
tags:
  - azure
  - devops
  - azure devops
  - ci
  - cd
  - python
  - django
  - heroku
date: 2020-08-20 17:46 -0400
---
Recently, a colleague wanted some assistance getting some CI/CD in place for a project. We decided to build the pipeline in Azure DevOps; this catalogs how we did it.

## Why Azure DevOps?

* Initially, we considered GitHub actions, but our organization is on a grandfathered GitHub corporate plan and they are withholding GitHub Actions from it (in a bid to change our minds, I suppose.) So -- GitHub actions are out for now.
* I have familiarity with Azure DevOps
* I'm pretty sure for what we're looking to do, we could make great use of this tool for the excellent cost of "free". 

## Prepping to set thing sup

We need a Heroku access token in order to be able to push. 

From the CLI: `heroku authorizations:create --description="azure cd token" --short`
From the UI: TODO

## Your Feedback is Welcome!

Did I make a bone-headed mistake during this process or miss a possibility? I'd love to hear about it.