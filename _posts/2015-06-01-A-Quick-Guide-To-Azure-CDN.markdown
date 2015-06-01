---
title: "A Quick Guide to Easily Using Azure CDN with ASP.NET MVC Projects"
layout: post
date: 2015-06-01 16:33:00.000000000 -05:00
excerpt: "Save your pages time and money by using a CDN. It's not hard at all."
comments: true
---
Happy June, readers! I recently helped design a [web site for a charity contest](http://AlliesForACure.com). We had some static content (images, etc.) and wanted to keep pages loading quickly while keeping our costs low.

This sounded like a job for [Azure CDN](http://azure.microsoft.com/en-us/services/cdn/). But I had never used it before, so I figured this would be a good opportunity to make a blog post out of it.

# Back up a second -- What's all this CDN Business about?

## What a CDN Does

In short, all the stuff sitting on your server -- your web site's images, videos, sound files, style sheets, etc. -- all has to be served up to the user. What we often neglect is that those files have to be transferred all the way from the server to the user's PC, which takes time and costs bandwidth. If your server is in New York, and your user is in California, the files have to travel all the way there.

CDNs distribute your files to various places around the globe, and are really good at caching them. As a result, if your server is in New York, and your user is in California, when they go to the URL for the image, it might actually be served to the from some place much closer, saving valuable time. 

## Why CDNs? Why Azure CDN?

Why use a CDN? Because it can dramatically cut down on load time, and most of the time it adds value to the price you'd be paying to serve these files up on your own anyway.

Why use Azure CDN? In this case, just because I want to play around with it. There are many credible alternatives out there. In our case, our site was already served with Azure, so I figured why not?

# First Step: Think About What You Want to Serve

CDNs usually work based on containers. Azure is no different. So, I wanted to think about the different types of content I wanted to serve up. This boiled down to:

* Site images (logo, favicon, etc.)
* Headshots of team members
* Photos that we used in the campaign

# Setting up the Azure CDN

## Prerequisites

I assume you have an Azure account and have used the portal before. If not, it's not that hard to do -- I have faith in you. Write in a comment if you're having trouble.

## Create an Azure Storage Account

## Create Your Containers and Add Your Files

## Create the CDN on top of the Storage Account

## Fancy Optional Step: Setup a sub-domain to point to your CDN

# Making it Easier: An HtmlHelper for CDN Content

# Some Caveats

* CDNs cache content for a long time. You can get around this using Azure CDN QueryStrings, but be careful because it kind of defeats the purpose. Usually querystrings are used with something like a version of a site, e.g. `myImage.jpg?v=1.2.3`.
