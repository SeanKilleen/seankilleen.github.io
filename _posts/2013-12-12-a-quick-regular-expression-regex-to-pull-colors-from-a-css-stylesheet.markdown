---
layout: post
title: A Quick Regular Expression (Regex) to Pull Colors From a CSS Stylesheet
date: 2013-12-12 18:30:00.000000000 -05:00
comments: true

---
This one's mostly for my quick personal reference. It wasn't hard by any means but figured someone else might find it useful.

###Problem
I need to find all hex color codes in a style sheet so I can extract them.

###Solution
I came up with a quick Regex (regular expression) to do this:

    #([A-Fa-f0-9]*);
    
Essentially, it just looks for a pound symbol (`#`), followed by any amount of numbers 0-9 or letters a-f, followed by a semi-colon.

If you're interested to try it, you can view [my example over at Regex Tester].

It's not the slickest but it got the job done quickly.

Happy coding!

[my example over at Regex Tester]: http://regexpal.com/?flags=gm&amp;regex=%23(%5BA-Fa-f0-9%5D*)%3B&amp;input=%23F1682D%3B%0A%23a%3B%0A%23aaa%3B%0A%23bbb%3B%0A%23123456%3B%0A%0ANote%20that%20it%20still%20matches%20numbers%20that%20are%20longer%20than%20they%20need%20be%20(I%20didn't%20care%20about%20this)%3A%0A%23123456778%3B%0A%0A
