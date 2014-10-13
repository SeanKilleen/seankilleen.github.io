---
layout: post
title: 'How To: Toggle Fields in a Crystal Report Based on Whether Records are Returned
  [Field Notes]'
date: 2011-12-19 13:30:00.000000000 -05:00
comments: true

---
###Problem
In a Crystal Report, you would like to show or hide sections based upon whether the report contains results or not.

###Solution
####Step 1: Create a Shared Variable and Increment it
Create a formula with a shared variable in your report -- for the sake of this example, we'll call it `v_RecordCount`.

The contents of the formula should look like this:

{% highlight vbnet linenos %}
// Excute this formula as records are read into the report
WhileReadingRecords;

// define a variable that is available throughout the 'main' report
Global Numbervar RecordCount;

// increment the variable
RecordCount := RecordCount+1;
{% endhighlight %}

####Step 2: Place the Variable in the Report header and Suppress it
* Drag the formula into the `Report Header A` section.
* Right-click on the formula you added in the report and select `Format Field...`
* Click the `Common` tab.
* Check the `Suppress` button.
* Click `OK`

####Step 3: Craft the Proper Suppression Formula for the Sections
Note that the formula we have created will return `null` when there are no records. This is key to crafting the formula.

* Right-click on the section you would like to show or hide based on having results.
* Click `Section Expert...`
* Next to the `Supress (No Drill-Down)` option, click the `Formula` button.

If you want to **hide a section if there are no results**, enter the following:
{% highlight vbnet linenos %}
If IsNull({@RecordCount}) then true
else false
{% endhighlight %}

This tells Crystal to hide the section if the `RecordCount` is null (i.e. there are no results), and to show it otherwise.

If you want to **show a section if there are no results**, enter the following: 

{% highlight vbnet linenos %}
If IsNull({@RecordCount}) then false
else true
{% endhighlight %}

Or:
{% highlight vbnet linenos %}
If (Not(IsNull({@RecordCount}))) then true
else false
{% endhighlight %}

These both say "if the record count is not null" (i.e. there are records), suppress this field. Otherwise, show it (if there aren't any results).
