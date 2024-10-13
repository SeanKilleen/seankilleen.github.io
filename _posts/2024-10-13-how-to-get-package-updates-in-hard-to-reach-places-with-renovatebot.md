---
title: How to Get Package Updates in Hard-to-Reach Places With RenovateBot
comments: true
tags:
  - renovatebot
  - dependencies
  - dependency-management
  - devops
date: 2024-10-13 09:10 -0400
---
## Background 

I've adopted RenovateBot in many of my repositories. I've found it easier to work with than GitHub's own Dependabot. Highly recommend checking them and Mend.io (their parent company) out.

But a problem I've had in a few places has been that package updater tools aren't always able to detect every location for packages. For example:

* In the NUnit Docs repository, we have a reference to the version of NUnit in a build script variable
* In an automated test in a company repo that uses Test containers, our tests need to use the same version our app does, but this version is just a random string

Luckily, RenovateBot has a great way to manage these too!

## Solution: Custom Managers
