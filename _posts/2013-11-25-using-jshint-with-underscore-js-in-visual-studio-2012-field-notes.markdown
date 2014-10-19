---
layout: post
title: Using JSHint with Underscore.js in Visual Studio 2012 [Field Notes]
date: 2013-11-25 18:30:00.000000000 -05:00
comments: true
redirect_from: 
 - /2013/11/using-jshint-with-underscorejs-in.html
---
Since my new gig has me diving into Javascript quite a bit, I've really been loving <a href="http://jshint.com/" >JSHint</a> integration (brought to us lovingly by <a href="http://madskristensen.net/" >Mads Kristensen</a> and the team building the <a href="http://vswebessentials.com/" >Web Essentials</a> 2012 add-on).

###Firstly: The Cool Feature that Caused my Issue -- Global Variables
One of my favorite features of JSHint is that it will tell you when you're using a variable that hasn't been defined yet. This does wonders for reducing scoping issues, etc.

But, when referencing browser functionality or variables from other files (think console.log, ko, moment, toastr, etc.) it would see them as undefined:

![Undefined errors for popular libraries]({{site.post-images}}/2013-11-25_JSHint_UndefinedErrors.png)
Yiiiikes.

Luckily, this can be fixed for most issues by utilizing the `global` command in a comment. JSLint will interpret the following as "assume all of these variables are defined":

![A list of libraries defined using the global command in a comment]({{site.post-images}}/2013-11-25_JSHint_GlobalCommand.png)

This saves so many validation headaches.

###The Problem: Identifying UnderscoreJS as a Global Variable
However, when I add the Underscore.js global identifier (`_`, unsurprisingly) to the global list, I get a different error -- `Unexpected dangling '_' in '_'`:

![Image of the new error message I see.]({{site.post-images}}/2013-11-25_JSHint_UnexpectedDanglign.png)

###The Solution: the "nomen" Option

One line of code removed this error:

    /*jslint nomen: true */

According to the [JSLint options documentation](http://www.jslint.com/lint.html#options), this allows underscores to begin a name. In the case of underscore, the `_` definition is both the beginning and end of the name (similar to jQuery's `$`).

###Cautions &amp; Some Tiny Pitfalls
Had a few minor "oops" moments while figuring this out.

####Ensure that the nomen option is set before your Globals are Defined

This won't work:

{% highlight js %}
/*global $, jQuery, ko, moment, console, toastr, accounting, _ */
/*jslint nomen: true */
{% endhighlight %}

But this will:

{% highlight js %}
/*jslint nomen: true */
/*global $, jQuery, ko, moment, console, toastr, accounting, _ */
{% endhighlight %}

####JSHint says "nomen" will be deprecated.

I kind of hope that's not the case, since it helps here.

There has been some back and forth on the <a href="https://github.com/jshint/jshint/search?q=nomen&amp;source=cc&amp;type=Issues" >JSHint Github about this</a>, but the <a href="http://www.jshint.com/docs/options/#nomen" >JSHint options page for "nomen"</a> makes it pretty clear:

> This option disallows the use of dangling _ in variables. We don't know why would you need it.

If you were a little new to this, as I was, I hope this helps! Feel free to send some feedback in the comments.

###References
* <a href="http://vswebessentials.com/" >Web Essentials VS Extension</a>
* <a href="http://madskristensen.net/" >Mads Kristensen</a>
* <a href="http://jshint.com/" >JSHint</a> &amp; <a href="http://www.jshint.com/docs/options/#nomen" >JSHint Options Page</a>
* <a href="http://www.jslint.com/lint.html#options" >JSLint Options</a>
* <a href="https://github.com/jshint/jshint/search?q=nomen&amp;source=cc&amp;type=Issues" >JSHint: Issues containing "nomen"</a> [<a href="http://www.github.com/" >Github</a>]</li>
