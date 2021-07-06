---
 
title: 'How To: Set a Default Date Parameter In Crystal Reports [Field Notes]'
date: 2012-06-15 16:30:00.000000000 -04:00
comments: false

redirect_from:
 - /2012/06/how-to-set-default-date-parameter-in.html
 
references: 
 - title: "Crystal Reports: Named-Date-Range Parameters"
   url: http://cogniza.com/wordpress/2005/11/24/advanced-parameter-usage-in-crystal-reports/
   parenttitle: Cogniza
   parenturl: http://cogniza.com/wordpress/
---

## Problem

I have a report that I'd like to be able to query the date range for. However, I'd also like to have a default value of "today" so that when I run it on a schedule, etc. it's just me passing in a different parameter, and not changing the actual record selection process.

Crystal Reports doesn't have a default mechanism to do this. It appears to be pretty sought after in the Crystal community, but I haven't seen any solutions that would allow one to, say, use a variable like `currentdate` as the default for a date field.

## Solution

I found a [helpful blog post on Cogniza][Cogniza Post] which I modified a little bit to fit my situation.

### Step 1: Create Parameters

We're going to create two parameters. The first I'm going to call `NamedDateRange` and the second I'm going to call `CustomDateRange`.

#### NamedDateRange Parameter

This should be an optional string parameter. Add list items like "Today", "Yesterday", "This Month", etc.

#### CustomDateRange Parameter

This should be an optional date or date range parameter for custom values to be entered.

### Step 2: Create the DateRangeSelection_FromParameters Formula

We need a formula to hold the results of our parameters (this will make it nice and clean in the RecordSelection formula, which I prefer.)

Basically, my logic here is the following:

* If the `NamedDateRange` has a value, we'll use it.
* Otherwise, we'll use the `CustomDateRange`
* If neither has a value, we'll default to today's date.
* Also if `NamedDateRange` has a wacky value, we'll default to today's date.

Thus, the formula is:

```crystal
{DateFieldInMyTable} in (
if not hasvalue({?NamedDateRange}) then
    if not hasvalue({?CustomDateRange}) then currentdate
    else {?CustomDateRange}
else
if {?NamedDateRange} = "Today" THEN currentdate
else if {?NamedDateRange} = "Yesterday" then (currentdate - 1)
else if not hasvalue({?CustomDateRange}) then currentdate
    else {?CustomDateRange}
)
```

### Step 3: Create the Record Selection Text

Due to our use of the formula earlier, the record selection text is as simple as:

```crystal
{DateField} in ( {@DateRangeSelection_FromParameters} )
```

Where DateField is the name of whatever DateField you're comparing.

### Step 4: Set the Default Value When Running a Report

I'm tackling this using Crystal Reports Server 2008, so this step will apply mostly to that specific setup.

* Upload the report to Crystal Reports
* Set the database configuration options, etc.
* Right-click on the report and select `Properties`
* Under the `Default Settings` section, click `Parameters`.
* Click Edit for `NamedDateRange` and enter "Today".

Now "Today" will appear as the default selection, so if the user just hits OK, they will see that it generates for today.

**NOTE:** Because of the work we did with our formula earlier, even if both fields are left blank, the report will generate for today. A nice touch.

### Step 5: Set the Default Value When Scheduling a Report

These steps are essentially the same as step 4. Schedule the instance as you normally would do, but in the "Parameters" section, select "Today".

And with that, we have a Crystal Report that will default a date range to Today while allowing other custom date ranges as well!

[Cogniza Post]: http://cogniza.com/wordpress/2005/11/24/advanced-parameter-usage-in-crystal-reports/
