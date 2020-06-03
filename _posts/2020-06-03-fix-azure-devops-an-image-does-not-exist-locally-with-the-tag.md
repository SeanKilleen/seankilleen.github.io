---
title: 'Fix: Azure DevOps "An image does not exist locally with the tag"'
comments: true
tags:
  - azure
  - devops
  - azure devops
  - docker
date: 2020-06-03 11:57 -0400
---
I was working on [a livestream](https://twitch.tv/sjkilleen) recently when I ran into an issue attempting to push a docker container to a private registry in Azure DevOps.

## Problem

Upon attempting to push the container to my container registry, I received the error:

> ##[error]An image does not exist locally with the tag: ***/konmaripoweb

This is weird, because this tag should be happening automatically. Something wasn't matching up.

## Solution

The fix in this case actually has to do with how the Azure DevOps tasks work, in particular the `Docker@2` task that I was working with.

I pulled the repo and looked into [the DockerV2 task's source code](https://github.com/microsoft/azure-pipelines-tasks/tree/master/Tasks/DockerV2) to find the solution.

I noticed that in the build and publish tasks specify a registry name if the `containerRegistry` value is set or the service connection exists. My publish step was specifying this attribute, but my build step was not. 

I modified the build step to also pass in this parameter, and the correct tags were created across both steps to resolve the issue.

Happy (containerized) coding!