---
title: How to Get Package Updates in Hard-to-Reach Places With RenovateBot
comments: true
tags:
  - renovatebot
  - dependencies
  - dependency-management
  - devops
date: 2024-12-30 09:00 -0500
summary: No dependency left behind.
header:
  overlay_image: /images/overlays/unsplash/luke-heibert-gthSas4oYC0-unsplash.jpg
  overlay_filter: 0.5
  caption: "Photo credit: [**Luke Heibert @ Unsplash**](https://unsplash.com/@lukeheibert?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash)"
---
## Background

I've adopted RenovateBot in many of my repositories. I've found it easier to work with than GitHub's own Dependabot. Highly recommend checking them and [Mend.io](https://mend.io) (their parent company) out.

A challenge I've had in a few places has been that package updater tools aren't always able to detect every location for packages. For example:

* In the NUnit Docs repository, we have a reference to the version of NUnit in a build script variable
* In an automated test in a company repo that uses [TestContainers for .NET](https://dotnet.testcontainers.org/), our tests need to use the same version our app does, but the version number is located in a string in the middle of a test.

Luckily, RenovateBot has a great way to manage these too!

## Solution: Custom Managers

RenovateBot has a solution for this called custom managers, where you can enter a file type and regex which it will scan for package updates.

In the case of NUnit, where we have a version number for `docfx` in a Docker file, I could use the following in my `renovate.json` file:

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
* Defining the match string as a Regex that captures the current value of the package. This is so RenovateBot knows what to replace with the new version number.
* The dependency name is hard-coded to `docfx` in this case
* And we say that we're using the nuget package system.

Similarly, NUnit makes use of this for updating the version of NUnit used in one of our GitHub actions:

```json
  "customManagers": [
    {
      "customType": "regex",
      "fileMatch": [
        "^\\.github\\/workflows\\/build-process\\.yml$"
      ],
      "matchStrings": [
        "NUNIT_VERSION_FOR_API_DOCS: \"(?<currentValue>.*?)\""
      ],
      "depNameTemplate": "NUnit",
      "datasourceTemplate": "nuget"
    }
  ]
```

And here's it working to keep a container tag up to date from within C# files:

```json
  "customManagers": [
    {
      "customType": "regex",
      "fileMatch": [
        ".*\\.cs"
      ],
      "matchStrings": [
        ".WithImage\\(\\\"ironsoftwareofficial\\/ironpdfengine:(?<currentValue>.*?)\\\"\\)"
      ],
      "depNameTemplate": "ironsoftwareofficial/ironpdfengine",
      "datasourceTemplate": "docker"
    }
  ]
```

## In Summary

Dependency management tools like RenovateBot are a game changer. Ensuring they can get into all the nooks and crannies of your app helps them do their job.
