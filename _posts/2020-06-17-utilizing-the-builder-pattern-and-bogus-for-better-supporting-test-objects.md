---
title: Utilizing Bogus with the Builder Pattern for better Mocks
comments: true
tags:
  - builder pattern
  - tests
  - automated tests
  - bogus
  - fake data
  - dotnet
  - .net
date: 2020-12-08 18:23 -0400
---

TODO: [let Brian Chavez know about this post](https://twitter.com/bchavez/status/1279054873191800832?s=20)

I was recently working with the excellent [Octokit.NET](https://github.com/octokit/octokit.net) library for working with GitHub, and like many developers, I needed to write a test.

I figured I'd give a quick run-down on the journey of that test, how I ultimately used the [Bogus](https://github.com/bchavez/Bogus) library to help wire up my fake, and then talk about some of the other great functionality of Bogus.

## Mocking a Large Object

I have a function in my app called `GetRepoQuotaFromOrg`. Its purpose is to use the Octokit library and pull in the repository quota that the organization has. I wanted to write a test that proves that demonstrates that my code is using the `PrivateRepos` field from the GitHub organization.

But, there's a challenge here. I need my mock `IOrganizationClient` client to return an `Organization` object. But here's the constructor for the `Organization` object:

> ![A constructor signature with a lot of required fields]({{site.post-images}}/2020-12_bogus/01_OrganizationObjectCtor.png)

That's a lot of required fields. With it, my first passing test looked like the gnarly beast below:

```csharp
[Fact]
public async Task GetsRepoLimitFromOrganizationPlan()
{
    var privateRepoLimit = 123;

    const int DUMMY_INT = 0;
    const long DUMMY_LONG = 0;
    var DUMMY_DATE = DateTimeOffset.MaxValue;

    var plan = new Plan(DUMMY_LONG, null, privateRepoLimit, DUMMY_LONG, null);
    var org = new Organization(null, null, null, DUMMY_INT,
        null, DUMMY_DATE, DUMMY_INT, null, DUMMY_INT, DUMMY_INT,
        null, null, DUMMY_INT, DUMMY_INT, null, null,
        null, null, DUMMY_INT, plan, DUMMY_INT, DUMMY_INT,
        DUMMY_INT, null, null);

    // Reader note: This, and _sut (my "situation under test") below, are part of the constructor and not fully
    // shown here because they are less relevant.
    _mockOrgClient.Setup(x =>
            x.Get(It.IsAny<string>()))
        .Returns(Task.FromResult(org));

    var result = await _sut.GetRepoQuotaForOrg();

    result.PrivateRepoLimit.Should().Be(privateRepoLimit);
}
```

Gross. Dummy values all over the place, and tons of noise in my test.

I could extract these to a method that takes a parameter, but I knew that I'd be using this construct in other test classes as well, so I decided to utilize the builder pattern.

## Introducing the Builder Pattern

I knew I would likely need default values for most items but the ability to override a select few fields. To be clear and intentional about this in my tests, I introduced an `OrganizationBuilder` to build an `Organization` object.

```csharp
public class OrganizationBuilder
{
    private long _privateRepoLimit = 0;
    private int _numberOfOwnedPrivateRepos = 0;

    public OrganizationBuilder WithPrivateRepoLimit(long limit)
    {
        _privateRepoLimit = limit;
        return this;
    }

    public OrganizationBuilder WithPrivateRepoCount(int privateRepoCount)
    {
        _numberOfOwnedPrivateRepos = privateRepoCount;
        return this;
    }

    public Organization Build()
    {
        const int DUMMY_INT = 0;
        const long DUMMY_LONG = 0;

        var DUMMY_DATE = DateTimeOffset.MaxValue;

        var plan = new Plan(DUMMY_LONG, null, _privateRepoLimit, DUMMY_LONG, null);

        var result = new Organization(null, null, null, DUMMY_INT,
            null, DUMMY_DATE, DUMMY_INT, null, DUMMY_INT, DUMMY_INT,
            null, null, DUMMY_INT, DUMMY_INT, null, null,
            null, null, _numberOfOwnedPrivateRepos, plan, DUMMY_INT, DUMMY_INT,
            DUMMY_INT, null, null);

        return result;
    }
}
```

Now my test looks much better:

```csharp
[Fact]
public async Task GetsRepoLimitFromOrganizationPlan()
{
    var privateRepoLimit = 123;

    // Way less noise!
    var org = new OrganizationBuilder().WithPrivateRepoLimit(123).Build();

    // Reader note: This, and _sut (my "situation under test") below, are part of the constructor and not fully
    // shown here because they are less relevant.
    _mockOrgClient.Setup(x =>
            x.Get(It.IsAny<string>()))
        .Returns(Task.FromResult(org));

    var result = await _sut.GetRepoQuotaForOrg();

    result.PrivateRepoLimit.Should().Be(privateRepoLimit);
}
```

But there are a few things I don't like still -- namely, all those dummy values still in my builder object. I'd prefer to populate them with legitimate values each time to make things a little more realistic. Enter the Bogus library.

## A Step Better: Using Bogus to Remove the Builder Pattern Cruft

Now, my `OrganizationBuilder` class looks a bit cleaner:

```csharp
public class OrganizationBuilder
{
    private readonly Faker<Organization> _faker = new Faker<Organization>();
    private readonly Faker<Plan> _planFaker = new Faker<Plan>();

    public OrganizationBuilder WithPrivateRepoLimit(long limit)
    {
        _planFaker.RuleFor(pl => pl.PrivateRepos, limit);
        return this;
    }

    public Organization Build()
    {
        var plan = _planFaker.Generate();
        _faker.RuleFor(x => x.Plan, plan);
        _faker.AssertConfigurationIsValid();
        return _faker.Generate();
    }

    public OrganizationBuilder WithPrivateRepoCount(int privateRepoCount)
    {
        _faker.RuleFor(x => x.OwnedPrivateRepos, privateRepoCount);
        return this;
    }
}
```

## Why Use Bogus?

Bogus certainly isn't the only library we could use here -- `AutoMoq` and `AutoFixture` both come to mind and the result so far could be achieved using any of them.
