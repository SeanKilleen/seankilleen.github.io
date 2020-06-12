---
title: "How to: Move Azure Resources into another Azure AD"
comments: true
tags:
  - azure
  - ad
  - subscriptions
  - management
  - resources
date: 2020-06-08 08:47 -0400
---
I recently completed some work for a client. The work had been done within my company's Azure org, but I wanted to ensure the client had full control of their resources in a secure way. 

Here are the steps we took:

* Had a zoom meeting with the client to set up their Azure subscription / AD.
* Made me an owner of their AD and Subscriptions (temporarily, to ensure I had no troubles with transfers).
* Created a new subscription within my company's AD to hold the transfer items. This is because you can transfer a subscription but not resources from within a subscription. Called this the "Transfer Subscription".
* Transferred resources into that subscription (had to leave a few metric alerts behind as they didn't transfer).
* Waited (nervously) for the transfer to complete. This is the first time this was happening and it was using a running web site. 
* It worked! Wow, that's cool.
* Transferred the transfer subscription into their Azure AD
* Transferred the resources from the transfer subscription into the client's subscription
* Deleted the transfer subscription
* Set up the metric alerts again.

Then, I checked Azure DevOps to make sure things still ran correctly. I needed to:

* Go into each release job to specify the new azure subscription. The first time I did this, I had to authorize the new azure subscription. The second time, I had to select the existing subscription that I'd just authorized. The UX was slightly confusing; for a few minutes I was accidentally attempting to re-authorize the same subscription rather than select it, which resulted in an error.)
* Go into Service Connections. Deleted the existing service connection for our container registry. Added a new service connection to the new subscription's container registry that we'd transferred, and gave the service connection the same name as the old one I'd just deleted.

With that, the transfer was complete! Whole thing took roughly an hour, and that's factoring in my caution and the time to move the resources.

What experience have you had moving resources in the cloud? Sound off in the comments!