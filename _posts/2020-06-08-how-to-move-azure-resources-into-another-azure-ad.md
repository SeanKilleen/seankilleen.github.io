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
* Checked Azure DevOps to make sure things still ran correctly
* Needed to switch the subscription in the DevOps releases to authorize the new subscription and select the now-transferred app service.
* Set up the alerts again