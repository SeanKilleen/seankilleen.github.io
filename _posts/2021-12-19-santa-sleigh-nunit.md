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
excerpt: "Solving our C# Advent 2021 challenge using the NUnit framework."
header:
 overlay_image: /images/overlays/unsplash/hue12-photography-2qzZubxw7WE-unsplash.jpg
 overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
 caption: "Photo credit: [**hue12 Photography @ Unsplash**](https://unsplash.com/@hue12_photography?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"

---

This post is part of my [C# Advent 2021](https://www.csadvent.christmas/) submission; be sure to check out the other 49 great posts when you're done here! In this post, we'll continue to walk through the Santa Sleigh automated testing example from the [Introductory Blog Post]({% link _posts/2021-12-19-santa-sleigh.md %}). If you haven't already, you may want to head there to get the basics set up.

____

Alright, so we've decided to go with the NUnit testing framework. An excellent choice!

## Changing the Test Project Type

Because we created a plan class library during our initial setup, we'll want to modify that project so that the ecosystem understands it's a test project.

## Adding NuGet Packages

We'll want to add some NuGet packages to our `SantaSleigh.Tests` project to enable us to write and run NUnit tests. I'll show the examples via the command line but you're welcome to install the packages in the test project via your development tool of choice.

* Head to the test project directory:

```console
cd SantaSleigh.Tests
```

* Add the Test SDK library which allows discovery and running of tests:

```console
dotnet add package Microsoft.NET.Test.Sdk
```

* Add the NUnit libraries:

```console
dotnet add package NUnit
```

* Add the NUnit test adapter which helps surface the tests:

```console
dotnet add package NUnit3TestAdapter
```

* Add the FluentAssertions library, which I love and will demonstrate in this post:

```console
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

We should be able to run `dotnet test` from the command line now and see one passed test.

And with that, we're ready to move on to considering and writing our first tests.

{% include santa_checkpoint.html tagname="nunit-01-basicsetup" %}

## Our First Tests: Following Directions

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

**Why "just enough production code"?** The goal when doing TDD is to write only the required amount of code to make the test pass. If you can outsmart your test and write code that passes the test but isn't finished, it's a great way to guide yourself to create additional tests.
{: .notice--info}

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

Now that we've done the default starting direction, should we move on to the default x and y coordinates? My personal preference is to stick with one concept at a time, and so even though I could add the defaults, I'm going to start with turning right and left.

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

Next up, we ping-pong back and forth on a few different tests:

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

{% include santa_checkpoint.html tagname="nunit-02-turning" priorTag="nunit-01-basicsetup" %}

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

**There's always more than one way to code it!** Just because this is a refactoring or change that I thought makes sense doesn't mean it's the right choice or the only possible choice. These sorts of choices are driven by the shared experience of your team, and trade-offs like readability and performance. Covering your code with tests can give you more confidence to be flexible in the future and try different techniques.
{: .notice--info}

{% include santa_checkpoint.html tagname="nunit-03-refactoring" priorTag="nunit-02-turning" %}

This cycle is what's known as the "Red, Green, Refactor" cycle. We wrote a failing test (red), wrote just enough code to make it pass (green), and then eventually we hit a place where we wanted to change the production code, and could do so while guaranteeing via our tests that no functionality was broken (refactoring). This is where we start to really experience the benefits of test-first development (though the true benefit of TDD in my opinion has already happened -- breaking down the problem into small pieces that we can reason about independently).

## Next up: X and Y Coordinates

Our next set of tests will check the coordinates when moving and facing a certain direction. We'll start with the x coordinate. We'll have to think about how moving forward or backward when facing each direction will affect the X axis (the one that runs side to side, not up and down, for those of us like me who were never awesome at geometry :upside_down_face: ).

The list of tests here is roughly:

* `GetXCoordinate_Default_Zero()`
* `GetXCoordinate_FacingEastAndMovingForward_One()`
* `GetXCoordinate_FacingEastAndMovingBackward_NegativeOne()`
* `GetXCoordinate_FacingWestAndMovingForward_NegativeOne()`
* `GetXCoordinate_FacingWestAndMovingBackward_One()`
* `GetXCoordinate_FacingNorthAndMovingForward_NoChange()`
* `GetXCoordinate_FacingNorthAndMovingBackward_NoChange()`
* `GetXCoordinate_FacingSouthAndMovingForward_NoChange()`
* `GetXCoordinate_FacingSouthAndMovingBackward_NoChange()`

Our first few tests look like:

```csharp
[Test]
public void GetXCoordinate_Default_Zero()
{
    var sut = new SantaSleigh();

    var result = sut.GetXCoordinate();

    result.Should().Be(0);
}

[Test]
public void GetXCoordinate_FacingEastAndMovingForward_One()
{
    var sut = new SantaSleigh();
    sut.TurnRight();

    sut.MoveForward(1);
    var result = sut.GetXCoordinate();

    result.Should().Be(1);
}

[Test]
public void GetXCoordinate_FacingEastAndMovingBackward_NegativeOne()
{
    var sut = new SantaSleigh();
    sut.TurnRight();

    sut.MoveBackward(1);
    var result = sut.GetXCoordinate();

    result.Should().Be(-1);
}
```

But we're able to trick the production code to pass the tests without working yet:

```csharp
// ...
private int _xCoord = 0;

public int GetXCoordinate()
{
    return _xCoord;
}

public void MoveBackward(int spaces)
{
    _xCoord -= spaces; // This will only work when facing East
}
public void MoveForward(int spaces)
{
    _xCoord += spaces; // This will only work when facing East
}
```

After implementing the rest of the tests, the tests look like:

```csharp
[Test]
public void GetXCoordinate_Default_Zero()
{
    var sut = new SantaSleigh();

    var result = sut.GetXCoordinate();

    result.Should().Be(0);
}

[Test]
public void GetXCoordinate_FacingEastAndMovingForward_One()
{
    var sut = new SantaSleigh();
    sut.TurnRight();

    sut.MoveForward(1);
    var result = sut.GetXCoordinate();

    result.Should().Be(1);
}

[Test]
public void GetXCoordinate_FacingEastAndMovingBackward_NegativeOne()
{
    var sut = new SantaSleigh();
    sut.TurnRight();

    sut.MoveBackward(1);
    var result = sut.GetXCoordinate();

    result.Should().Be(-1);
}

[Test]
public void GetXCoordinate_FacingWestAndMovingForward_NegativeOne()
{
    var sut = new SantaSleigh();
    sut.TurnLeft();

    sut.MoveForward(1);
    var result = sut.GetXCoordinate();

    result.Should().Be(-1);
}

[Test]
public void GetXCoordinate_FacingWestAndMovingBackward_One()
{
    var sut = new SantaSleigh();
    sut.TurnLeft();

    sut.MoveBackward(1);
    var result = sut.GetXCoordinate();

    result.Should().Be(1);
}

[Test]
public void GetXCoordinate_FacingNorthAndMovingForward_NoChange()
{
    var sut = new SantaSleigh();

    sut.MoveForward(1);
    var result = sut.GetXCoordinate();

    result.Should().Be(0);
}

[Test]
public void GetXCoordinate_FacingNorthAndMovingBackward_NoChange()
{
    var sut = new SantaSleigh();

    sut.MoveBackward(1);
    var result = sut.GetXCoordinate();

    result.Should().Be(0);
}

[Test]
public void GetXCoordinate_FacingSouthAndMovingForward_NoChange()
{
    var sut = new SantaSleigh();
    sut.TurnLeft();
    sut.TurnLeft();

    sut.MoveForward(1);
    var result = sut.GetXCoordinate();

    result.Should().Be(0);
}

[Test]
public void GetXCoordinate_FacingSouthAndMovingBackward_NoChange()
{
    var sut = new SantaSleigh();
    sut.TurnLeft();
    sut.TurnLeft();

    sut.MoveBackward(1);
    var result = sut.GetXCoordinate();

    result.Should().Be(0);
}
```

And the production code looks like:

```csharp
public int GetXCoordinate()
{
    return _xCoord;
}

public void MoveBackward(int spaces)
{
    if (_direction == "E")
    {
        _xCoord -= spaces;
    }
    if (_direction == "W")
    {
        _xCoord += spaces;
    }
}

public void MoveForward(int spaces)
{
    if (_direction == "E")
    {
        _xCoord += spaces;
    }
    if (_direction == "W")
    {
        _xCoord -= spaces;
    }
}
```

### Oops! Calling myself out.

Can you spot where I jumped ahead here and didn't do the simplest thing? I automatically used the `spaces` parameter in the `MoveForward` and `MoveBackward` methods, rather than just increasing by 1, which would have then helped me reveal that I needed more tests to handle multiple spaces.

Next, we'll go ahead and fix my mistake, adapting some of our tests to account for moving multiple spaces. For this, we'll use the NUnit `TestCase` functionality.

We change our tests to look more like the following:

```csharp
[TestCase(1)]
[TestCase(12)]
[TestCase(123)]
public void GetXCoordinate_FacingWestAndMovingBackward_IncreasesX(int numberOfSpaces)
{
    var sut = new SantaSleigh();
    sut.TurnLeft();

    sut.MoveBackward(numberOfSpaces);
    var result = sut.GetXCoordinate();

    result.Should().Be(numberOfSpaces);
}
```

What's going on in this code?

* We've updated the expectation from a specific number to the understanding that the X value (in this case) should increase.
* We've used the `TestCase` notation, which will pass along specific values to the test
* We've added and used the `numberOfSpaces` parameter, which gets the value from the test case and uses it in the test.

So, we've effectively turned our test from one test method to three test cases (which will run as separate tests) that check multiple data points.

**Side Note: not everything needs test cases.** Test cases can be a drawback as well. You'll want to make sure that if you're using them, that they really are relevant to the test case at hand and aren't unnecessarily lumping tests together. If you're trying to test something that has less explicit examples, you might be best off looking at property-based testing, which we'll demonstrate a little later on.
{: .notice--info}

{% include santa_checkpoint.html tagname="nunit-04-xcoordinates" priorTag="nunit-03-refactoring" %}

Now we'll apply the tests for the Y coordinates. The list of tests in order will be:

* `GetYCoordinate_Default_Zero()`
* `GetYCoordinate_FacingNorthAndMovingForward_IncreasesY()`
* `GetYCoordinate_FacingNorthAndMovingBackward_DecreasesY()`
* `GetYCoordinate_FacingSouthAndMovingForward_DecreasesY()`
* `GetYCoordinate_FacingSouthAndMovingBackward_IncreasesY()`
* `GetYCoordinate_FacingEastAndMovingForward_NoChange()`
* `GetYCoordinate_FacingEastAndMovingBackward_NoChange()`
* `GetYCoordinate_FacingWestAndMovingForward_NoChange()`
* `GetYCoordinate_FacingWestAndMovingBackward_NoChange()`

We'll again use test cases for these samples, in the same style as the X coordinate tests. I won't include those here but you're welcome to view the code in the checkpoint.

Our production code now looks like:

```csharp
public void MoveBackward(int spaces)
{
    if (_direction == "E")
    {
        _xCoord -= spaces;
    }
    if (_direction == "W")
    {
        _xCoord += spaces;
    }
    if (_direction == "N")
    {
        _yCoord -= spaces;
    }
    if (_direction == "S")
    {
        _yCoord += spaces;
    }
}
public void MoveForward(int spaces)
{
    if (_direction == "E")
    {
        _xCoord += spaces;
    }
    if (_direction == "W")
    {
        _xCoord -= spaces;
    }
    if (_direction == "N")
    {
        _yCoord += spaces;
    }
    if (_direction == "S")
    {
        _yCoord -= spaces;
    }
}
```

The if statements feel a little verbose, so I'll refactor to change them into a `switch` statement for now, double-checking afterward that my tests still pass:

```csharp
public void MoveBackward(int spaces)
{
    switch (_direction)
    {
        case "N":
            _yCoord -= spaces;
            break;
        case "E":
            _xCoord -= spaces;
            break;
        case "S":
            _yCoord += spaces;
            break;
        case "W":
            _xCoord += spaces;
            break;
    }
}
public void MoveForward(int spaces)
{
    switch (_direction)
    {
        case "N":
            _yCoord += spaces;
            break;
        case "E":
            _xCoord += spaces;
            break;
        case "S":
            _yCoord -= spaces;
            break;
        case "W":
            _xCoord -= spaces;
            break;
    }
}
```

{% include santa_checkpoint.html tagname="nunit-05-ycoordinates" priorTag="nunit-04-xcoordinates" %}

## Next Up: Around the World

Since we have the concept of direction and coordinates well under test at this point, I think a reasonable next place to start is this requirement from the original problem:

> Implement wrapping at edges, because planets are spheres

This implies that we'll need to:

* Begin taking in a size of the grid as an argument to our `SantaSleigh` constructor
* Wrap `x` and `y` coordinates both ways from each direction
* Ensure the direction stays the same when wrapping

We're going to begin this requirement with a bit of refactoring -- this time of our test code. I know that we'll be modifying the constructor of our test code, which is currently called in every single test. To ensure that the code for creating the situation under test is repeated for each test while keeping it one place, I'll use NUnit's `SetUp` method, which will run prior to any individual test being executed. As implied, it's a way to "set up" a test.

**Side Note: tests _are_ production code!** Tests are part of our production code. As such, we want to ensure they stay efficient and readable, and to prevent them from rotting. We shouldn't be afraid of improving the readability of tests or tweaking them to make good use of libraries and tooling.
{: .notice--info}

After the refactoring, the tests look like the snippet below:

```csharp
public class SantaSleighTests
{
    private SantaSleigh _sut;

    [SetUp]
    public void Setup()
    {
        _sut = new SantaSleigh();
    }

    [Test]
    public void GetDirection_Default_FacingNorth()
    {
        var result = _sut.GetDirection();

        result.Should().Be("N");
    }

    // ...
}
```

* We extract a private variable for the `_sut`.
* During the `Setup()` method, which we annotate with `[SetUp]` so that NUnit can recognize it, we instantiate the `_sut` variable
* We reference the `_sut` variable in our tests. Note that this can sometimes make it look like the "arrange" step of a test is missing, but setup is implied to be part of the arrange step, so in these cases we don't need to do anything else.

### So, uh...There are a Lot of Possible Combinations here.

We could spend a lot of time trying to think up examples with various sized grids to use in our test cases, but instead let's think about the _properties_ of the system we're trying to test -- for example:

* Property: In a grid of `size`, facing North and moving forward `size + 1` should make the Y coordinate `-size`.
  * Example: In a grid of `3`, facing North and moving forward `4` should make the Y Coordinate `-3`, because we have wrapped around to the bottom.

Luckily, there's a great way to be able to code these up so that many test cases can be generated. **Property-based testing to the rescue!** We'll use [FsCheck](https://fscheck.github.io/FsCheck/) to achieve this.

We install the `FsCheck.NUnit` package into our test project, either via the command line or the NuGet installation dialog in our IDE of choice.

Our first property-based test looks like:

```csharp
[Property]
public Property GetYCoordinate_FacingNorthMovingForwardPastEdgeByOne_MinimumYValue(PositiveInt randomSize)
{
    var gridSize = ((int)randomSize);
    var sut = new SantaSleigh(gridSize);
    sut.MoveForward(gridSize + 1);
    var result = sut.GetYCoordinate();

    return (result == -gridSize).ToProperty();
}
```

Note the notation of `Property` rather than `Test`, which FsCheck uses to generate the tests. Also, note that we're not using the `_sut` variable from the setup. We're using our own here, which is fine because our usage of the `SantaSleigh` in this case is different and contained within the test. Lastly, note that we're using the FsCheck-provided `PositiveInt` as a parameter, which is lovely helper to ensure we don't have negative grid numbers.

If you run our tests at this point, you'll notice the code doesn't compile, because we've introduced the concept of a grid size into our `SantaSleigh` constructor. We'll need to do a couple of things.

First, we update the constructor to take in the grid size:

```csharp
public SantaSleigh(int gridSize)
{
    _direction = _directionList.First.Value;
    _gridSize = gridSize;
}
```

Next, we need to update the max grid size in our tests, which needs to be `124` since our tests so far assumed they could go `123` spaces without wrapping (I'm kind of regretting picking that number, but it's all good for now.) Our test setup now looks like:

```csharp
public class SantaSleighTests
{
    private SantaSleigh _sut;
    private const int GRID_SIZE = 124;

    [SetUp]
    public void Setup()
    {
        _sut = new SantaSleigh(GRID_SIZE);
    }

    // ...
}
```

Now the code once again compiles, which is great! We only have our failing test to deal with. The test failure message reads:

```console
Failed GetYCoordinate_FacingNorthMovingForwardPastEdgeByOne_MinimumYValue [336 ms]
  Error Message:
   Falsifiable, after 1 test (0 shrinks) (StdGen (830650822,296973528)):
Original:
PositiveInt 1
with exception:
NUnit.Framework.AssertionException: Expected result to be -1, but found 2.
```

FsCheck would normally try many test case combinations, but it actually failed on the first one in this case.

With that, we can update our switch case for `MoveForward` to add logic that works:

```csharp
public void MoveForward(int spaces)
{
    switch (_direction)
    {
        case "N":
            // Yeah, this took me a minute and there's probably a better way.
            // Check if we are going to go off the grid
            if (_yCoord + spaces > _gridSize)
            {
                // Get how many spaces off we'd be
                var spacesOffTheGrid = (_yCoord + spaces) - _gridSize;
                _yCoord = (-_gridSize) + spacesOffTheGrid - 1;
            }
            else
            {
                _yCoord += spaces;
            };
            break;
        case "E":
            _xCoord += spaces;
            break;
        case "S":
            _yCoord -= spaces;
            break;
        case "W":
            _xCoord -= spaces;
            break;
    }
}
```

Our property-based test now passes! FsCheck ran 100 iterations with positive numbers and couldn't falsify the property of the system.

Now that I have my ugly logic in place, I'm going to see if I can extract it to a method that will make more sense and that I can re-use for the other directions.

```csharp
public void MoveForward(int spaces)
{
    switch (_direction)
    {
        case "N":
            // Yeah, this took me a minute and there's probably a better way.
            // Check if we are going to go off the grid
            _yCoord = IncreaseCoordinateAgainstGridSize(_yCoord, spaces, _gridSize);
            break;
        case "E":
            _xCoord += spaces;
            break;
        case "S":
            _yCoord -= spaces;
            break;
        case "W":
            _xCoord -= spaces;
            break;
    }
}

private int IncreaseCoordinateAgainstGridSize(int coord, int spaces, int gridSize)
{
    if (coord + spaces > gridSize)
    {
        // Get how many spaces off we'd be
        var spacesOffTheGrid = (coord + spaces) - gridSize;
        return (-gridSize) + spacesOffTheGrid - 1;
    }
    else
    {
        return coord += spaces;
    };
}
```

**Do I need to test the private method too?** In this case, no, because its behavior is being tested via the test against the public method. Just because we're writing tests doesn't mean we need to make every method public and test it.
{: .notice--info}

We then write similar tests, one by one in TDD fashion, to force us to utilize the new method in every place in the production code that increases a coordinate, and then we do the same with an additional new method for every time we want to decrease a coordinate. When we're done, our production code looks like this:

```csharp
// ...

public void MoveForward(int spaces)
{
    switch (_direction)
    {
        case "N":
            _yCoord = IncreaseCoordinateAgainstGridSize(_yCoord, spaces, _gridSize);
            break;
        case "E":
            _xCoord = IncreaseCoordinateAgainstGridSize(_xCoord, spaces, _gridSize);
            break;
        case "S":
            _yCoord = DecreaseCoordinateAgainstGridSize(_yCoord, spaces, _gridSize);
            break;
        case "W":
            _xCoord = DecreaseCoordinateAgainstGridSize(_xCoord, spaces, _gridSize);
            break;
    }
}

private int IncreaseCoordinateAgainstGridSize(int coord, int spaces, int gridSize)
{
    if (coord + spaces > gridSize)
    {
        // Get how many spaces off we'd be
        var spacesOffTheGrid = (coord + spaces) - gridSize;
        return (-gridSize) + spacesOffTheGrid - 1;
    }
    else
    {
        return coord += spaces;
    };
}

private int DecreaseCoordinateAgainstGridSize(int coord, int spaces, int gridSize)
{
    if (coord - spaces < -gridSize)
    {
        // Get how many spaces off we'd be
        var spacesOffTheGrid = (coord - spaces) + gridSize;
        return (gridSize) + spacesOffTheGrid + 1;
    }
    else
    {
        return coord -= spaces;
    };
}
```

We also want to ensure that no matter what direction we're facing, we remain in that direction when wrapping around the grid. Thinking through this test, my brain phrases it something like:

> After turning between 0 and x times, and going beyond the edge of the grid by 2, we should still be facing the same direction.

This seems to be another good candidate for a property-based test:

```csharp
[Property]
public void GetDirection_AfterRandomTurnsAndWrappingAround_StillTheSame(PositiveInt randomSize, NonNegativeInt numberOfTurns)
{
    var gridSize = ((int)randomSize);
    var sut = new SantaSleigh(gridSize);
    foreach (var i in Enumerable.Range(0, (int)numberOfTurns))
    {
        sut.TurnLeft();
    }
    var startingDirection = sut.GetDirection();

    sut.MoveForward(gridSize + 1);
    var result = sut.GetDirection();

    result.Should().Be(startingDirection);
}
```

{% include santa_checkpoint.html tagname="nunit-06-wrapping" priorTag="nunit-05-ycoordinates" %}

## ...and Who Doesn't Love Presents?!

With turning, coordinates, grid size, and wrapping under our belt, it's time for Santa to deliver the goods.

First, we'll get the idea of the starting number of presents out of the way with a property based test, and we'll have to refactor our other tests to include this number in the constructor, as well as creating the `RemainingPresents` method defined in the original problem description.

The new test we added:

```csharp
[Property]
public void RemainingPresents_Default_EqualsWhatWasPutIn(NonNegativeInt numberOfPresents)
{
    var dummyGridSize = 5;
    var sut = new SantaSleigh(dummyGridSize, (int)numberOfPresents);

    var result = sut.RemainingPresents();

    result.Should().Be((int)numberOfPresents);
}
```

The modified constructor:

```csharp
// ...
private int _numberOfPresents;
private string _direction;
private int _gridSize;

public SantaSleigh(int gridSize, int numberOfPresents)
{
    _direction = _directionList.First.Value;
    _gridSize = gridSize;
    _numberOfPresents = numberOfPresents;
}
```

The new method that passes the test:

```csharp
public int RemainingPresents()
{
    return _numberOfPresents;
}
```

And an example of how I modified a prior test:

```csharp
[Property]
public void GetDirection_AfterRandomTurnsAndWrappingAround_StillTheSame(PositiveInt randomSize, NonNegativeInt numberOfTurns)
{
    var gridSize = ((int)randomSize);
    var sut = new SantaSleigh(gridSize, DUMMY_NUMBER_OF_PRESENTS);
    foreach (var i in Enumerable.Range(0, (int)numberOfTurns))
    {
        sut.TurnLeft();
    }
    var startingDirection = sut.GetDirection();

    sut.MoveForward(gridSize + 1);
    var result = sut.GetDirection();

    result.Should().Be(startingDirection);
}
```

**Calling attention to irrelevance**: Note the class-level constant I created, `DUMMY_NUMBER_OF_PRESENTS`. I gave this a particularly obvious name, but I like blunt names like this for any other strings or numbers that might be used in a test that aren't actually relevant to the test but are required for the operation of the code. This way, you can quickly see the values in a test that matter and you should pay attention to. In my experience, conveying intent in this way is helpful.
{: .notice--info}

Next, I thought about some of the things I might want to test for:

* The presents shouldn't reduce if we don't move.
* The presents shouldn't reduce if we stop at a coordinate that doesn't have a house.
* What about a house that requests zero presents?
  * For our tutorial, passing over a house that requested zero presents doesn't get any; we're going to treat this as an opt-out and respect preferences.
* Property Test: Stopping over a house that requests `x` presents, when we have `x+1` presents, will leave us with zero remaining presents.
  * (zero because part of the instructions were that Santa provides one more than is asked for.)
* Stopping over multiple houses should continue to reduce presents
* Houses shouldn't receive presents twice; once Santa delivers there, they're done even if he flies over their house again.
* What about houses along the way during movement? If I move forward 5 spaces and space 3 holds a house, should we drop a present there?
  * For the sake of tutorial length and our contrived example, we'll opt for the easier route of "only a house that santa stops at receives presents; not every house he passes over." We'll still write a test to demonstrate that this is the case, though.
* Exception if there aren't enough presents left.

We should be able to do the first test as simply as possible -- the contents of `RemainingPresents_Default_EqualsWhatWasPutIn`:

```csharp
[Property]
public void RemainingPresents_Default_EqualsWhatWasPutIn(NonNegativeInt numberOfPresents)
{
    var dummyGridSize = 5;
    var sut = new SantaSleigh(dummyGridSize, (int)numberOfPresents);

    var result = sut.RemainingPresents();

    result.Should().Be((int)numberOfPresents);
}
```

Truth be told, that's probably an example of going a little too far testing something that probably doesn't need testing. This case will be covered by upcoming tests. But it's not the end of the world and the trade-off isn't big to keep it around so we might as well leave it.

For the next test, `RemainingPresents_WhenStoppingOverCoordinateThatIsntInPresentsList_StaysTheSame()`, we can pass in an empty list of houses, and I'll use a `record` type represent a `NeighborhoodHouse`. The test will look like the below:

```csharp
[Test]
public void RemainingPresents_WhenStoppingOverCoordinateThatIsntInPresentsList_StaysTheSame()
{
    var dummyGridSize = 5;
    var emptyList = new List<NeighborhoodHouse>();
    var sut = new SantaSleigh(dummyGridSize, DUMMY_NUMBER_OF_PRESENTS, emptyList);

    sut.MoveForward(1);

    var result = sut.RemainingPresents();
    result.Should().Be(DUMMY_NUMBER_OF_PRESENTS);
}
```

At this point, the code will fail to compile -- we've introduced a new class and modified the constructor, so we'll need to fix up the code before it will compile again.

In our production code, underneath the `SantaSleigh` class, we define the new record type (there are no fields yet, as our tests have not required us to add them):

```csharp
public record NeighborhoodHouse();
```

We modify the constructor to take in the new list and save it:

```csharp
// ...
private List<NeighborhoodHouse> _neighborhoodHouses;

public SantaSleigh(int gridSize, int numberOfPresents, List<NeighborhoodHouse> houses)
{
    _direction = _directionList.First.Value;
    _gridSize = gridSize;
    _numberOfPresents = numberOfPresents;
    _neighborhoodHouses = houses;
}
```

Then we modify the tests to include the list in our situations under test -- one example:

```csharp
// Side note -- I really dig the newly-introduced new() syntax for cases like this.
private List<NeighborhoodHouse> DUMMY_EMPTY_HOUSE_LIST = new();

[SetUp]
public void Setup()
{
    _sut = new SantaSleigh(GRID_SIZE, DUMMY_NUMBER_OF_PRESENTS, DUMMY_EMPTY_HOUSE_LIST);
}
```

Once we've done this, all our tests will pass because it's a default behavior. But this is a little bit of a smell -- where is the "red" in our "red, green, refactor" cycle? If we don't actually see a test fail, how do we know it's testing what we think it is? Not safe to assume. So, I'd like to modify something to see the test fail. In this case, the `MoveForward` method is called, so I'll add some code to set the number of presents to a hard-coded number, which should guarantee some tests fail.

```csharp
public void MoveForward(int spaces)
{
    _numberOfPresents = 1; // This is erroneous
    // ...
}
```

When I run my tests, I see that my test fails, and for the reason I expect it to. I can then remove the erroneous code and be confident that my test is covering the expected path.

Next up, ensuring that a house that requests zero presents doesn't reduce the present count. This will force us to take `x` and `y` coordinates into account in our `NeighborhoodHouse` type.

```csharp
[Test]
public void RemainingPresents_WhenStoppingOverHouseThatRequestsZeroPresents_StaysTheSame(){
    var gridSize = 5;
    var house = new NeighborhoodHouse(1,1,0);
    var houseList = new List<NeighborhoodHouse> { house };
    var sut = new SantaSleigh(gridSize, DUMMY_NUMBER_OF_PRESENTS, houseList);

    sut.MoveForward(1); // now at 1 on y axis
    sut.TurnRight(); 
    sut.MoveForward(1); // now at 1 on x axis

    var result = sut.RemainingPresents();
    result.Should().Be(DUMMY_NUMBER_OF_PRESENTS);
}
```

And we make the update to the record type so that it will compile:

```csharp
public record NeighborhoodHouse(int X, int Y, int RequestedPresents);
```

This test also passes by default, so we use the same trick as before to force the test to fail in a specific way that makes sense, so that we can be sure our test is valid (which I'll omit here for brevity.)

Next up, it's time to test the decrementing of the presents when we fly over a house. I think we can do this with a property-based test. I'll choose to express the property of the system as `RemainingPresents_WhenFlyingOverAHouseThatRequestsPresents_WillBeReducedByOneMoreThanAskedFor()`:

```csharp
[Property]
public void RemainingPresents_WhenFlyingOverAHouseThatRequestsPresents_WillBeReducedByOneMoreThanAskedFor(PositiveInt numberOfRequestedPresents)
{
    var gridSize = 5;
    var totalPresents = (int)numberOfRequestedPresents + 1;
    var house = new NeighborhoodHouse(1, 1, (int)numberOfRequestedPresents);
    var houseList = new List<NeighborhoodHouse> { house };
    var sut = new SantaSleigh(gridSize, totalPresents, houseList);

    sut.MoveForward(1); // now at 1 on y axis
    sut.TurnRight();
    sut.MoveForward(1); // now at 1 on x axis

    var result = sut.RemainingPresents();
    result.Should().Be(0);
}
```

This predictably fails because we're not reducing the number of presents. So we'll modify our production code in the simplest way possible to force ourselves to write new tests later. In this case, our simpler cases force us to pretty much write the full logic in the `MoveForward` method:

```csharp
public void MoveForward(int spaces)
{
    switch (_direction)
    {
        // ...
    }

    var matchingHouse = _neighborhoodHouses.SingleOrDefault(house => house.X == _xCoord && house.Y == _yCoord);
    if (matchingHouse != null && matchingHouse.RequestedPresents > 0)
    {
        _numberOfPresents -= (matchingHouse.RequestedPresents + 1);
    }
}
```

This passes the test, but I don't like that magic number `1` in our production code, so we extract a variable called `magicalExtraPresents` and assign it to that:

```csharp
if (matchingHouse != null && matchingHouse.RequestedPresents > 0)
{
    var magicalExtraPresents = 1;
    _numberOfPresents -= (matchingHouse.RequestedPresents + magicalExtraPresents);
}
```

So we've placed this code in the `MoveForward` method, but we'll need to test the `MoveBackward` method too. So we'll do an additional property-based test where we back into being over the house:

```csharp
[Property]
public void RemainingPresents_WhenBackingOverAHouseThatRequestsPresents_WillBeReducedByOneMoreThanAskedFor(PositiveInt numberOfRequestedPresents)
{
    var gridSize = 5;
    var totalPresents = (int)numberOfRequestedPresents + 1;
    var house = new NeighborhoodHouse(1, 1, (int)numberOfRequestedPresents);
    var houseList = new List<NeighborhoodHouse> { house };
    var sut = new SantaSleigh(gridSize, totalPresents, houseList);

    sut.MoveForward(1); // now at 1 on y axis
    sut.TurnLeft();
    sut.MoveBackward(1); // now at 1 on x axis

    var result = sut.RemainingPresents();
    result.Should().Be(0);
}
```

I can copy and paste the production code that we added for `MoveForward` into `MoveBackward`, which I do to make the test pass. But once the tests are passing, I can refactor it:

```csharp
public void MoveBackward(int spaces)
{
    switch (_direction)
    {
        // ...
    }

    DropPresents();
}
public void MoveForward(int spaces)
{
    switch (_direction)
    {
        // ...
    }

    DropPresents();
}

private void DropPresents()
{
    var matchingHouse = _neighborhoodHouses.SingleOrDefault(house => house.X == _xCoord && house.Y == _yCoord);

    if (matchingHouse != null && matchingHouse.RequestedPresents > 0)
    {
        var magicalExtraPresents = 1;
        _numberOfPresents -= (matchingHouse.RequestedPresents + magicalExtraPresents);
    }
}
```

Next up, we'll verify that multiple houses reduce the presents by the expected amount.

```csharp
[Test]
public void RemainingPresents_WhenStoppingOverMultipleHouses_ReducesAsExpected()
{
    var gridSize = 5;
    var totalPresents = 10;
    var house1 = new NeighborhoodHouse(0, 1, 2);
    var house2 = new NeighborhoodHouse(0, 2, 3);
    var houseList = new List<NeighborhoodHouse> { house1, house2 };
    var sut = new SantaSleigh(gridSize, totalPresents, houseList);

    sut.MoveForward(1); // now at 1 on y axis, dropping 2 + 1 = 3 presents
    sut.MoveForward(1); // now at 2 on y axis, dropping 3 + 1 = 4 presents

    var result = sut.RemainingPresents();
    result.Should().Be(3);
}
```

This test also passes right way so we again change our production code to make it fail on purpose in order to check it.

Next, we need to confirm that houses won't receive presents twice:

```csharp
[Test]
public void RemainingPresents_WhenStoppingOverAHouseTwice_OnlyDecrementsTheFirstTime()
{
    var gridSize = 5;
    var totalPresents = 10;
    var house1 = new NeighborhoodHouse(0, 1, 2);
    var houseList = new List<NeighborhoodHouse> { house1 };
    var sut = new SantaSleigh(gridSize, totalPresents, houseList);

    sut.MoveForward(1); // now at 1 on y axis, dropping 2 + 1 = 3 presents
    sut.MoveForward(1); // going past the location
    sut.MoveBackward(1); // going back to the location

    var result = sut.RemainingPresents();
    result.Should().Be(7);
}
```

We then update the `DropPresents` method to ensure the house is removed from the list once it's been served:

```csharp
private void DropPresents()
{
    var matchingHouse = _neighborhoodHouses.SingleOrDefault(house => house.X == _xCoord && house.Y == _yCoord);

    if (matchingHouse != null && matchingHouse.RequestedPresents > 0)
    {
        var magicalExtraPresents = 1;
        _numberOfPresents -= (matchingHouse.RequestedPresents + magicalExtraPresents);
        _neighborhoodHouses.Remove(matchingHouse);
    }
}
```

Now, we'd decided earlier that if a house was on the the line in-between two points, we wouldn't drop presents as we flew over; we'd need to actually land on the coordinate to drop a present. This is a sort of implicit requirement, so I find it's helpful to make these choices explicit in case anyone should come across the code and be curious.

```csharp
[Test]
public void RemainingPresents_WhenPassingOverAHouse_DoesNotDecrement()
{
    var gridSize = 5;
    var totalPresents = 10;
    var house1 = new NeighborhoodHouse(0, 1, 2);
    var house2 = new NeighborhoodHouse(0, 3, 3);
    var houseList = new List<NeighborhoodHouse> { house1, house2 };
    var sut = new SantaSleigh(gridSize, totalPresents, houseList);

    sut.MoveForward(2); // now at 2 on y axis, skipping the first house
    sut.MoveForward(1); // now at 3 on y axis, dropping 3 + 1 = 4 presents

    var result = sut.RemainingPresents();
    result.Should().Be(6);
}
```

**Side Note on Comments**: Wherever I can, I like the code to be as clear as possible about what it's doing conceptually, to eliminate the need for a lot of extraneous comments. But I really find comments helpful when they help my mental model or allow me to quickly wrap my head around something at a glance. In some of the tests above, I've added comments so that it should be clear about exactly what's happening and why I structured the test as I did. If future me returns to those tests, I should be able to quickly dive in and understand the landscape.
{: .notice--info}

{% include santa_checkpoint.html tagname="nunit-07-presents" priorTag="nunit-06-wrapping" %}

## Our Last Tests...and They're Exceptional.

The last requirement we had was to throw an `Exception` in the truly exceptional, unthinkable case where Santa may not have enough presents to go around.

The requirements seem to leave some choices to us. We could create a new `Exception` with a specific message, or we could create our own `OutOfPresentsException` that inherits from Exception. For the sake of this example, we'll create our own type of Exception.

```csharp
[Test]
public void ThrowsExceptionWhenNotEnoughPresentsRemain()
{
    var requestedPresents = 3;
    var totalPresents = 3; // so Santa can't fulfill the +1 rule.
    var gridSize = 5;
    var house1 = new NeighborhoodHouse(0, 1, requestedPresents);
    var houseList = new List<NeighborhoodHouse> { house1 };
    var sut = new SantaSleigh(gridSize, totalPresents, houseList);

    Action action = () => sut.MoveForward(1);

    action.Should().Throw<OutOfPresentsException>().And.Message.Should().Be("I'm so-ho-ho sorry!");
}
```

As we might expect, this test fails because the exception type does not currently exist. So we'll add it to our production code:

```csharp
public class OutOfPresentsException : Exception
{
    public OutOfPresentsException(string message) : base(message) { }
}
```

Now the test will fail because we're not actually throwing the exception, so we'll do so in the `DropPresents` method:

```csharp
private void DropPresents()
{
    var matchingHouse = _neighborhoodHouses.SingleOrDefault(house => house.X == _xCoord && house.Y == _yCoord);

    if (matchingHouse != null && matchingHouse.RequestedPresents > 0)
    {
        var magicalExtraPresents = 1;
        var presentsToDecrement = matchingHouse.RequestedPresents + magicalExtraPresents;
        if (_numberOfPresents - presentsToDecrement < 0)
        {
            throw new OutOfPresentsException("I'm so-ho-ho sorry!");
        }
        _numberOfPresents -= presentsToDecrement;
        _neighborhoodHouses.Remove(matchingHouse);
    }
}
```

{% include santa_checkpoint.html tagname="nunit-08-exception" priorTag="nunit-07-presents" %}

## So, Let's See How We did.

Reviewing the original problem statement:

> We are on a square grid that represents a neighborhood using x and y coordinates.

We're handling this just fine.

> We are given the initial size of the grid, a starting number of presents, and a list of points with houses and how many presents are requested for them.

Check.

> Santa's sleigh starts facing North at coordinate 0,0.

Yep, we have tests for this.

> As Santa's sleigh passes over a house, it drops the required number of presents + 1 (as Santa always wants to be extra kind).

Got it!

> Implement wrapping at edges, because planets are spheres.

Done.

> And, though this will surely never happen in real life, we'll throw an `Exception` if we pass over a house and don't have enough presents to provide.

It's covered!

At this point, we have a solid 80 tests, and many more being generated by FsCheck and our test cases. I think we can call this problem complete!

## Thanks for Reading, and Happy Holidays!

I'd love your feedback and comments on this post or any of the associated code. Feel free to drop me a line in the comments or privately anytime!

I hope you and yours are happy and healthy this holiday season, and that you get everything you could possibly want.

I'd love to keep in touch! Feel free to follow on [Twitter at @sjkilleen](https://twitter.com/sjkilleen), [Twitch @sjkilleen](https://twitch.tv/sjkilleen). Don't forget to add this blog to your feeds to receive the latest posts. And again, feedback is welcome anytime through any channel. Thanks again!
