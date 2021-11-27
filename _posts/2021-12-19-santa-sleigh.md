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
  - specflow
date: 2021-12-19 00:01 -0400
#excerpt: "TODO"
#header:
#  overlay_image: /images/overlays/unsplash/ehimetalor-akhere-unuabona-TvJk52iLxQA-unsplash2.jpg
#  overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
#  caption: "Photo credit: [**Ehimetalor Akhere Unuabona @ Unsplash**](https://unsplash.com/@theeastlondonphotographer?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"

---

Happy Holiday season, everyone! I'm happy to have snagged one of the spots in this year's [C# Advent Calendar](https://www.csadvent.christmas).

I'm a big fan of automated testing, but I know that many developers in the C# space are still getting used to some of the concepts, so I figured we'd take a this space to do a gentler introduction to test automation with a slightly contrived scenario.

If you're already very used to automated testing, or have very strong opinions on it, this post likely won't be for you as it's meant to be a gentle introduction to applying some of the concepts. But I hope you'll get something useful out of it!

## How To Use this Post

* TODO: Using multiple testing frameworks and approaches so you can follow along in the language of your choice
* TODO: Different posts
* TODO: Code in branches in a GitHub repository, can check out along the way

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
> * int GetX()
> * int GetY()

If you've ever seen [the Mars Rover kata](https://katalyst.codurance.com/mars-rover) before, then this problem will look slightly familiar.

## Breaking the Problem Down

Let's think about what the problem says (and doesn't say):

* We'll receive the size of the grid
* We'll receive a list with points and a number of presents
* We'll receive a starting number of presents
* We'll start at 0 x and 0 y
* We'll start facing north
* There's no restriction on what we can do with the constructor of the object; only on its public methods. This will give us some flexibility in how we implement the solution.
* We have directions and turn methods, so turning is implied
* We have the ability to move forward and backward across x and y coordinates based on direction
* We'll have to do some sort of check on the count of presents as we drop them.

This can start to feel overwhelming, or we might have an idea of how we want to jump in. However, we'll want to think about the simplest things we can test first, just to get some momentum and avoid getting ahead of ourselves.

## Picking a Starting Point

In this case, I think about the starting coordinates and turning as a good starting point for tests. We can ignore almost all of the setup, the coordinates, etc. and still get some reliable tests under our belt. So, we'll start there.

## Setting up Our Solution

_To see the code with this step complete, use tag `all-01-emptyproject`._

For this example, we'll create two projects in the same solution:

* `SantaSleigh`, a project that will hold our production code
* `SantaSleigh.Tests`, a project that will hold our test code and reference the production code.

If you've got modern .NET (e.g. [.NET 6](https://dotnet.microsoft.com/download/dotnet/6.0) or similar) installed, we can use the command line to spin this up:

* Create a folder for this workspace
* Open a command prompt and head to that folder

## Choose Your Own Adventure!
