---
title: How to Use Custom Comparers in NUnit
comments: true
tags:
  - nunit
date: 2020-11-28 16:29 -0500
---

Occasionally, you may need to compare objects in your test. Perhaps you have a complex sort of comparison that you'd like to check, which involves testing three different properties to ensure something is equal.

For example, let's say we had a class with the ability to represent Celsius and Farenheit temperatures:

```csharp
public enum TemperatureFormat
{
    Celsius,
    Fahrenheit
}

public class Temperature
{
    public TemperatureFormat Format { get; }
    public decimal Amount { get; }
    
    public Temperature(decimal temp, TemperatureFormat format)
    {
        Amount = temp;
        Format = format;
    }
}
```

If we want to compare them to see which is greater, we couldn't just compare the `Amount` fields on both entries. We would need to have additional conversion logic in place to ensure we were comparing the correct amounts. This seems a little unclean and it can be hard to re-use in your tests.

Instead, you can use a custom comparer to achieve this, by implementing your own Comparer and utilizing it.


## Writing the Comparer 

Below, we define the classes that would make up the comparer. These would go in your test project, unless you're making use of this comparer in your production code as well.

```csharp
public static class TemperatureMath
{
    // An extension method to convert Celsius to Fahrenheit, which we'll use in our Comparer
    public static decimal ToFahrenheit(this Temperature celsiusTemp)
    {
        return (celsiusTemp.Amount * (decimal)1.8) + 32;
    }
}

public class TemperatureComparer : Comparer<Temperature>
{
    // Get the Fahrenheit numbers for both temperatures and return a decimal-based Comparer that does the comparison on those values
    public override int Compare(Temperature x, Temperature y)
    {
        var xInFahrenheit = x.Format == TemperatureFormat.Fahrenheit ? x.Amount : x.ToFahrenheit();
        var yInFahrenheit = y.Format == TemperatureFormat.Fahrenheit ? y.Amount : y.ToFahrenheit();

        return Comparer<decimal>.Default.Compare(xInFahrenheit, yInFahrenheit);
    }
}

```

## Using the Comparer in Our Tests

Now that we have the Comparer defined, we can use it in our test: 

```csharp
public class TemperatureTests
{
    [Test]
    public void ZeroDegreesCelsius_Equals32DegreesFahrenheit()
    {
        var celsTemp = new Temperature(0, TemperatureFormat.Celsius);
        var farTemp = new Temperature(32, TemperatureFormat.Fahrenheit);

        var tempComparer = new TemperatureComparer();
        Assert.That(celsTemp, Is.EqualTo(farTemp).Using<Temperature>(tempComparer));
    }
}
```

## Other Things to Consider

* **Does the comparison belong in your production code?** In the example above, the comparison might best reside in the production code so that your logic would remain consistent.
