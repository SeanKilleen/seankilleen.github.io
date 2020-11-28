---
title: Cool things I learned about NUnit while re-launching the docs
comments: true
tags:
  - nunit
  - docs
  - testing
  - csharp
  - libraries
date: 2020-11-28 11:28 -0500
---
While [porting the NUnit docs to a new, modern web site](https://seankilleen.com/2020/07/announcement-i-am-now-the-lead-for-the-nunit-docs-project/) I had the rare opportunity -- to actually read a ton of the docs! 

I've used NUnit for a long time in various cases, but I still learned a bunch of new things. I'll highlight a few here below in case you were less familiar as well.

## Combinatorial Testing with The [Combinatorial] and [Pairwise] Testing Attributes

TODO

## Multiple Assertions with More Information Using Assert.Multiple

I try not to create multiple assertions in my tests, because: 

* I generally believe that those belong in separate tests so that I can more easily triangulate
* A test will fail at the first assertion, and upon fixing that, you may discover that the second assertion fails.
* I believe that a test that is asserting multiple things is usually doing too much.

However, there are some cases where a number of assertions helps clarify a logical assertion where additional tests would feel like overkill or be less clear. In these cases, you can use NUnit's `Assert.Multiple` syntax to your benefit.

```csharp
Assert.Multiple(() => { // things to assert });
```

TODO: Exmaple

## Asserting Your Assumptions for Better Clarity with Assume.That and Warn.If

This is another helper that assists with some "smelly" tests.

Tests can sometimes fail due to their setup, their data, or other state in your tests. Ideally, you'd want to write your unit tests with as little state as possible and ensuring they will work reliably, but crafting a test suite that allows for this isn't possible in every case. For example, say I have a test that relies on an actual web service. Ideally I'd want to mock out that web service or use some sort of reply testing to mimic its behavior. But if I'm writing an acceptance test, it may be that I want to use real components.

In that situation, how do I handle it if the web service is unavailable? I could fail the test, but the problem isn't necessarily in my code itself, it's in a pre-requisite for the test, or part of the universe of the test that has to be true in order for the test to have value.

TODO: There's an Assume.That syntax which works like an assertion but sets the test to Inconclusive instead of failed. So you can use it to assert things that need to be true for the test to make sense. While this is a bit of a smell, I can see it being potentially useful in integration tests.

TODO: Similarly, there's a Warn.If syntax that is mentioned as being useful for integration tests that will tell you if something smelly might be happening.

## Bring Your Own Comparisons

Occasionally, you may need to compare objects in your test. Perhaps you have a complex sort of comparison that you'd like to check, which involves testing three different properties to ensure something is equal. In your unit test, you might need to do something like:

```csharp
// TODO: example of comparing multiple properties
```

This seems a little unclean and it can be hard to re-use in your tests.

Instead, you can now use a custom comparer to achieve this.

TODO: custom comparers for greater than, etc. e.g `Assert.That(myOwnObject, Is.GreaterThan(theExpected).Using(myComparer));`

```csharp
// TODO
```

I had a blast learning about these. Check out [the NUnit docs](https://nunit.org/docs/) and let us know if you find any of your own fun tips, or have any to add!
