---
title: "Santa Sleigh: NUnit Edition"
comments: true
tags:
  - csharp
  - advent
  - testing
  - automation
  - nunit
date: 2021-12-19 00:01 -0400
#excerpt: "TODO"
#header:
#  overlay_image: /images/overlays/unsplash/ehimetalor-akhere-unuabona-TvJk52iLxQA-unsplash2.jpg
#  overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
#  caption: "Photo credit: [**Ehimetalor Akhere Unuabona @ Unsplash**](https://unsplash.com/@theeastlondonphotographer?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"

---

_This post is part of my [C# Advent 2021](https://www.csadvent.christmas/) submission. In this post, we'll continue to walk through the Santa Sleigh automated testing example from the [Introductory Blog Post](TODO: Link). If you haven't already, you may want to head there to get the basics set up._

Alright, so we've decided to go with the NUnit testing framework. An excellent choice!

## Changing the test Project Type

Because we created a plan class library during our initial setup, we'll want to modify that project so that th ecosystem understand it's a test project.

## Adding Nuget Packages

We'll want to add some nuget packages to our `SantaSleigh.Tests` project to enable us to write and run NUnit tests. I'll show the examples via the command line but you're welcome to install the packages in the test project via your development tool of choice.

* Head to the test project directory:

```cmd
cd SantaSleigh.Tests
```

* Add the Test SDK library which allows discovery and running of tests:

```cmd
dotnet add package Microsoft.NET.Test.Sdk
```

* Add the NUnit libraries:

```cmd
dotnet add package NUnit
```

* Add the NUnit test adapter which helps surface the tests:

```cmd
dotnet add package NUnit3TestAdapter
```

* Add the FluentAssertions library, which I love and will demonstrate in this post:

```cmd
dotnet add package FluentAssertions
```

## Writing Our First Test to Double-Check our Setup

We want to make sure we're set up for a good test automation loop, so we'll write a first test to do something basic and ensure it passes.

* In your test project, rename `Class1.cs` to `BasicTest.cs`.
* Replace the contents of the file with the below:

```csharp
using System;
using NUnit.Framework;

namespace SantaSleighCode.Tests
{
    public class BasicTest
    {
        [Test]
        public void MathStillWorks()
        {
            var result = 1 + 1;

            Assert.That(result, Is.EqualTo(2));
        }
    }
}
```

This file:

* References the NUnit Framework
* Has a public method marked with a `[Test]` attribute which indicates it should be run by NUnit
* Runs an assertion that the `result` variable, which is `1 + 1`, is equal to `2`.

## Running `dotnet test` to Check Our Work

We should be able to run `dotnet test` from the command line now and see one passed test:

TODO: Screenshot

And with that, we're ready to move on to considering and writing our first tests.

TODO: Checkpoint -- the work up to this point can be found in tag `nunit-01-basicsetup`.
