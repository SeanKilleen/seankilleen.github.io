---
title: "Random thoughts: Considerations around web scraping"
comments: true
tags:
  - web scraping
  - ethics
  - good practices
  - opinions
date: 2020-05-20 18:25 -0400
---
Someone approached me with a question about considerations for a team who was thinking about scraping a commercial web site for data that was behind a paywall. The development team was thinking in terms of something being technically feasible, but not necessarily about the broader implications. 

TODO: Image -- "can" vs "should"

I wrote back and figured I'd put my thoughts up here. Standard disclaimer: I am not a lawyer.

Risks:

* Legal: Most sources of data public clear terms & conditions about its access that prohibits web scraping. If it's commercial data, they see this as a business threat, because they often upsell for programmatic access to data. Unless it's explicitly allowed (or not addressed, if you're comfortable in a grey area), you're asking for legal trouble. I worked for a company that protected data like this. They have a big legal dept for a reason.
* Detection: if someone doesn't want you to scrape them, chances are they have ways to detect if you're scraping them. Request logs and monitoring give spikes away. Without disguise (which is borderline unethical) & adherence to a lot of politeness (which most scrapers would take forever if they did), most sites will be able to tell that someone is scraping them, and then figure out who.
* Complexity: You might find that your target site actively obfuscates (e.g. by moving HTML elements around, renaming things, etc.) to throw off web scrapers, which often rely on consistent output in order to do their job.
 They also may give you fake data once you're detected to be scraping.
* Blocking / Banning: Even if someone doesn't sue you, they might blanket block your entire organization, meaning you might lose the legit access to data that you have because IPs, subnets, and other machines get banned. And if they know the org doing it, they may take additional steps to ban that org's IPs as well as a retaliatory measure.

Here's an article that warns businesses about the dangers of web scraping, in case you need to help them see it how the target site might see it: https://blog.radware.com/security/2016/03/good-bad-and-ugly-web-scraping/

Here's a nice succinct idea of ethics in web scraping: https://towardsdatascience.com/ethics-in-web-scraping-b96b18136f01 

The difference is that your target site likely doesn't fall into the "ethical site owner" category in this article, as they are going to protect the data as a source of their IP, and that data is not something they'd consider part of the open web (especially if it's behind a login screen or subscription or portal of any kind.) (edited) 

In short, I would push back strongly on the practice unless someone can show you that:

* It is explicitly allowed via your subscription (e.g. you have paid access to the data)
* It is not disallowed under the terms & conditions (just paying for it doesn't mean you can use it however you want)
* It is not available as an up-sell on the subscription you already have
* (Ideally) A client's legal team has signed off on the activity.
* Your team has a set of guiding principles in place similar to the "ethical data scraping" article above, and plans to adhere to them.
* Your company's client team is comfortable with the level of risk to the account relationship.
