---
title: How I Created an Automated (and Humane!) Hiring Process Using Jira
comments: true
tags:
  - hiring
  - recruiting
  - automation
  - Jira
  - kanban
  - interviews
date: 2024-01-23 09:00 -0500
header:
  overlay_image: /images/overlays/unsplash/kier-in-sight-archives-a53bWJk1sz0-unsplash.jpg
  overlay_filter: 0.5
  caption: "Photo credit: [**Kier in Sight Archives @
    Unsplash**](https://unsplash.com/@kierinsightarchives?utm_content=creditCop\
    yText&utm_medium=referral&utm_source=unsplash)"
---
[My employer, SCT Software,](https://sctsoftware.com) is a small company of around 50 people. We needed to hire 2 developers, and we wanted to do it all in-house. Beyond the economics of saving money on outside recruiting efforts, this was a chance to find two people who would really accelerate the culture I'm working to build.

I've worked with some great recruiters (shout out to [Excella!](https://excella.com)) but I had no infrastructure in place and we weren't hiring enough people to warrant investing in a separate product.

However, we did have Jira.

## Let's Get to Work

So, here's what I did:

* Created a project & board for recruiting (I did this via a Jira cloud project that was already tailored for the purpose, but you could do it with a board)
* Used a type of item called `Applicant` created by the project (you could create your own if not using the project)
* Set up the board with the following columns:
  * Applicant
  * Acknowledged
  * Screening
  * Interview Planning
  * Interviewing
  * Interview Debrief
  * Offer
  * Rejected
* I added some additional fields to the applicant item
  * Candidate e-mail address
  * Link to where they came in (LinkedIn application or link to an e-mail in my inbox).
  * Optional public feedback to respond to the candidate if we rejected them
* Set up a [Calendly](https://calendly.com) link (New Outlook has [Bookings With Me feature](https://support.microsoft.com/en-au/office/bookings-with-me-setup-and-sharing-ad2e28c4-4abd-45c7-9439-27a789d254a2) that can do something similar)
  * This allows candidates to schedule with me while respecting my preferences without back & forth.
  * It lets me set a max amount of meetings per day, notice needed for prep time, gap time between meetings, etc.
* Made use of Jira labels on the issues -- these evolved organically but went something like:
  * If they had something I was looking for, I labeled it (`has_testautomation`, `has_devops`, `has_industry_experience`)
  * If they had something that set them apart, I labeled it (`standout_resume`, `has_referral`, `via_email` for those who did a nice e-mail intro)
  * If they were down-selected after interview, I added that `down_selected` as a label too.
  * When I asked for feedback (more on that below), I added a `feedback_requested` label so that I didn't ask more than once.

## Adding Automation

Now for some sweet stuff -- I added Jira automation.

* When moving into the `Acknowledged` column, it sent an e-mail to the candidate and CC'd me. The e-mail was a friendly intro:

> We're excited that you're interested in our .NET Developer role! We wanted to acknowledge that we've received your application and let you know that we'll be in touch about it as soon as we're able. We ask for your patience as we give each application our attention.

> If you have any questions about the organization, role, or process, reply all to this e-mail at any time and we'll be happy to answer.
>
> Thank you!

* When moving a candidate into the `Interview Planning` column, an e-mail is sent with the Calendly link:

> Hello,
>
> We're excited that you're interested in our .NET Developer role!
>
> As a next step, please schedule a time for the interview at (Link)
>
> We look forward to speaking with you!

* When rejecting a candidate, we send a friendly thank you e-mail and, if public feedback was provided, we pass that along as well. The template:

> Hello,
>
> Thanks for your interest in the Mid-Senior .NET Developer position at SCT Software. Unfortunately, we will not be moving forward with your application but we appreciate your time and interest in SCT Software.
>
> While things may not be a fit right now, we hope you'll keep us in mind for future opportunities. We wish you the absolute best in your next career move.
>
> (if public feedback was provided) The hiring manager provided the following feedback: "(the feedback)"
>
> If you have any questions or follow-up, don't hesitate to reply to this e-mail. Again, we thank you for your time.

* A manually triggered automation, which I send a few days after an interview, that asks for feedback, using a Microsoft Forms form that I created, and adds a label to the issue indicating that feedback was requested. Contents:

> Thank you for going through the SCT interview process and making the time to speak with us.
>
> We know your time is valuable, and we'd appreciate it if you'd be willing to anonymously share some thoughts on your experience with us. This feedback will be seen directly by the hiring manager who conducted the interview.
>
> (Link)
>
> NOTE: If you are still in the interview process, this is not an indicator that the process is finished; we just don't want to wait too long to collect feedback.
>
> Thank you for considering!

So, my overall process went something like this:

* Candidate applies via LinkedIn or e-mail
* I create a card in the applicant column. I add the e-mail, attach the resume, and add any e-mail intro text as a comment
* I move into the acknowledge column, which sends the acknowledgment e-mail
* I move them into the `Screening` column and look at their resume
* I add a comment in Jira as I look at the resume and their LinkedIn etc (I typically use one comment with a list of 🟢,🟡,🔴,⚠️icons for each item so I can get a sense of how I feel at the end)
* I update the labels
* If there aren't enough positives to move them along, I move to the rejection column (I will take the time to fill out that public feedback field if they were close.). This sends the rejection e-mail with the feedback if provided.
* If I think they warrant an interview, I'll move to the `Interview Scheduling` column. This sends the scheduling e-mail.
* Candidate uses Calendly which sets up a meeting that they can reschedule as needed.
* I change the due date for the card in Jira to the date when the interview is scheduled, and move into the `Interviewing` column.
* I order the interviewing column in the order in which the interviews are coming.
* I add a comment in Jira with my interview plan. This starts with standard questions, and then I expand it to certain claims made on the resume and specific questions that I'd like to ask them based on what I see.
* During the interview, I edit this comment and use bullets underneath the questions to capture what is said and any quick thoughts I have
* Right after the interview, I add my debrief notes to the end of that comment. I move the card to `Interview Debrief`
* If I reject them at this point, I usually wait a little bit and I try to add kind but real feedback.
* A few days after the interview, regardless of a decision, I send the feedback request using the manual automation. This sends the link to the Microsoft Forms form which asks for 1) a rating for the experience 2) positive highlights 3) things they'd improve in the future and 4) anything else we need to know.
* From there, I choose who I'd like to move into an offer status and from there the communication is more tailored.

## The Results

This process was pretty effective for us, which is why I'm willing to write it up in the hopes that it benefits others. We had over 60 applicants for the two roles we had open. I was able to make an offer to two fantastic candidates that I think will really move our organization forward. I also had to reject several great candidates would have also been a really good fit (a best-case scenario for us as an org, even though that stinks).

But, more importantly: 100% of our anonymous interview feedback respondents rated their experience a 5 out of 5, and we received a ton of positive comments about the process. And, I felt like most of my time was spent where it mattered: on thinking about and connecting with candidates.

I hope this provides you with a place to start if you're looking to improve your interview process!

Questions? Thoughts? I'd love to hear from you in the comments!
