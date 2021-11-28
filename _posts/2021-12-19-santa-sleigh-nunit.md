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

## Our First Tests

If we recall the problem statement from the introductory article, it says:

> Santa's sleigh starts facing North at coordinate `0,0`.

This seems like a great place to start as it allows us to test a default and get a few tests out of the way early on. Let's dive in!

* In our test project, create a new class file called `SantaSleighTests.cs`. This will serve as the file we use to house the tests for our `SantaSleigh` class.

Next, let's think about how to name our tests. There are a number of acceptable ways to do this, but I've found that good starting point for those who are new to the practice is to think about test names in terms of `[MethodToRun]_[Scenario]_[Expectation]`. It's not a hard and fast rule, and as long as the description is clear you should be good, but we'll use this convention throughout the article.

With this in mind, our first test method will be named: `GetDirection_Default_FacingNorth()`.

Let's open the `SantaSleighTests.cs` and write our first unit test. You can replace the contents of the file with:

```csharp
using System;
using NUnit.Framework;
using FluentAssertions;

namespace SantaSleighCode.Tests
{
    public class SantaSleighTests
    {
        [Test]
        public void GetDirection_Default_FacingNorth()
        {
            var sut = new SantaSleigh();

            var result = sut.GetDirection();

            result.Should().Be("N");
        }
    }
}
```

Let's take a look at what this test sets up:

* It adds a `using` statement for `FluentAssertions`, which we use later in the test because I love the syntax.
* It defines a variable called `sut`, which is a short-hand I often use that means "situation under test". I've also often seen `cut` (class under test), or just a clear variable (e.g. something like `sleigh` in this casee).
  * Note that it sets the variable to `new SantaSleigh()`, which does not yet exist. This code will currently not compile, so any attempt to run the test will fail. This is OK; we're writing the test before the production code exists.
* It acts on the situation under test by calling `GetDirection()`, which again doesn't currently exist.
* Finally, it uses the FluentAssertions syntax to say that the result should be `N`.
  * If we weren't using FluentAssertions, a similar statement using just NUnit could read: `Assert.That(result, Is.EqualTo("N"));`.

This process -- setting up the situation under test, performing an action, and creating an assertion, is known in the unit testing world as "Arrange, Act, Assert" or "AAA".

A few tips:

* Note that we only have one action. Typically, we want to limit our actions to those that are directly involved in achieving the test results. If it's more than one action, changes are we want the granularity of more than one test to capture it, or that the "action" is actually part of arranging the situation/class under test.
* Note that we only have one assertion. Typically, we want to keep our assertions small, because we want our test to have one and only one reason that it can fail. Multiple assertions could mean that some assertions pass and some fail, and you may not easily be able to see all of them at a glance. Many small tests can help triangulate issues when they occur.
  * This isn't a hard and fast rule; most things rarely are. I typically say "one logical assertion". It may be that several assertions constitute one logical assertion. In that case, frameworks have ways to track multiple assertions, or you can refactor your test code to re-write it into one assertion.
* I typically leave line breaks between arrange, act, and assert. Some folks also add comments such as `// Arrange` to help follow, but I've tended to find that if my tests require this, they may be more complex to digest than I'd like, and I look to make other changes. By all means, feel free to add these as you start if they help you keep the concepts in mind; there's no crime in making things clearer!

With our test in place and our code not compiling, it's time to write _just enough production code_ for the test to pass.

TODO -- info block -- Side note: Why "just enough production code"? The goal when doing TDD is to write only the required amount of code to make the test pass. If you can outsmart your test and write code that passes the test ut isn't finished, it's a great way to guide yourself to create additional tests.

In your production code project (`SantaSleigh`, not `SantaSleigh.Tests`), create a `SantaSleigh.cs` class as follows with our simplest implementation possible:

```csharp
public class SantaSleigh
{
    public string GetDirection()
    {
        return "N";
    }
}
```

We're clearly not anywhere near done yet as the return value is hard-coded. But, we now have a test that will pass if we run the tests via our IDE or `dotnet test`.

TODO: Now that we've done the default starting direction, should we move on to the default x and y coordinates? My personal preference is to stick with one concept at a time, and so even though I could add the defaults, I'm going to start with turning right and left.

