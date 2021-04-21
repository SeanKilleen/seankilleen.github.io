---
 
title: Templated User Communication With Microsoft Word and Outlook [Field Notes]
date: 2012-03-12 09:37:00.000000000 -04:00
comments: false

---
As part of my job, I have to send a lot of e-mail communications to users. I like them to be as standard and repeatable as possible.

I hadn't set up a system to do this at my new place, so I thought I'd post here now that I'm up and running.

### The Problem

We need a standard, repeatable, and easy way to respond to users' requests.

### My Solution

(Yes, I know this is not the most high-tech solution.)

#### Setting Up the System

1. For each type of request, create an excel spreadsheet (or a sheet within an Excel Spreadsheet) with the information you need to complete that request and respond to the user. One of the fields should always be "E-Mail" since you'll use this later.
1. Create a MS Word document for the response to the user. Write it like you would an e-mail.
1. Use MS Word Mail Merge functionality to connect to the spreadsheet and insert placeholders for data.
1. Save the Word Document and Spreadsheet in an accessible place. Preferably, keep them in the same directory (multiple docs and one Excel workbook with multiple sheets works nicely for me).

#### Using the System

1. User submits request(s) -- you make sure you have all the proper information to complete the request(s). You put it in your spreadsheet.
1. Complete the tasks at hand.
1. Preview the Mail Merge and make sure it looks okay.
1. Under `Finish and Merge` in MS Word, select `Send E-Mail Messages..`
1. Select the field that contains the e-mail address to send it to, enter your subject, and then send it to all records.
1. **Important:** Delete the entries in the spreadsheet, or it will send to them each time. (I may rig up a field in the spreadsheet for "archived" so that it won't send if that field is filled, but it's too advanced for what I need at the moment.)
