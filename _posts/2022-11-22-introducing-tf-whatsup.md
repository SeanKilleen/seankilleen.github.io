---
title: "Introducing TF WhatsUp, a Tool for Better Terraform Notes"
comments: true
tags:
  - terraform
  - oss
  - dotnet
  - dotnet7
  - globaltool
  - nuget
date: 2022-11-11 8:00 -0500
excerpt: "Scratching a development itch to make Terraform provider upgrades easier."
# header:
#  overlay_image: /images/overlays/unsplash/chris-lawton-5IHz5WhosQE-unsplash.jpg
#  overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
#  caption: "Photo credit: [**Chris Lawton @ Unsplash**](https://unsplash.com/@chrislawton?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
---

I had a great excuse to get to dig into and publish a .NET Global Tool recently, so I figured I'd announce it here!

[TF-Whatsup](https://github.com/seankilleen/tf-whatsup), which provides the `whatsuptf` command, is currently at v0.5.0 on [NuGet](https://www.nuget.org/packages/TFWhatsUp.Console/#versions-body-tab)

## What it Does

Terraform has a phenomenal pace of updates, and really great, verbose release notes. But sometimes the updates I need to pay attention to can get lost in the noise from the updates of the entire ecosystem.

`TF-Whatsup` shows you the pending release notes for any Terraform provider you use, and highlights the notes that pertain to the resources that you use.

## How it Works

`TF-Whatsup` does the following:

* Pulls the current versions of your current providers from the Terraform lock file.
* Detects the resources you're using
* Finds the GitHub URLs for the providers
* For each provider:
  * Finds releases after yours (in terms of date and semantic versioning)
  * Parses the release notes & highlights lines that talk about resources you're using
  * Displays the parsed release notes back to you, in order of closest release to newest release.

## This Was Fun.

I had a few hours and was able to pull together the tool, get it working, and get it published to NuGet. It felt good to do that, and made me happy.

## I Need Your Feedback!

This is very early days but I feel like it could be useful and I'd love your feedback. Please open an issue on the GitHub repository or leave a comment here. Thanks!
