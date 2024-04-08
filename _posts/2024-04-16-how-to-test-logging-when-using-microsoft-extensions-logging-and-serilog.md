---
title: "How To: Test Logging when Using Microsoft.Extensions.Logging and Serilog"
comments: true
tags:
  - dotnet
  - .NET
  - tdd
  - testing
  - serilog
date: 2024-04-16 07:00 -0400
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

* `[Serilog.Sinks.InMemory](https://github.com/serilog-contrib/SerilogSinksInMemory)`
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
        var builder = WebApplication.CreateBuilder([]);
        builder.Logging.AddSerilog(new LoggerConfiguration().WriteTo.InMemory().CreateLogger());
        _app = builder.Build();
    }

    [OneTimeTearDown]
    public void OneTimeTearDown()
    {
        _app?.DisposeAsync();
    }

    [SetUp]
    public void Setup()
    {
        _mockUncachedService = new Mock<IODataService>();
        _mockDistributedCache = new Mock<IDistributedCache>();
        var logger = _app!.Services.GetRequiredService<ILogger<CachedODataService>>();
        _sut = new CachedODataService(logger, _mockUncachedService.Object, _mockDistributedCache.Object);
    }

    [TearDown]
    public void Teardown()
    {
        InMemorySink.Instance.Dispose();
    }

    [Test]
    public void ConfigureODataHttpClient_CallsUnderlyingUncachedDataSource()
    {
        _sut.ConfigureODataHttpClient("A", "B", "C");

        _mockUncachedService.Verify(x => x.ConfigureODataHttpClient("A", "B", "C"), Times.Once);
    }

    [Test]
    public async Task ABAPPassthroughRequest_CallsUnderlyingUncachedDataSource()
    {
        await _sut.ABAPPassthroughRequest(new PassthroughXmlRequest {Request = "BLAH"});

        _mockUncachedService.Verify(x => x.ABAPPassthroughRequest(It.Is<PassthroughXmlRequest>(request=>request.Request == "BLAH")), Times.Once);
    }

    [Test]
    public async Task GetCarrier_WhenErrorOnGettingCacheValue_LogsError()
    {
        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).Throws(new Exception("Error"));

        await _sut.GetCarrier("Customer", "Carrier");

        InMemorySink.Instance.Should()
            .HaveMessage("Error retrieving cached carrier information for Customer '{CustomerCode}' Carrier '{CarrierCode}'. Returning non-cached value. Error: {ErrorMessage}")
                .WithProperty("CustomerCode").WithValues("Customer").And
                .WithProperty("CarrierCode").WithValues("Carrier").And
                .WithProperty("ErrorMessage").WithValues("Error");
    }

    [Test]
    public async Task GetCarrier_WhenErrorOnGettingCacheValue_CallsUnderlyingUncachedDataSource()
    {
        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).Throws(new Exception("Error"));
        _mockUncachedService.Setup(x => x.GetCarrier("Customer", "Carrier")).ReturnsAsync(new XPSCarrierConfig(){CustomerCode = "UnderlyingCustomer", CarrierCode = "UnderlyingCarrier"});

        var result = await _sut.GetCarrier("Customer", "Carrier");

        _mockUncachedService.Verify(x => x.GetCarrier("Customer", "Carrier"), Times.Once);
        result.CustomerCode.Should().Be("UnderlyingCustomer");
        result.CarrierCode.Should().Be("UnderlyingCarrier");
    }

    [Test]
    public async Task GetCarrier_WhenCacheValueIsNull_CallsUnderlyingUncachedDataSource()
    {
        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).ReturnsAsync((byte[]?)null);
        _mockUncachedService.Setup(x => x.GetCarrier("Customer", "Carrier")).ReturnsAsync(new XPSCarrierConfig() { CustomerCode = "UnderlyingCustomer", CarrierCode = "UnderlyingCarrier" });

        var result = await _sut.GetCarrier("Customer", "Carrier");

        _mockUncachedService.Verify(x => x.GetCarrier("Customer", "Carrier"), Times.Once);
        result.CustomerCode.Should().Be("UnderlyingCustomer");
        result.CarrierCode.Should().Be("UnderlyingCarrier");
    }

    [Test]
    public async Task GetCarrier_WhenCacheValueIsNull_AttemptsToCacheResultItGets()
    {
        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).ReturnsAsync((byte[]?)null);
        _mockUncachedService.Setup(x => x.GetCarrier("Customer", "Carrier")).ReturnsAsync(new XPSCarrierConfig() { CustomerCode = "UnderlyingCustomer", CarrierCode = "UnderlyingCarrier" });

        await _sut.GetCarrier("Customer", "Carrier");

        _mockDistributedCache.Verify(x => x.SetAsync(It.IsAny<string>(), It.IsAny<byte[]>(), It.IsAny<DistributedCacheEntryOptions>(), default), Times.Once);
    }

    [Test]
    public async Task GetCarrier_WhenCacheValueIsNull_AndCacheBlowsUpOnSetAction_StillReturnsUncachedValue()
    {
        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).ReturnsAsync((byte[]?)null);
        _mockDistributedCache.Setup(x => x.SetAsync(It.IsAny<string>(), It.IsAny<byte[]>(), It.IsAny<DistributedCacheEntryOptions>(), default)).Throws(new Exception("Error"));
        _mockUncachedService.Setup(x => x.GetCarrier("Customer", "Carrier")).ReturnsAsync(new XPSCarrierConfig() { CustomerCode = "UnderlyingCustomer", CarrierCode = "UnderlyingCarrier" });

        var result = await _sut.GetCarrier("Customer", "Carrier");

        _mockUncachedService.Verify(x => x.GetCarrier("Customer", "Carrier"), Times.Once);
        _mockDistributedCache.Verify(x => x.SetAsync(It.IsAny<string>(), It.IsAny<byte[]>(), It.IsAny<DistributedCacheEntryOptions>(), default), Times.Once);

        result.CustomerCode.Should().Be("UnderlyingCustomer");
        result.CarrierCode.Should().Be("UnderlyingCarrier");
    }

    [Test]
    public async Task GetCarrier_WhenExistingValue_AndSerializedFine_ReturnsValue()
    {
        var knownGoodValue = new XPSCarrierConfig() { CustomerCode = "SeanCustomer", CarrierCode = "SeanCarrier" };
        var knownGoodValueString = System.Text.Json.JsonSerializer.Serialize(knownGoodValue);
        var knownGoodValueBytes = System.Text.Encoding.UTF8.GetBytes(knownGoodValueString);

        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).ReturnsAsync(knownGoodValueBytes);

        var result = await _sut.GetCarrier("Customer", "Carrier");

        result.CustomerCode.Should().Be("SeanCustomer");
        result.CarrierCode.Should().Be("SeanCarrier");
    }

    [Test]
    public async Task GetCarrier_WhenExistingValue_AndIsSerializedToNull_LogsError()
    {
        var nullJsonValueAsString = "null";
        var nullValueBytes = System.Text.Encoding.UTF8.GetBytes(nullJsonValueAsString);

        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).ReturnsAsync(nullValueBytes);

        await _sut.GetCarrier("Customer", "Carrier");

        InMemorySink.Instance.Should()
            .HaveMessage("Issue deserializing cached carrier information for Customer '{CustomerCode}' Carrier '{CarrierCode}': The deserialized carrier was null. Calling OData directly.")
            .WithProperty("CustomerCode").WithValues("Customer").And
            .WithProperty("CarrierCode").WithValues("Carrier");
    }

    [Test]
    public async Task GetCarrier_WhenExistingValue_AndIsSerializedToNull_ReturnsUncachedValue()
    {
        var nullJsonValueAsString = "null";
        var nullValueBytes = System.Text.Encoding.UTF8.GetBytes(nullJsonValueAsString);

        _mockUncachedService.Setup(x => x.GetCarrier("Customer", "Carrier")).ReturnsAsync(new XPSCarrierConfig() { CustomerCode = "UnderlyingCustomer", CarrierCode = "UnderlyingCarrier" });
        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).ReturnsAsync(nullValueBytes);

        var result = await _sut.GetCarrier("Customer", "Carrier");

        result.CustomerCode.Should().Be("UnderlyingCustomer");
        result.CarrierCode.Should().Be("UnderlyingCarrier");
    }

    [Test]
    public async Task GetCarrier_WhenExistingValue_AndErrorSerializingIt_LogsError()
    {
        var nullJsonValueAsString = "BOOM";
        var nullValueBytes = System.Text.Encoding.UTF8.GetBytes(nullJsonValueAsString);

        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).ReturnsAsync(nullValueBytes);

        await _sut.GetCarrier("Customer", "Carrier");

        InMemorySink.Instance.Should()
            .HaveMessage("Error deserializing cached carrier information for Customer '{CustomerCode}' Carrier '{CarrierCode}'. Returning non-cached value. Error: {ErrorMessage}")
            .WithProperty("CustomerCode").WithValues("Customer").And
            .WithProperty("CarrierCode").WithValues("Carrier").And
            .WithProperty("ErrorMessage").WithValues("'B' is an invalid start of a value. Path: $ | LineNumber: 0 | BytePositionInLine: 0.");
    }

    [Test]
    public async Task GetCarrier_WhenExistingValue_AndErrorSerializingIt_ReturnsUncachedValue()
    {
        var nullJsonValueAsString = "BOOM";
        var nullValueBytes = System.Text.Encoding.UTF8.GetBytes(nullJsonValueAsString);

        _mockUncachedService.Setup(x => x.GetCarrier("Customer", "Carrier")).ReturnsAsync(new XPSCarrierConfig() { CustomerCode = "UnderlyingCustomer", CarrierCode = "UnderlyingCarrier" });
        _mockDistributedCache.Setup(x => x.GetAsync(It.IsAny<string>(), default)).ReturnsAsync(nullValueBytes);

        var result = await _sut.GetCarrier("Customer", "Carrier");

        result.CustomerCode.Should().Be("UnderlyingCustomer");
        result.CarrierCode.Should().Be("UnderlyingCarrier");
    }
}
```

## Trade-offs

This approach might seem a little heavy handed. I mean -- do we really need to create a WebApplication builder to get the `ILogger<T>` set up?

I found that it made the rest of the process painless and didn't seem to add a ton of overhead, and it ensures that the `ILogger<T>` and `Serilog` outputs all play nicely together. And it enabled a very clean assertion, which I really enjoyed. So for me, it was worth it. I'd be interested to hear if there are alternative approaches that get close to this result without using a builder.

## Thank You, Once Again, to OSS

Big Thanks to [Sander van Vliet](https://github.com/sponsors/sandermvanvliet) for their work on a great library and contributing it to [the `serilog-contrib` org](https://github.com/serilog-contrib). Please sponsor them! I just did.

## What Do You Think?

How do you prefer to do this sort of assertion in this situation?

Until next time, happy logging!
