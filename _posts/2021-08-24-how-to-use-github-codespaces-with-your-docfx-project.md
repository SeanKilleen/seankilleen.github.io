---
title: How to Use GitHub Codespaces With Your docfx Project
comments: true
tags:
  - docfx
  - github
  - codespaces
  - docs
date: 2021-08-23 20:37 -0400
---
A little over a year ago, we [re-launched the NUnit docs site](https://seankilleen.com/2020/07/announcement-i-am-now-the-lead-for-the-nunit-docs-project/) using the [docfx project](https://dotnet.github.io/docfx/). Since then, we've built out the workflow a bit -- adding spell-checking, markdown linting, etc. to allow us to consistently create better content.

But I wanted to take it to the next level. I wanted anyone to be able to spin up the docs in GitHub codespaces and have a fully working environment that did what needed to be done. 

So, dear reader, that's what we did. Below is how we made it happen.

## First Up: A Container

GitHub Codespaces allows us to work within a containerized environment so that we can script everything we need and boot right into it. This means that we can add a `Dockerfile` to our repository in the right place and Codespaces will pick up on it.

Previously, we set up our build process to use [our own `docfx-action` GitHub Action](https://github.com/nunit/docfx-action) -- lovingly forked from Niklas Mollenhauer ([@nikeee on GitHub](https://github.com/nikeee/docfx-action)). Part of this GitHub action is a `Dockerfile` that defines a container. We published our own take on it at Dockerhub at <https://hub.docker.com/r/nunitdocs/docfx-action>. 

This highlights what I believe are two great things:

* Because of the awesomeness of OSS, we were able to build upon someone else's work, and the community is better for it.
* Because of the awesomeness of containers, we can re-use this entire environment for our GitHub Codespace as well.

How is the container built? Working backward, the chain is:

* `nunitdocs/docfx-action`
* ...is built upon the `mono` container
* ...which is built upon Debian `buster-slim` Linux

## Setting Up our Codespaces Directory

Now that the container exists, how do we build upon it? In our repository, we create a `.devcontainer` folder. Inside that folder is a `Dockerfile`, with the contents:

```Dockerfile
FROM nunitdocs/docfx-action:latest
EXPOSE 8080
```

This defines our `Dockerfile`, which builds on our general `docfx` container and also exposes port 8080, which will come in handy shortly.

## The `devcontainer.json` file

In our `.devcontainer` folder, we define a `devcontainer.json` file that looks like:

```json
{
    "name": "nunit-docs",
    "build": {
        "dockerfile": "Dockerfile"
    },
    "forwardPorts": [8080]
}
``` 

This:

* Defines the name of our Codespace
* Tells Codespaces to use our Dockerfile to build
* Tells Codespaces to forward port `8080`. 

## But What About Extensions?

We use a spell-checker and markdown linting vs code extension, and we don't want our Codespaces experience to be any different. Luckily, Codespaces allows us to define that right in our JSON file, which we modify to look like:

```json
{
    "name": "nunit-docs",
    "build": {
        "dockerfile": "Dockerfile"
    },
    "forwardPorts": [8080],
    "extensions": [
        "streetsidesoftware.code-spell-checker", 
        "oderwat.indent-rainbow", 
        "mdickin.markdown-shortcuts", 
        "davidanson.vscode-markdownlint",
        "redhat.vscode-yaml"
    ]
}
```

## How Do We Work Within it?

When we open GitHub Codespaces instance, we see a VS Code window in our browser.

* To build our docs site, we can `cd docs` and then `docfx build`. This will create a `_site` folder
* We can then run `docfx serve _site -n "*"`. This runs `docfx serve`, which serves a web app on mono. The `-n "*"` allows all bindings. When it runs, Codespaces sees it running on port 80, and "automagically" creates a URL that you can view in your browser to see things running.

## Let's Make That a Little Easier

## What's Next?

* Our build process uses `cSpell` and `markdown-lint`, both of which are installed as `npm` global packages. I plan to update our Codespaces container image to install node and those packages, and then to add some shortcuts to easily enable their use.
* I love the idea of using the [VS Code Tour extension](https://github.com/microsoft/codetour) to show people around the place, so I'll probably try to do something with that too.

## Check it out!

You can see what the current setup looks like [over at the NUnit docs repository](https://github.com/nunit/docs/tree/master/.devcontainer).