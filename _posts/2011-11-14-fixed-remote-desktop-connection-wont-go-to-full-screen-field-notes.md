---
 
title: 'Fixed: Remote Desktop Connection Won''t go to Full Screen [Field Notes]'
date: 2011-11-14 22:26:00.000000000 -05:00
comments: true
redirect_from: 
 - /2011/11/fixed-remote-desktop-connection-wont-go.html
---
### Problem:
In Windows 7, I am in a Remote Desktop Connection Full screen. I accidentally pop it down to "window" size (i.e. when it can be resized), but the window refuses to go back into Full Screen mode.

### Solution
On the host machine (not the machine you're remoted into), press `CTRL+ALT+Break` (or `CTRL+ALT+Pause` for laptops that don't have a Break key).

On laptops, there may be an extra step. For example, on my laptop, this combination was `CTRL+ALT+Fn+Insert` (`Insert` doubles as the `Pause` key on my machine, and `Fn` is the button to toggle the alternate meaning).

With the right combination of keys, this places Remote Desktop back into full-screen mode.
