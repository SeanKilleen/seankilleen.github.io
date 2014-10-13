---
layout: post
title: Notes on Sub-Reports in Crystal Reports 2008 [Field Notes]
date: 2011-11-28 11:15:00.000000000 -05:00
comments: true

---
For starters, in CR 2008, you can't create two separate groups of data in one report (for example, all labor for a work order and then all materials for a work order).

To do this, you need to create a sub-report, format it, and pass any values back up to the main report using shared variables.

[This forum post](http://www.codeguru.com/forum/showpost.php?p=1701455&amp;postcount=2) that I found has a great quick run-down on how to accomplish shared variables from sub-reports to main reports. It was very helpful in understanding the wonky Crystal syntax behind what should be a simple thing.

The post is excerpted (though poorly formatted) below in case the originating site ever goes away. **NOTE:** None of the content below is mine; it is a reproduction because the information was too valuable to lose.

---
> Shared variables, introduced since Crystal Reports version 7, make it easier to pass values from a subreport to the main report.

> Using shared variables requires two formulas: one to store the value in a shared variable, the other to retrieve the value from the shared variable.

>The most important thing to remember when using shared variables is that Crystal Reports must first evaluate the formula where the value is stored before evaluating the formula that retrieves the shared variable. For example if you want to pass a grand total from the subreport to do a calculation in the main report, follow these steps:

 * In the subreport, create a formula similar to the one below:

{% highlight vbnet %}
// SubFormula

//Stores the grand total of the {Orders.Order Amount} field
//in a currency variable called 'myTotal'

WhilePrintingRecords;
Shared CurrencyVar myTotal := Sum ({Orders.Order Amount})
{% endhighlight %}

> * Place this formula in your subreport.
> 
* In the main report, create a formula that declares the same variable name:

{% highlight vbnet %}
//@MainFormula
//Returns the value that was stored in the shared currency variable called
//myTotal in the subreport

WhilePrintingRecords;
Shared CurrencyVar myTotal;

myTotal
{% endhighlight %}

> * Place `@MainFormula` in a main report section that is beneath the section containing the subreport. For the shared variable to return the correct value in the main report, you must place `@MainFormula` in a main report section that is beneath the section containing the subreport. This ensures Crystal Reports evaluates the `@SubFormula` before `@MainFormula`.

> One way to do this is to insert a section below the section containing the subreport, and place `@MainFormula` in this new sub-section:

> * On the `Format` menu, click `Section`.
> * On the `Sections` list, click the section containing the subreport.
> * Click `Insert` (at top of dialog box). This inserts an additional subsection.
> * Click `OK` to return to the report, and insert `@MainFormula` into this new subsection.

> The next time you preview the report, `@MainFormula` displays the value from the subreport. In this particular example, that value was the grand total of the `{Orders.Order Amount}` field.

> * Once you have verified that `@MainFormula` is returning the correct value from the subreport, you can include this formula in other main report formulas, such as:

{% highlight vbnet %}
//@NewFormula
//includes data from subreport
{@MainFormula}+ Sum ({Customer.Last Year's Sales})
{% endhighlight %}

> Place this formula in the same section as `@MainFormula`, or in a section further down on the report.

###References
* [How to Get Formula Field Value From Subreport to Main Report][codeguru article] [[CodeGuru][codeguru main]]

[codeguru main]: http://www.codeguru.com/
[codeguru article]: http://www.codeguru.com/forum/showthread.php?t=449494
