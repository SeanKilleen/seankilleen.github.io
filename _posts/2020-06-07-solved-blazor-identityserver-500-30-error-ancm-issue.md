---
title: "Solved: Blazor IdentityServer 500.30 Error (ANCM Issue)"
comments: true
tags:
  - blazor
  - azure
  - ssl
  - certificate
  - security
  - powershell
  - identityserver
date: 2020-06-07 14:31 -0400
---
Ran into this this issue while hacking on a problem with my Dad, [Jim Killeen](https://twitter.com/JimK_). (Side note: looking at tech stuff with my Dad remains one of my great joys in life.) 

## Context

My Dad is building a client-side Blazor app, because he's more hip with technology than I am.

## Problem

When publishing / deploying the app, upon it attempting to start up and communicate with a Web API, we see an error of `HTTP Error 500.30 - ANCM In-Process Start Failure`.

## Solution

This is caused because the client-side web app cannot communicate securely with the Web API, which is fair. We want to make sure there's trust there. So to get that trust in place, we'll need to generate a self-signed certificate and set up the IdentityServer configuration to use it.

### Creating the Self-Signed Certificate

### Uploading the Certificate into Azure

### Updating the IdentityServer Settings



Annnd success. :) 