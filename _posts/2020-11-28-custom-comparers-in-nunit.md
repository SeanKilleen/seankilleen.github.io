---
title: Custom Comparers in NUnit
comments: true
tags:
  - nunit
date: 2020-11-28 16:29 -0500
---
## Bring Your Own Comparisons

Occasionally, you may need to compare objects in your test. Perhaps you have a complex sort of comparison that you'd like to check, which involves testing three different properties to ensure something is equal.

For example, let's say we had two classes, representing celsius and farenheit temperatures:

```csharp
public class CelsiusThing
{
    private decimal Temp { get; }

    public CelsiusThing(decimal temp) { Temp = temp; }
}

public class FarenheitThing
{
    private decimal Temp { get; }

    public CelsiusThing(decimal temp) { Temp = temp; }
}
```

If we wanted to compare them to see which was greater, we couldn't just compare the `Temp` fields on both classes.

Instead, we could use a custom comparer in our tests:

This seems a little unclean and it can be hard to re-use in your tests.

Instead, you can now use a custom comparer to achieve this.

TODO: custom comparers for greater than, etc. e.g `Assert.That(myOwnObject, Is.GreaterThan(theExpected).Using(myComparer));`

```csharp
// TODO
```
