---
layout: post
title: 'How To: Swap Views/Tables Within the Same Database Using Crystal Reports 2008
  Designer [Field Notes]'
date: 2012-02-02 20:14:00.000000000 -05:00
comments: true

---
###Background
I have a database with a few different views. They all return the same fields in copies of the same exact report, but those fields are calculated differently (hence the views).

###The Problem
I wanted to be able to swap these views out without losing my fields, but couldn't seem to find a way to do it

Crystal has a method for changing data sources, and for setting tables up to be overridden in this way, but there didn't seem to be any way to swap out a view that was already in the same database.

###The Solution
**NOTE:** The solution below depends on the fact that your new tables or views should be returning the exact same fields (the new one can have additional fields, but not vice versa, which makes sense).

After some playing around, I figured it out. The best solution I've been able to come up with is:<

* While in your report, right-click on the `Database Explorer` and select `Set Datasource Location.`
* In the bottom pane, select the datasource from your list as if it is a new datasource.
* In the bottom pane, navigate to the table or view you'd like to replace.
* In the top pane, click the table or view you'd like to replace.
* In the bottom pane, click the table or view you'd like to replace the original table/view.
* Click `Update`.

This will work, but it will appear to fail. That's because **Crystal Reports keeps the same alias in its list of datasources.** To double-check this, you can go select `Show Query...` from the `Database` menu and you'll be able to see that the SQL is just covering up your new data source with the old alias name.

This might be fine for some folks, but it drives me up a wall. To fix that issue and get the names back in sync:

* Right-click on the database and select `Database Explorer`.
* In the panel on the right, right-click the improperly named datasource and select `Rename`.
* Enter the name of the table or view it is currently pointing to.

At this point, you'll have successfully completed the swap, with all your report fields making it out alive.
