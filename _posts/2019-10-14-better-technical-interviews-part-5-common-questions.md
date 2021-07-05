---
title: 'Better Technical Interviews: Part 5 -- My Common Interview Questions'
comments: true
tags:
  - interviewing
  - culture
  - hiring
date: '2019-10-14 17:00 -0400'
---

_This post is part of [a series]({% post_url 2019-09-20-better-technical-interviews-part-1-whats-the-point %}) I'm writing on better technical interviews. I'd love your feedback in the comments!_

* [Part 1 - What's the Point?]({% post_url 2019-09-20-better-technical-interviews-part-1-whats-the-point %})
* [Part 2 - Preparation]({% post_url 2019-09-20-better-technical-interviews-part-2-preparation %})
* [Part 3 - The Actual Interview]({% post_url 2019-09-21-better-technical-interviews-part-3-the-interview-itself %})
* [Part 4 - My Opinion on Various Techniques]({% post_url 2019-09-25-better-technical-interviews-part-4-my-opinions-on-various-techniques %})
* [Part 5 - Common Interview Questions]({% post_url 2019-10-14-better-technical-interviews-part-5-common-questions %})

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
* **What sorts of answers do I look for:** A general understanding of these terms as applied to at least one ORM-style tool (EF, NHibernate, etc.). Even when candidates don't have this knowledge, I'll explain the terms a little bit and ask them to walk me through what making a change might look like using one system or another. In that case I', looking for someone's ability to apply a concept we just introduced.

### If you had a large legacy application and needed to refactor a large part of the code base, how would you approach that?

* **When I ask this question:** When someone claims an architect or lead developer style role in their past experience.
* **Why I ask this question:** I want to understand someone's big picture thinking, and their understanding around what a quality process looks like.
* **What sorts of answers do I look for:** Most important for me is that the candidate knows the importance of testing and verification in the refactoring process. Refactoring means to change the underlying design without changing external behavior, and we can't prove external behavior hasn't changed without tests. Beyond that, I look to see that someone does have a method of sorts or at least a consistent thought process, and that it involves communicating about large scale refactorings rather than going off on their own for weeks at a time to complete them.

### What are some key characteristics of a good unit test?

* **When I ask this question:** When someone claims unit or automated testing experience.
* **Why I ask this question:** Knowing the difference between unit tests and integration tests or other types of tests is important.
* **What sorts of answers do I look for:** Anything in the FIRST acronym (fast, isolated, repeatable, self-verifying, timely). Of particular importance is that someone understands the isolation aspect of a unit test, which tells me they've probably had to grapple with unit tests and mocking before. I also like to hear about clear arrange / act / assert portions of the test, or that it should be readable first & foremost (even if some code is repeated).

### What does it mean to be a leader?

* **When I ask this question:** Whenever someone is interviewing for a leadership position, and usually for senior positions as well.
* **Why I ask this question:** This question often reveals biases. Does someone see leaders as authoritarian? Do they view leadership as having all the answers? I want to see how someone thinks about leadership both in terms of someone else being a leader they work with and also themselves as a leader.
* **What sorts of answers do I look for:** I look for answers around servant leadership, mentoring, growing more leaders, supporting those on your team. I look for answers around good communication and feedback, clarity of vision and purpose, and encouragement. I look for answers about a positive attitude. If I sense that someone maybe hasn't encountered that sort of definition of leadership before, I may prod a bit. Mostly what I'm looking for is that someone isn't actively against that idea of leadership.

### Tell me about the different access modifiers and what they do?

* **When I ask this question:** To test the basics of someone's language capabilities, especially when I sense someone might be padding their skillset or not have a grasp on some of the fundamentals. I will also sometimes ask this as a introductory question when building to other questions.
* **Why I ask this question:** I don't need someone to be perfect on this topic. I've got Google like everyone else. But these are the basics and if someone really struggles, it's a flag that I need to dig deeper because they might have a rough time of things.
* **What sorts of answers do I look for:** I mainly am looking to know if someone can distinguish between public and private, and why the distinction is important. If someone talks about that and managing encapsulated state, I'll feel ok about it. `internal`, `sealed`, etc. are great keywords to delve into and I might ask someone about them if they don't mention it but it's not the end-all for me. If someone does know the distinction correctly, I'm listening to how they explain it to me and whether they use any great techniques / examples to get the point home.

### How would you mentor a developer who was more junior than you? More senior than you?

* **When I ask this question:** When I have any flags around someone's ability to collaborate and grow with their colleagues.
* **Why I ask this question:** Rather than putting them in the learner's seat, I try to get them to put themselves in the mentorship position. Asking it from both perspectives allows me to see how they might adjust their answer based on perceived authority.
* **What sorts of answers do I look for:** Getting buy-in; creating a plan; meeting someone at their level; learning while you teach.

### You’re going to miss a deadline; what do you do?

A little background on this question: I tend to phrase this along the lines of: "You're working on an assignment with a really important deadline for your client. As the deadline draws nearer, you realize there's no way that you and your team will be able to make the delivery you committed to by the deadline. This is an unpleasant position to be in. What do you do?

* **When I ask this question:** When I want to explore how someone ties their work to value delivery, or when I want to see if someone understands an important part of the agile value proposition.
* **Why I ask this question:** I ask this question to see if someone communicates well, and if they're able to think about their work beyond assignments and in terms of things like scope or value delivery.
* **What sorts of answers do I look for:** I look for someone to acknowledge the human piece of failure and communicating that honestly and without hesitation. I look for people to talk about how they might prevent that situation (e.g. scoping things correctly, delivering small chunks of value consistently). I look for folks to talk about de-scoping, or asking questions about what the different pieces of value might be and seeing if they can deliver as much value as possible for the deadline. I also look for someone to talk prevention and mitigation strategies for future work. If this is someone who's never been in a leadership role, I'd be looking for how they communicate with their internal team. If it's someone who is looking for a senior or leadership role, I'll likely push them to ask them about how they'd communicate with the client on this as well.

### What is your ideal day to day?

* **When I ask this question:** When there are gaps on a resume or jumps that might indicate that someone hasn't found a long-term fit yet, or when I sense that someone's disposition may not match with the organization they'd be coming in to.
* **Why I ask this question:** Because I can usually tell when someone's BSing about it. It also allows me to level-set expectations if the role / organization could potentially be far off of what that person is looking for.
* **What sorts of answers do I look for:** Mostly: honesty. The rest is about fit. If I hear that someone wants to code all day and never talk to people, a good consulting company may not be the best fit. If I hear someone say that they want to work on open-source all day, I'm not going to hold that against them but I might ensure they'd also be comfortable doing proprietary client work. I also like to get a sense of whether someone hates meetings, whether they prefer or avoid pairing and mobbing, and how much they want to be interacting with client stakeholders.

### Ideal process from requirement --> Production

I usually phrase this question along the lines of: "OK, say that you picked up a work item / story to begin implementing it. All of the details are there and from a business perspective, you know exactly what work to do. Talk to me about your ideal process, from the time you pick up that story to work on it to the time it's in production."

* **When I ask this question:** When I feel like someone may not grasp important lifecycle concepts such as source control, branching, integration, testing, or deployment. I also tend to ask it if someone claims DevOps expertise.
* **Why I ask this question:** I want to ensure that someone thinks about code in a way other than "I write it and I throw it over a wall for other people". I need developers on my team to at least understand that these lifecycles exist and who want them to be a quality lifecycle.
* **What sorts of answers do I look for:** I look for anything other than a shrug here. Hopefully someone mentions source control, creating a branch, building the code in a test-first fashion, getting feedback from a CI system along the way, merging the code, having a CI system automatically deploy and promote code across environments. This is usually where I can tell if developers who claim automated testing experience still see it as a separate phase of development rather than their responsibility.

### What's something you are excited about in the .NET world right now?

* **When I ask this question:** When I want to see if someone is invested in the industry or if they've been heads down for a while. (absence of this isn't necessarily a mark against someone)
* **Why I ask this question:** It's important to me, especially in a consulting environment, that developers be aware of the larger ecosystem and things that are going on. I also ask it because I almost always learn something. Quite frankly, I often ask it to identify devs who don't care. Even strictly 9-5 developers on legacy systems should take a look around every so often.
* **What sorts of answers do I look for:** Anything. Folks might mention their excitement around the OSS-ing of large parts of the .NET ecosystem. They might get excited about .NET Core and its cross-platform capabilities. They might be excited about an IDE tool they learned about, or a library that made their lives easier, or a conference they just heard about and what to attend. I look for folks to be able to point to _something_ in the community / ecosystem that they think is a little cool. It's a red flag for me if a question this broad doesn't elicit a meaningful response.

