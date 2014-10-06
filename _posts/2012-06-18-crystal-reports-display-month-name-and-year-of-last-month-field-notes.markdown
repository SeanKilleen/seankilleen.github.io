---
layout: post
title: 'Crystal Reports: Display Month Name and Year of Last Month [Field Notes]'
date: 2012-06-18 17:00:00.000000000 -04:00
---
###Problem
A report I'm running gets the data for the last Month. I'd like to nicely display the name of the month and year.

###Solution
####Step 1: Formula to Return the Date 1 Month Ago
Use the DateAdd function in the formula to get the date minus one month:

    DateAdd("m", -1, CurrentDate)

This says to use "month" intervals, subtract one, and use the current date as the starting point.

####Step 2: Display the Month Name and Year of the Date Formula

    MonthName(Month({@DateMinusOneMonth})) + " " + ToText((Year({@DateMinusOneMonth})), 0, "")

This concatenates a string of the month name for the formula and the year for the formula. The part that calculates the year also notes that there should be no comma for thousands and no decimals (year here is being interpreted as just a number when outputted to `ToText`).

###References
* <a href="http://publib.boulder.ibm.com/infocenter/radhelp/v7r5/index.jsp?topic=%2Fcom.businessobjects.integration.eclipse.designer.doc%2Fhtml%2Ftopic681.html">DateAdd</a> [<a href="http://publib.boulder.ibm.com/infocenter/radhelp/v7r5/index.jsp?">IBM RAD Reference</a>]
* <a href="http://crystaltricks.com/wordpress/?p=149">ToText Function</a> [<a href="http://crystaltricks.com/wordpress/">Crystal Reports Tips &amp; Tricks</a>]
