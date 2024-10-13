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

RenovateBot has a solution for this called custom managers, where you can enter a file type and regex which it will scan for package updates.

In the case of NUnit, where we have a version number for docfx in a Docker file, I could do the following in my `renovate.json` file:

```json
"customManagers": [
    {
      "customType": "regex",
      "fileMatch": ["^Dockerfile$"],
      "matchStrings": ["docfx --version (?<currentValue>.*?)\\n"],
      "depNameTemplate": "docfx",
      "datasourceTemplate": "nuget"
    }
  ]
```

Let's break it down. This:

* Defines a manager of type Regex, meaning I'll be checking a string using a Regex matcher.
* Matching only Dockerfile files, so it won't accidentally be applied to anything else.
* Defining the match string as a Regex that captures the current value of the package. This is so RenovateBot knows what to replace with the version.
* The dependency name is hard coded here
* And we say that we're using the nuget package system.

Similarly, NUnit makes use of this for updating a version in C#:

TODO

And here's it working to keep a container up to date in another project:

TODO

## Let's See the Results!

TODO

## In Summary

Dependency management tools like RenovateBot are a game changer. Ensuring they can get into all the nooks and crannies of your app helps them do their job.
