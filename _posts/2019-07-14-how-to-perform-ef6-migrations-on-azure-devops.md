---
title: 'How to: Perform EF6 Migrations on Azure DevOps'
comments: true
tags:
  - ''
date: '2019-07-14 07:21 -0400'
---
I was surprised recently when working on some Azure DevOps updates that there's still no quick/easy way to generate or run migrations as part of the build & release process. You've got to do it yourself, which took me down memory lane. Documenting here so that I've got it for future reference.

## Two Different Approaches

* As part of the build
* As part of the release

I chose as part of the build

## Copy migrate.exe

**NOTE**: It has to be in the same directory as your data context dll.

## Run migrate.exe to generate the script.