### What are you looking for in a long-term fit?

* **When I ask this question:** When I see a lot of gaps on someone's resume or many short-term gigs (which again, are not disqualifying on their own)
* **Why I ask this question:** I usually ask this whenever I ask the day-to-day question, because it's interesting to see whether those two answers map well together and to follow up if they don't. I also want to make sure everyone's got their eyes open in terms of expectations.
* **What sorts of answers do I look for:** Here again, I'm looking mostly for honesty. The rest is all about fit. If someone is looking to become a leader on a team of other leaders, or to solve important problems for clients using new technology or good techniques for revitalizing legacy systems, chances are there's a fun spot for them at my employer.

### What is an ORM? What are its pros and cons?

* **When I ask this question:** When I feel like someone may not have experience working with data in modern applications, many of which use object-relational mappers (ORMs)
* **Why I ask this question:** I want to know not only that the interviewee knows what an ORM is, but that they understand they're not the end-all be-all in the world.
* **What sorts of answers do I look for:** I want to make sure that someone can speak to what an ORM is and talk about mapping objects to database tables. Ideally I like for someone to talk about impedance mismatch and some of the performance penalties of using ORMs. Id they are able to contrast various tools such as ADO.NET, EF/NHibernate, Dapper, etc. that's a big plus.

### How do you ensure quality in an enterprise environment?

