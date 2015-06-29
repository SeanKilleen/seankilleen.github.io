---
title: "Why I Prefer xUnit over MSTest"
layout: post
date: 2015-06-28 22:34:00.000000000 -05:00
excerpt: "So, so many reasons."
comments: true
---
I was recently asked to explain[^1] my preference for xUnit over something like MSTest. To my surprise, while I felt very strongly -- and have for some time -- I struggled to clearly articulate my reasons. This is an attempt to get that part right. I sourced some help from folks on Twitter, who I'll be quoting here as well.

## First Thing First: Testing (and its Concepts) Matter Most
In my personal opinion, the time of debating whether or not to have automated tests is long past. There are trade-offs, sure. But particularly in a greenfield project with people who aren't completely new, testing should be commonplace. 

Also, while I'm about to contrast two testing frameworks, I can't stress enough that **developers should be able to use either**. Devs who are professionals should understand the common concepts and underpinnings of good tests[^2] and be able to apply them under any framework, and shouldn't balk at these things due to being forced into any particular framework.


## What I Like About xUnit
* **`[Fact]` vs. `[Theory]` attributes**. A fact is something that should always be true. A theory is something that, if it's wrong, could be because you fed it bad data.
* **The simplicity of passing data to tests with `[InlineData]`.** I think this a highly readable way to pass data into a test. 
* **Forgetting `[Setup]` and `[Teardown]`**. My tests flow naturally, just like normal classes and methods should. This prevents me from overcomplicating things[^3].
* **None of that gross `[ExpectedException]`**. In xUnit, I can use `Assert.Throws<T>`, or with a library like [FluentAssertions](http://www.fluentassertions.com/) I can catch exceptions right in my test using an `Action`:

{% highlight CSharp %}
Action act = () => myClass.DoThingThatBlowsUp();

act.ShouldThrow<Exception>().And.Message.Should().Be("BOOM!");
{% endhighlight %}

* **The `[Trait]` attribute to classify tests.** Using `[Trait]`, I can specify any arbitrary metadata about a test I want. Long-running test? Check. Hits a database? I can note that. Deals with a certain component? Yep. BDD-Style English sentence? Yuuup.
* **The ability to run xUnit tests in Visual Studio without an extension.** I think the fact that you can run `Install-Package xunit.runner.visualstudio` and then run your tests right in Visual Studio is awesome. It brings xUnit tests to everyone out of the box.
* **Just a normal class library**. No special unit test projects, no run list of unit tests. Just a class library that spits out a DLL. Simple.

## What I don't like about MSTest
In fairness, it's been a while since I've really dug into it. If I'm wrong on any of these points, let me know and I'll correct ASAP. I did my best to Google whether anything had changed. :)

* **It feels like a lot of cruft**. To dive into a project using MSTest, it takes a lot longer for me to figure out what tests are doing. 
* **It encourages bad habits[^4]**. Things like specifying certain pieces of build output for a test that won't run reliably with other test runners, or creating bloated setup & teardown methods that can cause tests to behave unreliably.
* **`[ExpectedException]` breaks Arrange/Act/Assert**. The assertion I'm making is the first thing in the test, before I've arranged or acted on anything. 
* **Doesn't support in-line data or parameterized tests.** You have to resort to external files to do data-driven tests. 
* **The runner is slow.** Similar tests always seem to execute more slowly with the MSTest runner. Apparently I'm not the only one who thinks this way:

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/sjkilleen">@sjkilleen</a> I googled &quot;why unit test need to be fast&quot; &amp; found the reasons. The MSTest runner, last I tried, is slow as turtles.</p>&mdash; mistersql (@mistersql) <a href="https://twitter.com/mistersql/status/608724039545270273">June 10, 2015</a></blockquote>

* **MSTest doesn't play well with build servers other than TFS.** Per a tweet from Ken Egozi: 

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/sjkilleen">@sjkilleen</a> you *can* cmdline MSTest but it is painful, and depends on a local VS install. Which makes build agents complicated.</p>&mdash; Ken Egozi (@kenegozi) <a href="https://twitter.com/kenegozi/status/608750807735914496">June 10, 2015</a></blockquote>

## Bad Reasons to Justify Using MSTest
* **Microsoft uses it.** Pssst, they're actually [mostly][mostly] [using][using] [xUnit][xunit] [now][now].
* **It's the default and that's good enough.** This is a failure of attitude. Woe to the developer who thinks this way. Continuous improvement, particularly in terms of toolsets, should be second-nature to a developer.

## What do *you* Think?
Am I too harsh on MSTest? Am I missing something? I'd love to hear from you in the comments.

Happy developing!

### Special Thanks...
...are due to [Sharon Cichelli](https://twitter.com/scichelli), [Chris Missal](https://twitter.com/ChrisMissal), [Ken Egozi](https://twitter.com/kenegozi), and [Brad Wilson](https://twitter.com/bradwilson) for engaging in conversation on this as I prepared the post.[^5]

----

[^1]: Some might say "justify." Semantics. :)
[^2]: I'm thinking along the lines of readability, arrange/act/assert, isolation, etc.
[^3]: IMO, simplicity and readability are hallmarks of good tests.
[^4]: My opinion, to be fair. But I think others would agree. 
[^5]: Sorry if I forgot you! Let me know and I'll fix it, promise. :)

[mostly]: https://github.com/aspnet/EntityFramework/search?utf8=%E2%9C%93&q=xunit
[using]: https://github.com/dotnet/corefx/search?utf8=%E2%9C%93&q=xunit
[xUnit]: https://github.com/dotnet/roslyn/search?utf8=%E2%9C%93&q=xunit
[now]: https://github.com/aspnet/Security/search?utf8=%E2%9C%93&q=xunit

<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
