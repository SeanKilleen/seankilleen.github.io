---
layout: post
title: Using .NET and Mandrill to Communicate with Users During an Outage
---
###Problem
Everyone's been there before -- we had a production outage at work.

This is rare for us, and we'd grown so much since last time, that "Send e-mails from GMail" was not going to cut it.

###Solution
We were able to get a system together to get the emails out people as needed.

####Technology Used
* **Mandrill:** A great e-mail sending service we started using recently.
* **ClosedXML**: A nifty tool to parse XLSX spread sheets.
* **FluentValidation:** My favorite validation library for .NET, hands-down.
* A C# Console app

###How To Do It
####Step 1: Set up a Template in Mandrill and Test It
####Step 2: Get an Excel File with E-Mail Addresses
####Step 3: Write the Code to Parse Email Addresses with ClosedXML
####Step 4: Write the Code to Validate Email Addresses with FluentValidation
####Step 5: Create an API Key in Mandrill
####Step 6: Send the Emails to the Recipients
###Final Console App Code
Enjoy it in all its cobbled-together glory. I'll probably put a more generic version up on Github since it seems like it might be useful.