* **When I ask this question:** When I feel like someone may have been in an environment that didn't value quality development practices, or when they raise concerns for me on other questions about process / attention to technical excellence.
* **Why I ask this question:** This is an open-ended question that allows someone to explore what quality means to them.
* **What sorts of answers do I look for:** I want someone to indicate that quality is everyone's job and not outsource it to another group / department. Someone should at least mention automated tests or a test harness during this discussion. If someone gets into the cultural aspects of quality -- feedback loops, continuous integration and deployment, empathetic code reviews, etc. then we're in a pretty good place.

### Tell me about different types of automated tests.

* **When I ask this question:** If someone doesn't mention automated testing experience.
* **Why I ask this question:** Automated testing is extremely important to me, and I expect developers to know a little bit about it unless they're coming in as a junior.
* **What sorts of answers do I look for:** If someone mentions unit testing, integration testing, and functional or acceptance testing and can speak to the merits / place of all three, we're in a pretty good spot. I love to hear any discussion about testing quadrants or the testing pyramid, and I love to hear someone discuss test frameworks (NUnit, xUnit, etc.) and other testing tools (e.g. test double frameworks, SpecFlow, or Selenium).

### If you were building a modern web application with server and client aspects, what technology stack would you start with today and why?

* **When I ask this question:** When someone needs to have some high-level architectural capability, or when I want to step into a different head-space or have someone diagram a little bit.
* **Why I ask this question:** I usually learn something from someone's proposed stack. I'll often give a small hypothetical and walk through how that would work in their mind.
* **What sorts of answers do I look for:** I look for someone who isn't blatantly misusing tools / libraries beyond their intended purpose. I also look for someone who is able to zoom our a little bit and discuss trade-offs. Lastly, I'm looking for understanding of high-level concepts ("Oh, an MVC framework, nice! Tell me about what MVC means. When would that _not_ be a good choice?").
