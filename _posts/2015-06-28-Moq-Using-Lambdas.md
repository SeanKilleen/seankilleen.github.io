---
title: "Quick Tip: When Testing with Moq, Try Lambdas for More Flexible Tests"
layout: default
date: 2015-06-28 22:34:00.000000000 -05:00
excerpt: "Who likes less test failures? I do!"
comments: true
---
Mocks are invaluable to the art of testing. For those who are unfamiliar, mocks are essentially a way to fake a component and have it do exactly what you want it to do (e.g. a validator that always fails, or a method that always returns `1` when given a certain parameter).

While I'm pretty library-agnostic[^1], I happen to be pretty familiar with [Moq](https://github.com/Moq/moq4) and so it's the one that I use most often.

I showed a tip to a developer recently and it struck me that it might be worth sharing with a wider audience.

A big challenge for tests is to keep them specific enough that they accurately capture what you're trying to do, but flexible enough that the smallest of changes won't break them. I prefer readability of each test over re-usability, but nobody likes fixing 20 tests with one minor change.

I see a lot of folks do things along the lines of the following:

```csharp
var mockLogger = new Mock<ILogger>();
var myClass = New MyClass(mockLogger.Object);

mockLogger.Verify(x=> x.Warning("Setting 'mySetting' has no value; using default of 1");
```

Now, this is all well and good. However, what if the default value changes? Or the name of the setting? The test is too brittle; it will fail easily.

However, when using Moq, it allows you to use a lambda to specify things *about* a string, rather than the whole string itself:

```csharp
mockLogger.Verify(x=> x.Warning(It.Is<string>(str => 
     str.Contains("Setting") && 
     str.Contains("has no value") && 
     str.Contains("using default"))));
```

This maintains the essence of the test, while at the same time fortifying it against things that might reasonably change. It's slightly more verbose, but I don't think that takes away from it much.

Have a different way of approaching mocks, mocking, or unit tests? I'd love to hear from you in the comments.

[^1]: I prefer *concepts* over *libraries*. If a developer understands what mocking is at is core, a library change should never phase them, though they should be able to express trade-offs.