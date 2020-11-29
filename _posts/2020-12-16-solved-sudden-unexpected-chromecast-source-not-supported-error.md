---
title: 'Solved: Chromecast "Source not Supported" Error When Attempting to Cast'
comments: true
tags:
  - chromecast
  - settings
  - error
date: 2020-12-16 10:00 -0400
---
## Problem

Despite it previously working, I see a `Source not Supported` error when attempting to Chromecast to a device. This also occasionally manifests itself as a device not showing up for Chromecasting.

## Solution

The solution in my case was to set the `Load Media Router Component Extension` setting to `Enabled`.

* Open Chrome
* Navigate to [chrome://flags/#media-router](chrome://flags/#media-router)
* Search for `Router Component` or similar
* Set from `Default` to `Enabled`

In my case, some organization-managed settings had changed defaults away from what they were previously.

Happy casting!
