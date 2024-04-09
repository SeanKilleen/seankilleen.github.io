---
title: "How To: Test Logging when Using Microsoft.Extensions.Logging and Serilog"
comments: true
tags:
  - dotnet
  - .NET
  - tdd
  - testing
  - serilog
date: 2024-04-09 07:00 -0400
header:
  overlay_image: /images/overlays/unsplash/alex-jones-kFxWDfj0pD8-unsplash.jpg
  overlay_filter: 0.5
  caption: "Photo credit: [**Alex Jones @ Unsplash**](https://unsplash.com/@alexjones?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash)"
---
There are a lot of different ways to test logging, and quite a few opinions about how to do so. I recently found what feels like a very pleasant approach for my situation and I wanted to share it because still finding new ways to do this sort of thing still is lovely.

## Context

This solution may apply to you if:

* You are using `Microsoft.Extensions.Logging` so that you can inject `ILogger<T>` throughout your application.
* You are using `Serilog` as your main logging library.

## Challenges This Approach Aims to Solve

* Asserting against logging messages can be cumbersome
* Even when it works, you sometimes wind up with some pretty gnarly code to make it happen
* Typical approaches don't necessarily show how the logging output is received, which may be important, especially for structured logging.

## Get on With It -- Show Me the Code!

Below is an example test scenario where I need to ensure an error is logged with certain properties when things can't be cached. I've added comments in the C# code itself.

This code relies on two Nuget packages installed in my test project:

* [`Serilog.Sinks.InMemory`](https://github.com/serilog-contrib/SerilogSinksInMemory)
* `Serilog.Sinks.InMemory.Assertions` (same repo as above)

```csharp
public class CachedODataServiceTests
{
    private CachedODataService _sut = null!;
    private WebApplication? _app;
    private Mock<IODataService> _mockUncachedService = null!;
    private Mock<IDistributedCache> _mockDistributedCache = null!;

    [OneTimeSetUp]
    public void OneTimeSetup()
    {
        // This wires up Serilog to write to the InMemorySink variable we see below.
        var inMemoryLoggingConfig = new LoggerConfiguration().WriteTo.InMemory().CreateLogger()

        // Creating this builder allows us to add Serilog, which allows us to use Microsoft.Extensions.Logging
        // To get an ILogger<T> and have it use Serilog to write to the in-memory Sink.
        var builder = WebApplication.CreateBuilder([]);
        builder.Logging.AddSerilog(inMemoryLoggingConfig);
        _app = builder.Build();
    }

    [OneTimeTearDown]
    public void OneTimeTearDown()
    {
        // At the end of all tests, we need to dispose the app.
        _app?.DisposeAsync();
    }

    [SetUp]
    public void Setup()
    {
        // Set up our mocks so that we can make them do what we want during the test
        _mockUncachedService = new Mock<IODataService>();
        _mockDistributedCache = new Mock<IDistributedCache>();

        // Allows us to create the "SUT" or (Situation Under Test) using the ILogger and the Mocks
        var logger = _app!.Services.GetRequiredService<ILogger<CachedODataService>>();
        _sut = new CachedODataService(logger, _mockUncachedService.Object, _mockDistributedCache.Object);
    }

    [TearDown]
    public void Teardown()
    {
        // At the end of each test, we "Dispose" the InMemorySink, which resets its messages
        InMemorySink.Instance.Dispose();
    }

    [Test]
    public async Task GetCarrier_WhenErrorUponGettingCacheValue_LogsError()
    {
        // Make the cache throw an error
        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).Throws(new Exception("SeanError"));

        // Call the method that uses the cache
        await _sut.GetCarrier("Customer", "Carrier");\

        // Assert against the log message and its properties
        InMemorySink.Instance.Should()
            .HaveMessage("Error retrieving cached carrier information for Customer '{CustomerCode}' Carrier '{CarrierCode}'. Returning non-cached value. Error: {ErrorMessage}")
                .WithProperty("CustomerCode").WithValues("Customer").And
                .WithProperty("CarrierCode").WithValues("Carrier").And
                .WithProperty("ErrorMessage").WithValues("SeanError");
    }
}
```

## Trade-offs

This approach might seem a little heavy handed. I mean -- do we really need to create a WebApplication builder to get the `ILogger<T>` set up?

I found that it made the rest of the process painless and didn't seem to add a ton of overhead, and it ensures that the `ILogger<T>` and `Serilog` outputs all play nicely together. And it enabled a very clean assertion, which I really enjoyed. So for me, it was worth it. I'd be interested to hear if there are alternative approaches that get close to this result without using a builder.

## Thank You, Once Again, to OSS

Big Thanks to [Sander van Vliet](https://github.com/sponsors/sandermvanvliet) for their work on a great library and contributing it to [the `serilog-contrib` org](https://github.com/serilog-contrib). Please sponsor them! I just did.

## Bonus: Alternatives!

### Microsoft.Extensions.Hosting.Testing and a custom log sink

For those who are not using Serilog or who want something a little simpler, you can also use the `Microsoft.Extensions.Hosting.Testing` nuget package and do something along these lines:

```csharp
public class CachedODataServiceTests
{
    private CachedODataService _sut = null!;
    private IHost? _app;
    private Mock<IODataService> _mockUncachedService = null!;
    private Mock<IDistributedCache> _mockDistributedCache = null!;
    private readonly List<string> messages = new();

    [OneTimeSetUp]
    public void OneTimeSetup()
    {
        #pragma warning disable EXTEXP0016
        // The compiler warning is because this nuget is still experimental
        var builder = FakeHost.CreateBuilder();
        builder.AddFakeLoggingOutputSink(message =>
        {
            messages.Add(message);
        });
        #pragma warning restore EXTEXP0016
        _app = builder.Build();
    }

    [OneTimeTearDown]
    public void OneTimeTearDown()
    {
        // At the end of all tests, we need to dispose the app.
        _app?.Dispose();
    }

    [SetUp]
    public void Setup()
    {
        messages.Clear();

        // Set up our mocks so that we can make them do what we want during the test
        _mockUncachedService = new Mock<IODataService>();
        _mockDistributedCache = new Mock<IDistributedCache>();

        // Allows us to create the "SUT" or (Situation Under Test) using the ILogger and the Mocks
        var logger = _app!.Services.GetRequiredService<ILogger<CachedODataService>>();
        _sut = new CachedODataService(logger, _mockUncachedService.Object, _mockDistributedCache.Object);
    }

    [TearDown]
    public void Teardown()
    {
        messages.Clear();
    }

    [Test]
    public async Task GetCarrier_WhenErrorUponGettingCacheValue_LogsError()
    {
        // Make the cache throw an error
        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).Throws(new Exception("SeanError"));

        // Call the method that uses the cache
        await _sut.GetCarrier("Customer", "Carrier");

        // An assert against the string collection
        messages.Should().Contain(x => x.Contains("Error retrieving cached carrier information for Customer 'Customer' Carrier 'Carrier'. Returning non-cached value. Error: Error"));
    }
}
```

## What Do You Think?

How do you prefer to do this sort of assertion in this situation?

Until next time, happy logging!