So, our next test will be:

```csharp
[Test]
public void GetDirection_TurnRightOnce_FacingEast()
{
    var sut = new SantaSleigh();

    sut.TurnRight();
    var result = sut.GetDirection();

    result.Should().Be("E");
}
```

This won't compile, but we'll do the simplest production code to get things to compile:

```csharp
public class SantaSleigh
{
  private string _direction = "N";

  public string GetDirection()
  {
      return _direction;
  }

  public void TurnRight()
  {
      _direction = "E";
  }
}
```

We've:

* Introduced a local variable
* Set the first hard-coded variable to a one-time hard-coded variable, so we've done the simplest thing we can do to get the test to pass, and we're clearly not done, which will necessitate more tests.

Next up, we ping-pong back and forth on a few different tests (you can follow the commits on the NUnit branch: TODO link):

* `GetDirection_TurnRightTwoTimes_FacingSouth()`
* `GetDirection_TurnRightThreeTimes_FacingWest()`
* `GetDirection_TurnRightFourTimes_FacingNorth()`
* `GetDirection_TurnRightFiveTimes_FacingEast()`

And we cover turning left as well:

* `GetDirection_TurnLeftOneTime_FacingWest()`
* `GetDirection_TurnLeftTwoTimes_FacingSouth()`
* `GetDirection_TurnLeftThreeTimes_FacingEast()`
* `GetDirection_TurnLeftFourTimes_FacingNorth()`
* `GetDirection_TurnLeftFiveTimes_FacingWest()`

That brings us to a C# production code class that looks something like this:

```csharp
public class SantaSleigh
{
    private string _direction = "N";

    public string GetDirection()
    {
        return _direction;
    }

    public void TurnRight()
    {
        if (_direction == "N")
        {
            _direction = "E";
            return;
        }
        if (_direction == "E")
        {
            _direction = "S";
            return;
        }
        if (_direction == "S")
        {
            _direction = "W";
            return;
        }
        if (_direction == "W")
        {
            _direction = "N";
            return;
        }
    }

    public void TurnLeft()
    {
        if (_direction == "N")
        {
            _direction = "W";
            return;
        }
        if (_direction == "W")
        {
            _direction = "S";
            return;
        }
        if (_direction == "S")
        {
            _direction = "E";
            return;
        }
        if (_direction == "E")
        {
            _direction = "N";
            return;
        }
    }
}
```

This is...fine. But, it could likely be a little neater and more expressive. Since we've already got it covered by tests, we can refactor it into something that might be a little more expressive, using a linked list. This shortens the amount of code we have while still making sense (provided you're familiar with a linked list.)

```csharp
using System.Collections.Generic;

public class SantaSleigh
{
    private LinkedList<string> _directionList = new LinkedList<string>(new string[] { "N", "E", "S", "W" });
    private string _direction;

    public SantaSleigh()
    {
        _direction = _directionList.First.Value;
    }

    public string GetDirection()
    {
        return _direction;
    }

    public void TurnRight()
    {
        if (_direction == _directionList.Last.Value)
        {
            _direction = _directionList.First.Value;
            return;
        }

        _direction = _directionList.Find(_direction).Next.Value;
        return;
    }

    public void TurnLeft()
    {
        if (_direction == _directionList.First.Value)
        {
            _direction = _directionList.Last.Value;
            return;
        }

        _direction = _directionList.Find(_direction).Previous.Value;
        return;
    }
}
```

TODO: Info box -- just because this is a refactoring or change that I thought makes sense doesn't mean it's the right choice or the only possible choice. These sorts of choices are driven by the shared experience of your team, and trade-offs like readability, performance.

TODO: You can find this change at nunit-03-refactoring.

This cycle is what's known as the "Red, Green, Refactor" cycle. We wrote a failing test (red), wrote just enough code to make it pass (green), and then eventually we hit a place where we wanted to change the production code, and could do so while guaranteeing via our tests that no functionality was broken (refactoring). This is where we start to really experience the benefits of test-first development (though the true benefit of TDD in my opinion has already happened -- breaking down the problem into small pieces that we can reason about independently).
