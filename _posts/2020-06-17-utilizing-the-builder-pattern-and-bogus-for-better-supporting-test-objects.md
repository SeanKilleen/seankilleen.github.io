---
title: Utilizing Bogus with the Builder Pattern for better Mocks
comments: true
tags:
  - builder pattern
  - tests
  - automated tests
  - bogus
  - fake data
  - dotnet
  - .net
date: 2020-06-17 18:23 -0400
---

TODO: [let Brian Chavez know about this post](https://twitter.com/bchavez/status/1279054873191800832?s=20)

I was recently working with the excellent [Octokit.NET](https://github.com/octokit/octokit.net) library for working with GitHub, and like many developers, I needed to write a test.

I figured I'd give a quick run-down on the journey of that test, how I ultimately used the [Bogus](https://github.com/bchavez/Bogus) library to help wire up my fake, and then talk about some of the other great functionality of Bogus.

## Mocking a Large Object

I have a function in my app called `GetRepoQuotaFromOrg`. Its purpose is to use the Octokit library and pull in the repository quota that the organization has. I wanted to write a test that proves that demonstrates that my code is using the `PrivateRepos` field from the GitHub organization.

But, there's a challenge here. I need my mock `IOrganizationClient` client to return an `Organization` object. But here's the constructor for the `Organization` object:

## Introducing the Builder Pattern

## A Step Better: Using Bogus to Remove the Builder Pattern Cruft
