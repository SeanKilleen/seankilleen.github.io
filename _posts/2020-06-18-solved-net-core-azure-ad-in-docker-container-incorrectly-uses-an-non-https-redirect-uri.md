---
title: "Solved: .NET Core Azure AD in Docker Container Incorrectly Uses a
  non-https redirect URI"
comments: true
tags:
  - azure
  - docker
  - containers
  - dotnetcore
  - azuread
  - authentication
  - https
date: 2020-06-18 07:00 -0400
---
I've hit this problem several times and only recently figured it out.

## Problem

* I've created a new .NET Core MVC Web application. I've enabled Azure AD auth (as this app is for my employer) and I've added a Linux container support to the application as well.
* I configure everything as expected, and deploy to an Azure container webapp, being sure to enable https-only.
* I've registered my app in Azure AD and ensured the redirect URLs are set.

I'd expect to be able to authenticate, but instead I see:

> AADSTS50011: The reply URL specified in the request does not match the reply URLs configured for the application

And when I look at the URL, indeed my webapp appears to be passing along a redirect URI that begins with `http`, not `https`.

## The Issue

I started [an issue in the ASP.NET Core Repository](https://github.com/dotnet/aspnetcore/issues/22572) to try to get to the bottom of it.

[Barry Dorrans](https://twitter.com/blowdart) (Thanks Barry!)  aptly noted:

> Inside the container it's likely that your app is listening on HTTP, and Azure is terminating the HTTPS at the load balancer before forwarding the requests onward.

This seems to be a templating issue more than anything. When enabling both Azure AD login and Docker support, you need to be sure to forward headers. But, this doesn't happen out of the box with the template. (I've created [an issue on the templating repository](https://github.com/dotnet/templating/issues/2394) to try to address that.)

## The Fix

The fix comes in two parts.

First, in the `ConfigureServices` method of your `Startup.cs` class, add:

```csharp
services.Configure<ForwardedHeadersOptions>(options =>
{
  options.ForwardedHeaders = ForwardedHeaders.XForwardedFor |
                ForwardedHeaders.XForwardedProto;
  // Only loopback proxies are allowed by default.
  // Clear that restriction because forwarders are enabled by explicit
  // configuration.
  options.KnownNetworks.Clear();
  options.KnownProxies.Clear();
});
```

You'll also need to bring in a reference: `using Microsoft.AspNetCore.HttpOverrides;`

This sets up the header forwarding for https.

Secondly, make sure you actually make use of that configuration by adding the below in the `Configure` method of your `Startup.cs`:

```csharp
app.UseForwardedHeaders();
```

I mention it because I've forgotten that step twice now and then been confused as to why my changes didn't work. :laughing:

---

If you've run into a similar problem, I hope this helps. Happy coding!
