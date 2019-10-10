---
title: 'Better Technical Interviews: Part 5 -- My Common Interview Questions'
comments: true
tags:
  - interviewing
  - culture
  - hiring
date: '2019-10-09 17:00 -0400'
---

_This post part of [a series]({% post_url 2019-09-20-better-technical-interviews-part-1-whats-the-point %}) I'm writing on better technical interviews. I'd love your feedback in the comments!_

* [Part 1 - What's the Point?]({% post_url 2019-09-20-better-technical-interviews-part-1-whats-the-point %})
* [Part 2 - Preparation]({% post_url 2019-09-20-better-technical-interviews-part-2-preparation %})
* [Part 3 - The Actual Interview]({% post_url 2019-09-21-better-technical-interviews-part-3-the-interview-itself %})
* [Part 4 - My Opinion on Various Techniques]({% post_url 2019-09-25-better-technical-interviews-part-4-my-opinions-on-various-techniques %})
* [Part 5 - Common Interview Questions]({% post_url 2019-10-06-better-technical-interviews-part-5-common-questions %})

## Before we begin: A warning

Please recall that throughout preceding articles, I mentioned that the interview process needs to be heavily tailored to the position you're seeking to fill, and to the research you've done on an interviewee.

I mention this again here because it's really important. If you treat the questions below as a one-size-fits-all play book, you will be doing your team and your interviewees a disservice. **There is no overall interview play book in my opinion**.

The goal of the questions below is to show the types of open-ended questions I might ask to give the candidate space to show and tell me who they are around certain topics. These questions rarely exist on their own, but I usually try to turn them into mini conversations. **The follow-up is key.**

With that said, here are some common questions I tend to ask and my reasoning behind them.

## My Common Interview Questions, and their aims

### Tell me about a recent win you've had. Could be work-related, but doesn't have to be.

* **When I ask this question:** I tend to ask this at the start of an interview, usually as the first question.
* **Why I ask this question:** I've gotten feedback that it allows interviewees to open up and it removes some of the tension because we celebrate the win together. It doesn't start them out in a defensive posture. I also ask this to see where someone's priorities are and what they value as an accomplishment.
* **What sorts of answers do I look for:** I look for someone to have _something_ that they're proud of in work or outside of work, in at least some small way. Fork work-related answers, I also check to see if they've connected that accomplishment to delivering some sort of value for a larger audience. For personal answers, I look to see the ways they value spending their time and I try to relate it to work or to our pitch in future parts of the conversation.

### With so much happening in this industry, how do you keep your skills up to date?

* **When I ask this question:** I sometimes use this question as a go-to when I don't have a good segue between topics, to give me some mental space to queue up something else because it's a question I can pay attention to without it being too much of a burden.
* **Why I ask this question:** Keeping skills up to date is important, and is something that is a struggle for almost any developer.
* **What sorts of answers do I look for:** More than a specific answer, I look to understand that someone has some sort of a plan for themselves, and it's OK if that includes the expectation of learning some things on the job. People learn different ways -- could include reading blogs, Pluralsight or other video training, conferences, or books. I usually ask a follow up question on what someone's favorite resources are, mostly because I'm always looking to expand my list.
* **NOTE**: As I've stated elsewhere in the series, it also needs to be acceptable for someone to say "I don't get a lot of time outside of work for training due to (raising family / taking care of loved ones / really any outside work reason)". In this case, I follow up to ask what kind of learning they'd like to do if they had more bandwidth, and I use the opportunity to plug our professional development opportunities.

### What are some differences between mediocre and great teams? What are some things that great teams do?

* **Why I ask this question:** I want to ensure that someone thinks about their place within a team, no matter what role they'll be taking on. Collaboration and teamwork is a big part of what we do. I especially tend to ask this question if the resume or any initial conversations give me the impression they might consider themselves a "lone wolf" developer. I want a team member who has opinions on how to improve the overall team / system.
* **What sorts of answers do I look for:** Answers around collaboration and communication are the two big umbrella topics that I tend to hope for in answers. I love hearing about collective ownership, respect, vulnerability, and learning from each other. I also love hearing about psychological safety and a focus on delivering value. There are a number of potentially good answers to this question.

### Do you know what SOLID principles are? If so, do you have opinions on where they're useful / not useful?

* **When I ask this question:** When someone claims knowledge of them or claims expert OOP knowledge. Sometimes I ask out of curiosity.
* **Why I ask this question:** If someone isn't familiar with the terms, I can introduce the terms, give small explanations, and then ask some questions. If someone claims knowledge of it, I expect them to be able to expound on it. And the opinion component means
* **What sorts of answers do I look for:** The SOLID principles are important, but they're not necessarily gospel. I want someone to be able to engage with an idea and provide an informed opinion about it. I also do what to ensure some basic knowledge about what it means to build software with object-oriented programming well. Oftentimes a lack of knowledge about these principles leads down a discussion path where a lack of fundamental knowledge is revealed in several ways.

### What is the difference between inheritance and composition?

* **When I ask this question:** Again, when someone's OOP skills seem to be lacking or when they have proclaimed themselves to be expert in OOP principles and practices.
* **Why I ask this question:** Interfaces and abstractions are really important concepts that someone who is a professional developer should understand. I also come across many developers that attempt to shove everything into an inheritance hierarchy (danger zone!)
* **What sorts of answers do I look for:** I love to hear about the Liskov Substitution Principal. I also look for an understanding that composition means composing an object of behaviors (by implementing interfaces) rather than assuming that objects should inherit from each other. It's great if someone knows the difference between "Is-a" (inheritance) and "Has-a" (composition).

### What are interfaces, and why are they useful?

* **When I ask this question:** If it seems like someone might suffer in other areas of their knowledge about the language, or if I see large complex inheritance structures in sample code they've submitted.
* **Why I ask this question:** Interfaces are a core piece of many OOP languages (e.g. C#, which I normally interview in).
* **What sorts of answers do I look for:** Interfaces are contracts. They are definitions of behavior without actually implementing the behaviors themselves. I love it when someone gives an analogy, e.g. an electrical socket. Programming to abstractions rather than concretions is part of the SOLID principles of development. But beyond that, programming to contracts also gives us several advantages, like being able to create fake or mock objects that adhere to those contracts.

### What kind of automated tests have you worked with?

* **When I ask this question:** If someone's experience with testing isn't immediately evident or they claim expertise.
* **Why I ask this question:** It gives me a background on someone's overall experience and almost always invites follow-up discussion.
* **What sorts of answers do I look for:** I don't need someone to have experience writing automated tests in order to hire them. What I do need is for someone to understand why it's important for developers to write tests, and that they would expect to learn how to do so. What is a big red flag for me is an explanation that "QA folks do the testing", "I don't need to test my code because it works the first time", or other similar answers that show a lack of responsibility for the quality of development work.

### What is the difference between code first and database first? 

* **When I ask this question:** When someone's experience doesn't appear to include object-relational mapper (ORM) libraries or the position in question will have a lot of hands-on work doing database design.
* **Why I ask this question:** I want to know that a developer understands the trade-offs in how they use a tool. I want to know that they are familiar with different approaches, and that they are aware of issues around this sort of technology.
* **What sorts of answers do I look for:** A general understanding of these terms as applied to at least one ORM-style tool (EF, NHibernate, etc.s)

### If you had a large legacy application and needed to refactor a large part of the code base, how would you approach that? 

* **When I ask this question:** When someone claims an architect or lead developer style role in their past experience.
* **Why I ask this question:** I want to understand someone's big picture thinking, and their understanding around what a quality process looks like.
* **What sorts of answers do I look for:** Most important for me is that the candidate knows the importance of testing and verification in the refactoring process. Refactoring means to change the underlying design without changing external behavior, and we can't prove external behavior hasn't changed without tests. Beyond that, I look to see that someone does have a method of sorts or at least a consistent thought process, and that it involves communicating about large scale refactorings rather than going off on their own for weeks at a time to complete them.

### What are some key characteristics of a good unit test?

* **When I ask this question:** When someone claims unit or automated testing experience.
* **Why I ask this question:** Knowing the difference between unit tests and integration tests or other types of tests is important.
* **What sorts of answers do I look for:** Anything in the FIRST acronym (fast, isolated, repeatable, self-verifying, timely). Of particular importance is that someone understands the isolation aspect of a unit test, which tells me they've probably had to grapple with unit tests and mocking before. I also like to hear about clear arrange / act / assert portions of the test, or that it should be readable first & foremost (even if some code is repeated).

### What does it mean to be a leader?

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### Tell me about the different access modifiers and what they do?

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### What are some key components of high performing teams in your view? 

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### How would you mentor a junior developer who was more junior than you?

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### You’re going to miss deadline, what do you do?

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### What is your ideal day to day?

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### Ideal process from requirement --> Production

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### What are you excited about in the .NET world right now?

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### What are you looking for in a long-term fit?

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### What is an ORM? What are its pros and cons?

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### How do you ensure quality in an enterprise environment?

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### Tell me about different types of automated tests.

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

### If you were building a modern web application with server and client aspects, what technology stack would you start with today and why? 

* **When I ask this question:** 
* **Why I ask this question:**
* **What sorts of answers do I look for:** 

