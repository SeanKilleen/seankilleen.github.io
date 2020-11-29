---
title: What does the "runs-on" machine type of a GitHub Action mean?
comments: true
tags:
  - docker
  - github actions
  - devops
  - ci
date: 2020-08-20 17:13 -0400
---
Received a really good question recently and I thought I'd post the result here.

## Question

> I'm finally getting the CI pipeline using GitHub actions. When in the YAML file example, it says the build:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
```

> In our setup for docker we’re using Alpine3.9. Do I change that line to Alpine or is it fine that it’s running on ubuntu for the CI pipeline? Seems like they should match but they only had ubuntu, macOS, and Windows as example options so I wanted to make sure.

## My Answer

The `runs-on` attribute indicates the environment that the GitHub Action itself will run within. You can think of every action as being run within its own little container. It's the type of machine to run the job on, but the action itself is executed in a container running on that platform so using Alpine for your container is no problem.

In the case of building a container, you'd be using a GitHub Action to build your docker image, likely something like this one: <https://github.com/docker/build-push-action>

That Docker action actually defines a container that it uses as part of the action itself, which would run within Ubuntu. You don't end up having to worry about that too much other than Ubuntu is the general environment that those containers will run within.

Hope this helps!
