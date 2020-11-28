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
While [porting the NUnit docs to a new, modern web site](https://seankilleen.com/2020/07/announcement-i-am-now-the-lead-for-the-nunit-docs-project/) I had a great opportunity -- to actually read a ton of the docs!

I've used NUnit for a long time in various cases, but I still learned a bunch of new things. I'll highlight a few here below in case you were less familiar as well.

## Combinatorial Testing with The `[Combinatorial]` and `[Pairwise]` Testing Attributes

Sometimes, you have two or three inputs to a test and you want to ensure that every possible combination of those inputs is tested. You could manually create `TestCase` entries to accomplish this, but what happens if a change to your inputs occur?

The [`Combinatorial` attribute](https://docs.nunit.org/articles/nunit/writing-tests/attributes/combinatorial.html) ensures that NUnit generates tests for all possible combinations of your test input.

For example, the below code will generate 27 tests, one for each possible combination of inputs:

```csharp
public class AdditionTests
{
    [Test, Combinatorial]
    public void LinqSumIsEqualToTraditionalSum(
      [Values(1,2,3)] int number1,
      [Values(1, 2, 3)] int number2,
      [Values(1, 2, 3)] int number3)
    {
        var traditional = number1 + number2 + number3;
        var linq = new[] {number1, number2, number3}.Sum();

        Assert.That(linq, Is.EqualTo(traditional));
    }
}
```

We can see the output below:

![The resulting 27 tests passing, showing some of the combinations]({{site.post-images}}/2020-cool-things-nunit/GeneratedTests.png)

The `[Pairwise]` attribute works similarly to the `[Combinatorial]` attribute, but rather than executing every input against each other, it reduces the test cases to only those that actually test a unique combination. This avoids duplicate tests and longer executions.

These options are a nice gateway to property-based testing as well. More on that in a future post.

## Multiple Assertions Gracefully Using `Assert.Multiple`

I try not to create multiple assertions in my tests, because:

* I generally believe that those belong in separate tests so that I can more easily triangulate failures or issues
* A test may fail at the first assertion, and upon fixing that, you may discover that the second assertion fails as well.
* I believe that a test that is asserting multiple things is usually doing too much.

However, there are some cases where a number of assertions help clarify a logical assertion (and where additional tests would feel like overkill or be less clear). In these cases, you can use NUnit's `Assert.Multiple` syntax to your benefit.

```csharp
Assert.Multiple(() => {
  // assertions to assert
  });
```

The below test, for example, will generate two test failures, rather than stopping at the first failure:

```csharp
[Test]
public void AssertingMultipleThings()
{
    Assert.Multiple(() =>
    {
        Assert.That(1+1,Is.EqualTo(3));
        Assert.That(DateTime.Now.Year, Is.EqualTo(2050));
    });
}
```

In my test runner output, I see failures at both lines, rather than the first, and I see information about both sets of expected and actual values.

## Asserting Your Assumptions for Better Clarity using `Assume.That` and `Warn.If`

This is another helper that assists with some "smelly" tests.

Tests can sometimes fail due to their setup, their data, or other state in your tests. Ideally, you'd want to write your unit tests with as little state as possible and ensure they will work reliably, but crafting a complete test suite that allows for this isn't possible in every case. For example, say I have an integration test that relies on an actual web service. Ideally, I'd want to mock out that web service or use some sort of reply testing to mimic its behavior. But if I'm writing an acceptance test, it may be that I want to use real components.

In that situation, how do I handle it if the web service is unavailable? I could fail the test, but the problem isn't necessarily in my code itself, it's in a pre-requisite for the test, or part of the universe of the test that has to be true in order for the test to have value.

There's an `Assume.That` syntax which works like an assertion but sets the test to `Inconclusive` instead of `Failed`. So you can use it to assert things that need to be true for the test to make sense. While this is a bit of a smell, I can see it being potentially useful in integration tests.

For example, the below test will fail:

```csharp
[Test]
public void WebServiceIntegrationTest()
{
    var isAvailable = true; // hard-coded for example
    Assume.That(isAvailable, Is.True);

    var result = CallWebService();

    Assert.That(result, Is.True);
}

private bool CallWebService()
{
    return false;
}
```

But if I change `isAvailable` to `false` and re-run:

```csharp
[Test]
public void WebServiceIntegrationTest()
{
    var isAvailable = false; // hard-coded for example
    Assume.That(isAvailable, Is.True);

    var result = CallWebService();

    Assert.That(result, Is.True);
}

private bool CallWebService()
{
    return false;
}
```

I can see NCrunch reports in its test output:

> NCrunch: This test reported an inconclusive result.

Similarly, there's a `Warn.If` syntax that is useful for integration tests; it will tell you if something smelly might be happening.

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
