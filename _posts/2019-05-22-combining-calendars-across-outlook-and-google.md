---
title: "How I Combine my Work (Outlook) and Personal (Google) Calendars"

date: 2019-05-22 04:50:00.000000000 -05:00

tags: [Productivity, Outlook, Google, Calendar]
comments: true

---

This came up in a conversation and I realized my methods might be helpful for someone. I figured I can write it up with step-by-steps here.

## Background / Goals

* I have a work calendar, via Outlook
* I have a personal calendar, using Google
* I want to overlay my work calendar in google so that I see work obligations when considering personal plans
* Similarly, I want to have access to my personal calendar from work so I don't agree to teach a training class during a family visit, etc.

## Getting Work Events into Google Calendar

The easiest way I've found so far to do this on Windows is to use [Outlook Google Calendar Sync --  a free, OSS app](https://phw198.github.io/OutlookGoogleCalendarSync/). It sits in my system tray and does a sync from Excella --> GCal since that's how I have it set up. I sync my Excella calendar to a Google calendar called "work" that I the  overlay with my personal calendar in Google Cal.

**NOTE**: This app has to be open and running somewhere in order to sync the changes. I have an idea of porting ame of this code to use Azure functions on a timer so that it won't be tied to a machine / tray app.

## Getting Personal Events into Outlook

If you want the reverse and want to overlay your personal calendar in your outlook, you can do that with google calendar too.

* Go into google calendar settings
* Scroll into "Integrate Google Calendar" section
* Copy the "secret address in iCal format"
* Go into your outlook account settings
* Go to the "internet calendars" tab
* Hit new & paste the URL

## How do You Accomplish This?

Your turn, dear reader! I'm very interested to hear other ways you've solved this problem, and whether you'd find a free/OSS cloud sync project beneficial. Sound off in the comments!
