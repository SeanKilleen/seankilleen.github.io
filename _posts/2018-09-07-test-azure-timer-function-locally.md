---
title: "Quick Tip: How to Test Timer-Based Azure Functions Locally"
 
date: 2018-09-07 15:00:00.000000000 -05:00

references:
 - title: "Work with Azure Functions Core Tools"
   url: https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local#non-http-triggered-functions
   parenttitle: "Microsoft Docs"
   parenturl: https://docs.microsoft.com


---

I've been digging into Azure Functions lately and it's pretty great. I hit a small stumbling block so figured I'd document it here in case anyone else had the same question.

## Challenge

I have an Azure function that is triggered by a timer.

I'd like to test the function locally, but it appears that it only works on the schedule that I set. In the console window that pops up when debugging, I see

> The next 5 occurrences of the schedule will be:
> 9/14/2018 4:00:00 PM
> 9/21/2018 4:00:00 PM
> 9/28/2018 4:00:00 PM
> 10/5/2018 4:00:00 PM
> 10/12/2018 4:00:00 PM

How can I force this function to run so I can test it locally, without waiting for the next scheduled run?

## Solution

You can make a POST request to `/admin/functions/[functionName]` endpoint to execute the function.

For example, if azure functions is running on `localhost:7071` and I have a function called `MyFunction`, I could send an http POST request to:

`http://localhost:7071/admin/functions/MyFunction`

and the function would then be executed.

**Update 6/23/2020**: Thanks to Bill and Scott in the comments below, who correctly point out that you need to specify an empty data payload (`{}`) and a content type of `application/json`. If running using curl, it'd be `curl -i -X POST -H "Content-Type:application/json" -d "{}" http://localhost:7071/admin/functions/[FunctionName]`. I was drafting this quickly and used an app that helpfully abstracted those things away, but it doesn't help when explaining. :smile: Thanks to you both!

Hope this can help save some time for someone else. Happy coding!
