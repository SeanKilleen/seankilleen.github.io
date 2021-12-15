---
title: "Ensuring Santa's Success With Automated Tests (C# Advent 2021)"
comments: true
tags:
  - csharp
  - advent
  - testing
  - automation
  - nunit
  - xunit
date: 2021-12-19 00:01 -0400
excerpt: "An exploration of TDD in the spirit of the season."
header:
 overlay_image: /images/overlays/unsplash/hue12-photography-2qzZubxw7WE-unsplash.jpg
 overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
 caption: "Photo credit: [**hue12 Photography @ Unsplash**](https://unsplash.com/@hue12_photography?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"

---

Happy Holiday season, everyone! I'm happy to have snagged one of the spots in this year's [C# Advent Calendar](https://www.csadvent.christmas). Be sure to check out the other 49 great posts when you're done here!

_____

I'm a big fan of automated testing, but I know that many developers in the C# space are still getting used to some of the concepts, so I figured we'd take this time to do a gentler introduction to test automation with a slightly contrived scenario, and solve it using NUnit, xUnit, and SpecFlow.

If you're already very used to automated testing, or have very strong opinions on it, this post likely won't be for you as it's meant to be a gentle introduction to applying some of the concepts. But I hope you'll get something useful out of it regardless!

## Thanks!

Before I begin, some thank-yous are in order:

* Thank you to [Joseph N. Musser](https://twitter.com/jnm236), NUnit team member and much more, for a thorough review and catching way more typos than I hoped existed.
* Thanks to [Khalid Abuhakmeh](https://twitter.com/buhakmeh) for looking this over and suggesting some good changes.
* Thank you to every open-source author, contributor, maintainer, and champion. Every bit of this tutorial is brought to you by OSS, and I'm forever grateful for what standing on the shoulders of giants has enabled me to accomplish.

## How To Read this Post

Before jumping in, some words on how this post is structured:

* I wanted to provide examples of different frameworks. So, this post is actually 4 posts. This introductory post where we get things set up, and then a choose your own adventure where you can walk through the solution using NUnit, xUnit, or SpecFlow. See the bottom of this post for those links.
* The code for all of these examples is stored in a repository (link). The different solutions will evolve in their separate branches, and [are tagged at each step along the way](https://github.com/SeanKilleen/SantaSleigh/tags).
* There's no way a blog post tutorial can cover all of the concepts; I've taught multi-day courses on this. I hope it gives you some insight into a process, allows you to explore at your own pace, and piques your interest in a topic that I think is crucial for software development.
* **I'd love your feedback and questions!** I haven't explored this kind of long-form tutorial in a blog format yet really and I'd love your feedback on changes I could make or different approaches that would make this post more effective for you. Consider this a living page; I plan to continue to improve it based on feedback.

## The Challenge

Here's the problem statement:

> We are on a square grid that represents a neighborhood using x and y coordinates. We are given the initial size of the grid, a starting number of presents, and a list of points with houses and how many presents are requested for them. Santa's sleigh starts facing North at coordinate 0,0. As Santa's sleigh passes over a house, it drops the required number of presents + 1 (as Santa always wants to be extra kind). Implement wrapping at edges, because planets are spheres. And, though this will surely never happen in real life, we'll throw an `Exception` if we pass over a house and don't have enough presents to provide.
>
> The only public methods of our `SantaSleigh` object:
>
> * void MoveForward (int spaces)
> * void MoveBackward (int spaces)
> * void TurnLeft()
> * void TurnRight()
> * int RemainingPresents()
> * int GetXCoordinate()
> * int GetYCoordinate()

If you've ever seen [the Mars Rover Coding Exercise](https://katalyst.codurance.com/mars-rover) before, then this problem will look slightly familiar.

**Assuming valid data:** For simplicity's sake, we will be assuming all inputs to generally be in the correct ranges. For example, we could add a lot of tests for validation to ensure the `SantaSleigh` isn't initialized with `-10` presents, but it would feel like clutter as we went through the tutorial. Typically, production code would also include tests to ensure you take appropriate action on invalid inputs.
{: .notice--info}

## Breaking the Problem Down

Let's think about what the problem says (and doesn't say):

* We'll receive the size of the grid
* We'll receive a list with points and a number of presents
* We'll receive a starting number of presents
* We'll start at 0 `x` and 0 `y` coordinates
* We'll start facing north
* There's no restriction on what we can do with the constructor of the object; only on its public methods. This will give us some flexibility in how we implement the solution.
* We have directions and turn methods, so turning is implied
* We have the ability to move forward and backward across x and y coordinates based on direction
* We'll need to thoroughly test the logic
* We'll have to do some sort of check on the count of presents as we drop them.

This can start to feel overwhelming, or we might have an idea of how we want to jump in. However, we'll want to think about the simplest things we can test first, just to get some momentum and avoid getting ahead of ourselves.

## Picking a Starting Point

In this case, I think about the starting coordinates and turning as a good starting point for tests. We can ignore almost all of the setup, the coordinates, etc. and still get some reliable tests under our belt. So, we'll start there.

## Setting up Our Solution

_To check out the code with this step complete so you can follow along, use tag `01-emptyproject`._

For this example, we'll create two projects in the same solution:

* `SantaSleighCode`, a project that will hold our production code
* `SantaSleighCode.Tests`, a project that will hold our test code and reference the production code.

### From the Command Line

If you've got modern .NET (e.g. [.NET 6](https://dotnet.microsoft.com/download/dotnet/6.0) or similar) installed, we can use the command line to spin this up:

* Create a folder for this workspace
* Open a command prompt and head to that folder
* Create the solution file:

```console
dotnet new sln --name CSharpAdvent
```

* Create the Source Code Project:

```console
dotnet new classlib --name SantaSleighCode --framework net6.0
```

* Create the Test Project:

```console
dotnet new classlib --name SantaSleighCode.Tests --framework net6.0
```

Note: There are actually some test project templates out there that will make this easier, but we're doing a bit of minimal setup so that we can add whatever libraries we want in the coming parts of the tutorial.

* Add both projects to the solution file:

```console
dotnet sln add SantaSleighCode
dotnet sln add SantaSleighCode.Tests
```

* Make the test project reference the production code project:

```console
cd .\SantaSleighCode.Tests\
dotnet add reference ../SantaSleighCode
```

### From Visual Studio

* Create a new solution using the name above
* Create the two projects using the names above by using the `New Project` dialog and choosing a Class Library project in each case.
* Right-click on the test project and choose `Add --> Reference` from the menu
* Select the production code project and click OK to add the reference.

## Choose Your Own Adventure!

Now that we've got the projects set up, it's time to choose which testing framework you'd like to use next.

* [NUnit implementation]({% link _posts/2021-12-19-santa-sleigh-nunit.md %})
* [xUnit implementation]({% link _posts/2021-12-19-santa-sleigh-xunit.md %})

## Thanks!

I'd love to keep in touch! Feel free to follow on [Twitter at @sjkilleen](https://twitter.com/sjkilleen), [Twitch @sjkilleen](https://twitch.tv/sjkilleen). Don't forget to add this blog to your feeds to receive the latest posts. And again, feedback is welcome anytime through any channel. Thanks again!
