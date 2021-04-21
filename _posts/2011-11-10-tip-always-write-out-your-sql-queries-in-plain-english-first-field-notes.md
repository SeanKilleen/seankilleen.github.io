---
 
title: 'Tip: Always Write Out Your SQL Queries in Plain English First [Field Notes]'
date: 2011-11-10 09:23:00.000000000 -05:00
comments: false


---
I recently ran into an issue where [constructing a SQL query took me ***much*** longer than I would have liked][SO Post]. While my need to dust off some cobwebs and my lack of familiarity with an enterprise system certainly contributed, I think the biggest factor was that -- because I didn't write out what I wanted to accomplish in plain English -- I was attempting to think about my data in the way that the database was thinking.

### Example

Consider the difference between just talking about what you want to return and how you will go about doing it. I believe you should do both, but separately, and they should inform each other.

#### Example: What You Want To Return

* Summaries for the costs and labor of a work order's child tasks (which are just a special type of work order having the original work order as a parent and a designation of a task)

#### Example: What Your Process Will Be To Get it

* I'll get the hours summary, labor cost summary, and item cost summary by task work order number, by joining the work order number across work order, labor, and items
  * I'll Constrain this by making sure the work order is a task
  * I'll call this Work Order Summary
* Once I have that working, I'll put it on the inside of another set of summaries, by parent so that I can sum up the summaries and have them for each parent work order.
* Once that works, I'll make sure that all potential null values (summaries) return zero if they come back null.

### Suggested Key Phrases

* **"I'll call this... "** --  Helps you to decide what your Aliases / "As" statements should be
* **"I'll get the..."** -- Indicator of types of field information you want to return in each record
* **"I'll constrain this by making sure"** -- helps define your WHERE clause
* **"Summary"** -- helpful to see if you'll be aggregating / grouping
* **"Once that works, ..."** -- Helps you to see a testing point, or a place that can stop.

### Additional Benefits

Consider the other practical benefits that writing your queries in plain English will bring:

* Firstly -- you lose nothing by doing this. That's the biggest thing.
* You'll find what I call your "test points" -- places where you can stop and insert some hard code for the purposes of testing.
* If you can't write it out using plain language, you will be informed early on that you don't understand the data you're dealing with.
* You can always start over from scratch if the query design doesn't quite work, knowing that you won't lose what you were trying to do.
* You can ask for help much more easily if you need it, and help your rescuers understand your situation quickly and clearly
* It automatically self-documents the business language, which means that someone smart on the business side can read it and tell you if you're not understanding the business rules quite right. This can be very helpful if your queries aren't returning what the end-user needs.

Does anyone know where I might find more guides along these lines? Do you have suggestions or improvements? Sound off in the comments!

[SO Post]: http://stackoverflow.com/questions/8070694/query-help-totaling-parent-child-items/8081369#8081369
