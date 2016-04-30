---
layout: post
title: Using JSHint with Underscore.js in Visual Studio 2012 [Field Notes]
date: 2013-11-25 18:30:00.000000000 -05:00
comments: true
redirect_from: 
 - /2013/11/using-jshint-with-underscorejs-in.html

references: 
 - title: Web Essentials VS Extension
   url: http://vswebessentials.com/
 - title: Mads Kristensen
   url: http://madskristensen.net/
 - title: JSHint
   url: http://jshint.com/
 - title: JSHint Options Page
   url: http://www.jshint.com/docs/options/#nomen
 - title: JSLint Options
   url: http://www.jslint.com/lint.html#options
 - title: "JSHint: Issues containing 'nomen'"
   url: https://github.com/jshint/jshint/search?q=nomen&amp;source=cc&amp;type=Issues
  
---
Since my new gig has me diving into Javascript quite a bit, I've really been loving [JSHint] integration (brought to us lovingly by [Mads Kristensen] and the team building the [Web Essentials 2012 add-on][WE]).

### Firstly: The Cool Feature that Caused my Issue -- Global Variables
One of my favorite features of JSHint is that it will tell you when you're using a variable that hasn't been defined yet. This does wonders for reducing scoping issues, etc.

But, when referencing browser functionality or variables from other files (think console.log, ko, moment, toastr, etc.) it would see them as undefined:

![Undefined errors for popular libraries]({{site.post-images}}/2013-11-25_JSHint_UndefinedErrors.png)
Yiiiikes.

Luckily, this can be fixed for most issues by utilizing the `global` command in a comment. JSLint will interpret the following as "assume all of these variables are defined":

![A list of libraries defined using the global command in a comment]({{site.post-images}}/2013-11-25_JSHint_GlobalCommand.png)

This saves so many validation headaches.

### The Problem: Identifying UnderscoreJS as a Global Variable
However, when I add the Underscore.js global identifier (`_`, unsurprisingly) to the global list, I get a different error -- `Unexpected dangling '_' in '_'`:

![Image of the new error message I see.]({{site.post-images}}/2013-11-25_JSHint_UnexpectedDanglign.png)

### The Solution: the "nomen" Option

One line of code removed this error:

    /*jslint nomen: true */

According to the [JSLint options documentation][JSLint Options], this allows underscores to begin a name. In the case of underscore, the `_` definition is both the beginning and end of the name (similar to jQuery's `$`).

### Cautions &amp; Some Tiny Pitfalls
Had a few minor "oops" moments while figuring this out.

#### Ensure that the nomen option is set before your Globals are Defined

This won't work:

```js
/*global $, jQuery, ko, moment, console, toastr, accounting, _ */
/*jslint nomen: true */
```
But this will:

```js
/*jslint nomen: true */
/*global $, jQuery, ko, moment, console, toastr, accounting, _ */
```

#### JSHint says "nomen" will be deprecated.

I kind of hope that's not the case, since it helps here.

There has been [some back and forth on the JSHint Github site][GH Link] about this, but the [JSHint options page for "nomen"][Nomen Link] makes it pretty clear:

> This option disallows the use of dangling _ in variables. We don't know why would you need it.

If you were a little new to this, as I was, I hope this helps! Feel free to send some feedback in the comments.

[JSHint]: http://jshint.com/
[Mads Kristensen]: http://madskristensen.net/
[WE]: http://vswebessentials.com/
[JSLint Options]: http://www.jslint.com/lint.html#options
[GH Link]: https://github.com/jshint/jshint/search?q=nomen&amp;source=cc&amp;type=Issues
[Nomen Link]: http://www.jshint.com/docs/options/#nomen