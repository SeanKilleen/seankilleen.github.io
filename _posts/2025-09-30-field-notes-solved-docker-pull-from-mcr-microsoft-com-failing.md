---
title: "[Field Notes] Solved: docker pull from mcr.microsoft.com failing"
comments: true
tags:
  - field-notes
  - dns
  - docker
  - verizon
date: 2025-09-30 15:51 -0400
---
## Background 

Recently had an issue where some of our developers couldn't pull Docker images from `mcr.microsoft.com`. This happened over time, and sometimes when they changed locations.

## Troubleshooting 

Finally narrowed it down to those using Verizon, using Verizon DNS, on IPv6.

| ISP | IPv6 Enabled | Machine DNS | Docker DNS | Result |
| ----| -------------| --- | ---------- | -------|
| Comcast | Any | Any | Any | ✅ |
| Verizon | False | Verizon Default | Default | ✅ |
| Verizon | True | 1.1.1.1 | Default | ✅ |
| Verizon | True | Verizon Default | 1.1.1.1 | ✅ |
| Verizon | True | Verizon Default | Default | ❌ |

## How to Fix

As far as I can tell, there are a few ways to resolve this issue.

* You can move off of Verizon 😉
* You can disable IPv6 on your machine, allowing only IPv4. However, this seems a little drastic
* You can set your machine's DNS server away from Verizon's DNS to something like CloudFlare's `1.1.1.1` or similar.
* You can update the Docker Engine settings in Docker for Windows to add `"dns": ["1.1.1.1"]` to the top-level JSON. This will change the DNS settings only within docker, so pulling images should work once more without any changes affecting your wider machine.

## Final Thoughts

Still not sure why this is happening, or why it seems to be happening only in this specific scenario. DNS isn't my strong suit, but I hope someone smarter than me comes along and adds more information here.

For now, just happy to be able to unblock my team.

Happy coding!
