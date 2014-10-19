---
layout: post
title: 'How To: Convert an Oracle FLOAT Value to A Time Span [Field Notes]'
date: 2012-02-11 16:38:00.000000000 -05:00
comments: true
redirect_from: 
 - /2012/02/how-to-convert-oracle-float-value-to.html
---
###The Problem
We have a bunch of "durations" stored in Oracle as `FLOAT` datatypes (as day intervals, meaning they are an interval that includes days).

This makes sense. from a database storage perspective. However, I didn't know how to get those values into the more human-comprehensible hh:mm:ss format.

###The Solution
An Oracle function called `NUMTODSINTERVAL` is exactly what we need here. As the name suggests, it converts a number to a DateStamp interval (which is to say, interprets a number as a time span). We can tell it the type of time span (days in this case), and then extract the appropriate time values.

**Syntax:** `NUMTODSINTERVAL ([yourvalue], '[typeofinterval]')`

**Basic Example:** `NUMTODSINTERVAL (tablename.durationfield, 'DAY')`

The above example takes my field named 'durationfield' and tells oracle it's a DAY interval. From here, we use the `EXTRACT` function to get what we want.

###Solution Examples
####Gets the number of hours (and converts all day values to 24 hours each):

{% highlight sql %}
EXTRACT(DAY FROM NUMTODSINTERVAL(TABLENAME.DURATIONFIELD, 'DAY')) * 24
+ EXTRACT(HOUR FROM NUMTODSINTERVAL( TABLENAME.DURATIONFIELD , 'DAY')) 
AS DURATIONHOURS
{% endhighlight %}


####Gets the minutes in the same fashion:
{% highlight sql %}
EXTRACT(MINUTE FROM NUMTODSINTERVAL( TABLENAME.DURATIONFIELD , 'DAY'))                                                                   
AS DURATIONMINUTES
{% endhighlight %}

####Gets the seconds in the same fashion:
{% highlight sql %}
EXTRACT(SECOND FROM NUMTODSINTERVAL( TABLENAME.DURATIONFIELD, 'DAY'))                                                                  
AS DURATIONSECONDS
{% endhighlight %}
