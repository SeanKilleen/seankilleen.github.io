---
title: "OSS Maintainer Support Survey Results!"
comments: true
tags:
  - dotnet
  - oss
  - community
  - survey
date: 2022-04-03 16:00 -0500
excerpt: "The results are in. Where do we go from here?"
header:
 overlay_image: /images/overlays/unsplash/isaac-smith-AT77Q0Njnt0-unsplash.jpg
 overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
 caption: "Photo credit: [**Isaac Smith @ Unsplash**](https://unsplash.com/@isaacmsmith?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
---

I extended the survey response until the end of March because there were some kind folks who wanted to promote it further. But since then I've been thinking about the best way to interpret and showcase the results. I'm just one person with limited resources, but I'm open to suggestions if you'd like to use the edit or issues link at the top of this post.

## Ooof...turns out there's a lot to this. :sweat_smile:

I initially planned to have this post done by March. A new job, life, and the sheer amount of things I wanted to do with it got in the way. Note to self: next time, smaller pieces and faster. A lesson I think I should have learned by now.

## About These Results

### Feedback Needed!

I am not a data scientist nor a data visualization expert. I am doing my best to interpret numbers, but we all know that can be problematic.

I encourage you to respond with ways I might be able to better visualize or interpret the data. Comments are welcome, and you can even submit pull requests against this post if you'd like.

Additionally, part of this post is to offer up impact maps that include actions we could possibly take as a community to improve these goals. I'd _really_ love your help there, as impact maps are best when they're a brainstorming. Drop any additional suggestions for an impact map in the comments, or feel free to drop it in a message to me on any social channel.

### Where's the data?

You can see the raw, anonymized data [in this Google Sheet](https://docs.google.com/spreadsheets/d/1zIVaW2j_9RZB_PxPVMTO2yC4kpA4zO2jrEiAe80ra-c/edit?usp=sharing).

### The Overall Goal

I hoped this survey can drive a few different outcomes:

* Surfacing quantitative and qualitative feedback on the .NET OSS Maintainer experience
* Serving as feedback into an impact map of the type of impact we'd like to make for .NET OSS Maintainers
* Serving as the starting point for a backlog of re-launching <https://awider.net>, a site I'd dreamed of starting long ago at .NET Fringe and have been meaning to get off the ground ever since.

## How These Results are Structured

I'll start with some general observations and numbers.

Then, for each type of feedback I solicited, I'll try to cover:

* The types of potential help that resonated with respondents
* Qualitative feedback for that type of support -- quotes and my observations
* An embedded [impact map](https://www.impactmapping.org/) for how we might want to improve this aspect for maintainers

Along the way, I'll try to break down how I obtain numbers the first time I use them. If you've got questions, leave a comment and I'll clarify. And if an issue is uncovered with my methods, I'll be happy to update or add to the results to ensure they're as accurate as possible; I've never claimed to be a statistician.

## General Observations

* The survey was too long. I figured this might be the case, and I'll be working to limit it in the future.
* The number of responses was much lower than I was hoping for. There were 42 responses in total. This doesn't allow for much confidence in the overall numbers, but we'll work with what we have.
  * This could be due to survey length or the limitations of my own reach and those who broadcast it. Or, it could be indicative of the level of engagement in the broader overall ecosystem. I'm not sure the results tell us that one way or the other.
* The qualitative responses in many cases were lengthy and well thought-out. For those of you who were worried about passion in the .NET OSS space dwindling, don't worry -- I found some!
* There are many ways to be an OSS developer. This might seem obvious, but it was very helpful for me to see how perspectives differed across those who are running businesses based on OSS, to those who consider it purely a hobby and avoid any form of monetization in their project, and everyone in-between. I think it's important to keep in mind that the goals are often different across community segments in order to work toward OSS maintainer happiness in general.
* A number of respondents assumed I was writing this from behalf of the .NET Foundation, and seemed to target their responses toward things the Foundation is doing or not doing. I think that speaks to the Foundation being the largest game in town for .NET OSS support at this point, and how folks feel about that.

## Burnout

When asking respondents how burned out they felt about their project and OSS in general:

<canvas id="burnoutResults" width="200" height="200"></canvas>

Observations:

* This cohort indicated less burnout than neutral on average
* On average the difference between burnout on a given project and burnout toward OSS in general was .73, or less than one number difference. This suggests that authors might link their view toward OSS in general with work on their projects.
* One Third of respondents rated their burnout levels as higher than neutral. In my own personal experience, people tend to underestimate said burnout, which does give me some concern about the state of things overall, given that I'm also concerned that more burned out folks wouldn't have responded at all.

## Stagnation

We asked:

> What is the likelihood that your project(s) will begin to (or already has begun to) stagnate

Across two dimensions:

* A lack of time, energy, or resources
* A lack of capability

<canvas id="stagnationResults" width="200" height="200"></canvas>

Observations:

* .NET OSS Maintainers remain confident in their capabilities to deliver their projects. This indicates to me that authors take pride in their work or have selected projects they feel they can contribute to.
* I will be interested to see how this is borne out in the qualitative responses in the support section. Could those coming responses reveal implicit capability gaps that can be addressed for happiness? Are maintainers associating their own capability with a lack of help?
* 45% of respondents answered above neutral for stagnation due to lack of time / resources. If this number holds true across the larger community, then my guess is we face a coming slow-down in the .NET OSS ecosystem.
* Combined with the answers on burnout, it is more crucial than ever that others in the community step up to support these projects in healthy ways, and it will be crucial to enable them to do so without additional burden on the maintainers.

## Support Gaps by Category [^1]

<canvas id="overallSupportResults" width="200" height="200"></canvas>

Observations:

* Not surprisingly based on what I'd heard previously, `Funding` and `Contributions` are the largest gaps. These topics and how to address them seem to be a perennial conversation in the OSS space (and particularly the `Contributions` topic in the .NET OSS space).
* I'm going to pay special attention to the `Thanks` and `Publicity` categories, as I imagine there have got to be some "low-hanging fruit" there in terms behaviors we can better enable.
* `Non-Code Contributions` had a bit of a higher gap than I thought it would. Again, there may be some great things we can do to enable support even from those who may not feel comfortable enough to submit code contributions.

## Going Deeper: Types of Support

For each of the sections below, I'll dive into the top commonly recognized types of support and then attempt to extrapolate an impact map based on the responses I've gotten in that category.

### Quick Intro: What's an Impact Map?

[Impact mapping is a technique coined by Gojko Adzic](https://www.impactmapping.org/) that helps us think about how to make a certain kind of impact or more toward a goal. It works outwards in layers to map:

* The goal or impact (this is the center node on the map)
* Those people / roles / personas who can help us achieve (or who can hinder) our goal
* The actions they could take to help or hinder our goal
* Things we can do to influence or dissuade them from taking those actions

So to summarize, an impact map can be read from the outside to the center as: "If we take this action, then we might influence this behavior change, in this person/group, that moves us closer to this goal".

Impact mapping is a great brainstorming technique to set up experiments that lead from concrete actions to hopefully moving toward a goal. In our case, the goal will be increasing a certain type of OSS maintainer satisfaction in the .NET Community. We'll have an impact map for each type of satisfaction, though really they are all part of one goal: "Happier .NET OSS Maintainers."

One more thing I like about impact maps? They help me move beyond a feeling of stagnation and helplessness, toward action. These are large, complex problems, and sometimes it might not be clear what we can do about them. My hope is that impact mapping leads us to places to start working toward change.

### Funding / Monetary Support

The top 5 welcomed types of support were (perhaps unsurprisingly):

1. Recurring donations (63.4% of respondents)
1. Purchasing a support agreement (58.5%)
1. Larger monetary donations (51.2%)
1. One-time donations (46.3%)
1. Small monetary donations (43.9%)

Notable listed challenges:

> * Getting incentives to the right people at companies where they could provide financing
> * if project succeed then there is a high risk that MS will build its own tool like that
> * There are no mature tools for getting monetisation from OSS
> * With a larger team, it becomes very difficult to distribute financial support fairly
> * We give support for larger companies and the hardest part ia convincing them to purchase support license.
> * corporate entities less likely to donate
> * I'm not sure any realistic donation amount would be able to free hours up from my day job.
> * I often muse if things would be different if Microsoft (maybe via the .NET Foundation) promoted companies supporting OSS projects in their ecosystem (like all the projects in the .NET Foundation).
> * if you're really good at running your projects then you're rewarded not with more contributions, but higher expectations.
> * the challenge/obstacle is explaining to consumers the value in providing these contributions
> * Corporations do not have processes for "donating", they have process for buying stuff.
> * To generate any measurable income, a forcing function like license terms needs to be involved
> * .NET has traditionally been "Enterprise" oriented which attracts a different sort of user base
> * My resistance to treating them as anything other than hobbies, written by myself, for myself.
> * [Risk of] non-paying users into paying sponsors, some which then feel entitled to be treated as customers
> * To be able to constantly provide updates in a sustainable way, you have to be paid for that and focus on that.

Notable general feedback:

> * Support for promoting / monestising or coaching on how to monetise OSS
> * Working on a GitHub sponsor accessible private nuget feed
> * It would be great if the Foundation could provide the 506 non profit services as Open Collective does. Just that without (or a much smaller) fee
> * There are over 50 million downloads of my libraries and I've made less than 2 months wages in nearly 2 years of offering support agreements.
> * I provide [Redacted] under what's sometimes called an "open core" model where the basic framework is permissive but more features falls under licensing terms. In this case the terms include a non-commercial clause that requires payment when the software is used for commercial purposes. This has been quite successful and earned an order of magnitude more than donations do
> * Setup a 503.c3 if you can, there are online websites for setting it up.
> * with money comes expectations and obligations, which might not drive maintainer motivation and happiness in the right direction.

Based on this feedback, I've created an initial impact map (reminder: I'd love your feedback in the comments on additional items we could add!)

<iframe src="https://atlas.mindmup.com/seankilleen/_net_oss_improved_funding_monetary_support/index.html" width="100%" height="1000"></iframe>

### Publicity

The top 5 welcomed types of support were:

1. Blog posts exploring your project's features or what you've accomplished with it (92.3% of respondents)
1. Recommending your project to others (92.3%)
1. Supportive tweets from those in the community with many followers (87.2%)
1. Meetup / conference talks on your project (76.9%)
1. Mentions and showcases on video, e.g. Twitch or YouTube (66.7%)

Notable challenges:

> * if it's allowed, a developer group may be able to use it, but not be in the position to publicize that usage and the benefits it provided
> * More corporate awareness and leadership level individuals need to be looped in
> * There are not many official .NET or Microsoft channels which can promote OSS projects
> * I'm not intrinsically motivated to promote projects, and I don't have experience building a community.
> * I think it's mostly a discoverability issue at this point
> * needing to split time between developing and "marketing" means not a lot of sharing / content creation.
> * We're a vital but not very sexy project. That means we don't get talked about a lot (unless people complain)
> * How do you get your project in front of people if you don't have a following already?
> * Don't know how to ask for it

Notable general feedback:

> * Chatter is ... often negative
> * would really help if Microsoft or the .NET Foundation has someone who would proactively help the projects with marketing
> * Any further publicity is likely to increase the maintenance burden rather than necessarily be a help
> * most interactions with non-contributors are bug reports or help requests.
> * this is something one should also promote from the side.
> * you basically have to hustle your projects in front of other devs. Whether that is tweeting about the project so often or nearly spamming it on Reddit.
> * For sure if you want to make your project successful, then it's needed to invest in documentation, blog post, community around it.
> * I've been building this since 2008 and probably should do more self promotion.
> * Our project was mentioned on the [Redacted] blog which resulted in many new users

The impact map draft:

<iframe src="https://atlas.mindmup.com/seankilleen/_net_oss_improved_publicity/index.html" width="100%" height="1000"></iframe>

### Thanks

The top welcomed types of support were:

1. Tweets of praise / thanks (84.6% of respondents)
1. Messages where your project operates (Slack, GitHub Discussions, etc.) to thank the team (69.2%)
1. One-on-one messages (e-mail, DMs) listing the impact of your work (59%)

Notable challenges:

> * I suspect very few people actually take the time or energy to reach out in this manner.
> * it's about the only support I get right now
> * Needs to be raised and brought into the corporate open source culture.
> * I appreciate a lot of things but even I don't personally thank every project that I use.
> * An honest thank you is worth more than a couple of $$$
> * DMs does not scale, public discussions do.

Notable general feedback:

> * I would not like to have issues on GitHub telling me only that it's a good product, I have work to close it again.
> * There's not a good way (other than starring the project?) to communicate this (say) on GitHub without creating an issue/discussion that's just "clutter".
> * Ironically, I see the most public expressions of praise for my library on the bug tracker for a _competing_ library where users write "I switched to [my library] and it fixed this bug!"
> * Community around [Redacted] or my samples is also one of the things that makes me keep doing it.
> * It hardly ever happens (like maybe 50 times in almost 18 years of running the project).
> * Feels good every time.
> * Personally, this is a huge motivator for me. A single "this project is great, thanks" response is enough to power me though a tough feature, etc.
> * The folks that we would be trying to reach aren't on those mediums
> * It needs to be in a public forum...so everyone should get credit.
> * You're making me realize that I don't reach out with messages of support/thanks to the many, many OSS projects I use

The impact map draft:

<iframe src="https://atlas.mindmup.com/seankilleen/_net_oss_improved_thanks/index.html" width="100%" height="1000"></iframe>

### Code Contributions

The top welcomed types of support were:

1. Support on basic/help wanted tasks (80.5% of respondents)
1. Bug fixes (80.5%)
1. Feature Coding (75.6%)
1. Automated Tests (68.3%)
1. Additional Core Maintainers (65.9%)

Notable challenges:

> * Onboarding new developers has a ramp up cost, that does not tend to get paid back if they then don't proceed with doing any work. So we need a mechanism which finds people who are genuinely interested in the project over the hackathon.
> * Right now the capacity for reviewing pull requests is the bottleneck for us, so it we found several new contributors quickly, it would probably demotivate them as they would have to wait some time until someone looks at their PRs.
> * Getting people to read and respect contribution guidelines
> * Most contributors seem stretched for time, sometimes taking a week for each iteration of PR feedback.
> * If the number of contributions grow, it'll also costs me and my project companion more time to review everything. 
> * Better roadmap
> * They end up moving on or becoming less active so it is a constant struggle to keep a strong team.
> * "maintenance mode" for stable/mature projects is not very exciting/enticing for attesting new core maintainers. 
> * We are very cautious on how and what changes should be made.
> * We needed to reject most contributions because they broke specific use cases.
> * It can take a very long time to shepherd a community contribution to the desired level of quality for the project
> * One-off "Fly-by" contributions are far more common, but these contributors don’t stick around to support/maintain their contributions, leaving the maintenance burden on the existing team. As such, I don’t generally accept code contributions for any major new functionality as the negative impact generally outweighs the positive.
> * Frustration that people who are professional software developers and apparently need this library for their day job seemingly have no interest in debugging a problem that's blocking them, or in writing the bugfix that would solve their problem.
> * Organizing in a way that allows a distributed group of folk can drive a project is hard

Notable general feedback:

> * PRS should usually be preceded with a discussion / issue
> * Be useful to sometimes have someone from Microsoft come in and help us with a challenging issue that has more domain expertise then me or the team.
> * On a few occasions, I had to undo someone's work or not accept a PR, but most of the help I've received has been really great and I appreciate each person's contributions.
> * as a maintainer you take responsibility for supporting, updating, and managing all new code that comes into the code base. This can be a blessing and a curse
> * People like to feel like they're helping.
> * Learned to say thanks even when rejecting an idea and remind oneself to not be pressured into taking contributions you don't feel right with
> * It's important to maintain focus -- I recently had to tighten my contribution guidelines to keep things manageable and turn down some PRs.
> * Dealing with people is usually more stressful than dealing with code
> * This kind of support is generally only valuable if the contributor is willing to stick at it for the long haul.
> * Automation of work and defining processes only goes so far, and ultimately it's up to the humans who show up to help actually achieve things in OSS projects


The impact map draft:

<iframe src="https://atlas.mindmup.com/seankilleen/_net_oss_improved_code_contributions/index.html" width="100%" height="1000"></iframe>

### Non-Code Contributions

The top welcomed types of support were:

1. Creating new documentation (89.7% of respondents)
1. Keeping documentation current (89.7%)
1. Clearly written bug reports (or clarifying other reports) (66.7%)
1. Web site / communication support (64.1%)
1. Enhancement suggestions that are supportive and detailed (53.8%)

Notable challenges:

> * Finding people you can trust
> * The vast majority of issue reports are low-quality and low-effort (eg lacking details to reproduce the issue etc) despite a lot of effort going into creating issue templates. 
> * Very little interest in maintaining documentation.
> * It requires proper CI process.
> * They are probably the least interesting areas to support - if I can't get someone to contribute code, I doubt I'm going to get someone to contribute any of these things.
> * We don't have any technical writer resources.
> * This is the hardest thing to organize as it lies outside the skillset of most software developers. It's like technical writing plus project management plus product management
> * Are there any good automated documentation tools? I'm only aware of the older stuff from XML comments and options for static generated sites which don't work well for ASP.NET Core sites.
> * I prefer to do this on my own, although localization would be great.
> * Triaging issues isn't easy to delegate, you might have people speaking on your behalf that isn't in line with project ideas or agenda. 
> * Feels very "unglamourous"; I don't really imagine there would be a lot of people interested in participating.
> * We do receive high quality issue reports sometimes, but these are in the minority. 
> * Good quality documentation contributions are very rare.

Notable general feedback:

> * Be useful to get a shared technical writer between projects paid for by a core community.
> * A lesson learned would be that users really value examples and I probably should have emphasized that more early-on.
> * We have README guidance on how to contribute to docs, how to run them locally and automated process around that. That definitely helps.
> * A few people have gone into documentation and fixed spelling or clarified a point on occasion. This is kind of them. 
> * We've hired several people as Developer Advocates. We pay these people to create some content - they organize regular meetups, write articles and record videos.
> * Some of the newer projects are putting requirements on docs being created as part of feature completion but others have struggled

The impact map draft:

<iframe src="https://atlas.mindmup.com/seankilleen/_net_oss_improved_non_code_contribution/index.html" width="100%" height="1000"></iframe>

### Delivery Support

The top welcomed types of support were:

1. CI/CD Support (66.7% of respondents)
1. General DevOps Support (50%)
1. Release Management Help (45.8%)

Notable challenges:

> * Knowing about best-practices for DevOps and knowing who to ask these is a challenge
> * For security reasons, this requires a higher level of trust
> * It is highly specialized support and requires a lot of co-ordination with the maintainer for what is best-fit for the project
> * CI CD is tough for a non expert.
> * Finding the time to set it up.
> * We would want to avoid the problems associated with accounts held by others that might be used for purposes we did not give permission for (see recent .NET Foundation incidents) 

Notable general feedback:

> * A lesson learned is how important this can be. A good CI/CD process saves hours of time that could be spent on issue support, feature building, etc. It's often overlooked by new maintainers and is easy to put on the back-burner without realizing what a benefit it is. This is probably one area where an external support structure could have a big impact.
> * My project has relied on free cloud-hosted CI for years (Travis, Appveyor, Azure Pipelines). This has been an immensely positive change for OSS in the last decade.
> * Help on tests stability or optimisation might be good. If we decide to build cloud solution around [Redacted] then devops help would be definitely helpful.

The impact map draft:

<iframe src="https://atlas.mindmup.com/seankilleen/_net_oss_improved_delivery_support/index.html" width="100%" height="1000"></iframe>

### Community

The top welcomed types of support were:

1. Recruiting others to get involved (86.5% of respondents)
1. Participating in the community Slack, Discord, etc. (54.1%)
1. Moderation of Conversations (14%)

Notable challenges:

> * People walk again after they have their issues fixed.
> * The effort required to moderate and answer support/discussions is huge. I don’t have the time for it so I no longer allow support/discussions on our issue tracker and limit it to bug reports only.  
> * It may require more management to make sure that non-core team contribution are not making more noise than help it brings.
> * Hardly enough time for my own projects so I can't expect others to have time to contribute in this to mine.
> * It takes a lot of commitment to be actively involved in a project like [Redacted]. And if you can find somebody like that, you also need to ensure that person has the same mindset about code quality, TDD, etc
> * Who would actually want to help with recruiting for random projects? With so many projects from random little things to more established side hustles, actually getting help recruiting people seems like a crazily difficult job.

Notable general feedback:

> * For sure, getting right community, with people feeling invited to discuss, contribute is really helpful. We have some people on our channels that are helping others. I started my journey with [Redacted] by answering questions, helping others before I joined the core team.
> * I would like to see more presentations / show and tell
> * Most people don’t realize that just spreading the word has such a great potential.

The impact map draft:

<iframe src="https://atlas.mindmup.com/seankilleen/_net_oss_improved_community/index.html" width="100%" height="1000"></iframe>

### Tooling

The top welcomed types of support were:

1. Subscriptions to paid tooling that doesn't offer free OSS licensing (75% of respondents)
1. Cloud Provider Credits (68.8%)
1. SaaS Credits of Some Kind (53.1%)

Notable challenges:

> * Hosting costs are often hard to quantify for developer tools
> * not all tools are owned by large corporates, and their survival often depends on paid customers - so OSS credits are often not the best solution here, nor a scalable one.

Notable general feedback:

> * Azure credits and similar should be provided for any healthy OSS project. Maintainers should not need to pay from their own pockets. If tooling/subscriptions not provided by 3rd party, then project need to raise funds in order to cover the costs.
> * We got JetBrains licences for OSS, which is incredible help, and using extensively GitHub actions and Azure Devops. That helped us to build the right CI process with matrix builds etc
> * Very hard to connect with people who can grant this support
> * We used to get VS licenses and be able to give VS licenses to people contributing to the project from the .NET Foundation. That doesn't seem to happen any more.
> * MVP status gives our two core developers visual studio, but be useful to have visual studio enterprise subscriptions to our other core members.
> * We sign up for a lot of the "free for OSS" options from providers
> * It's not a big deal but covering the costs for running our website and build/test infrastructure  would help us - it's a few virtual machines and databases in Azure.
> * Love TechSoup.org's HUGE support of the community!!!  

The impact map draft:

<iframe src="https://atlas.mindmup.com/seankilleen/_net_oss_improved_tooling_support/index.html" width="100%" height="1000"></iframe>

### Time

The top welcomed types of support were:

1. A long-term (paid) sabbatical to focus on OSS (71% of respondents)
1. Others supporting you during unpaid time in order to focus impact (58.1%)

Notable challenges:

> * Finding people willing to pay
> * It would be expensive
> * with a large team, who gets the benefit of this support?
> * the amount of funding available for something like a sabbatical is likely not even close to what an experienced developer would be making "normally."
> * Not sure the amount of money I'd need to take time away from work could ever be something that someone is willing to donate/supply for my projects.
> * The donations/sponsorship can't even compensatie for one hour of my paid job. 
> * .NET community is typically not open for paying
> * hard to start such process not having enough experience in monetisation.
> * Irregular injections of time/money aren't going to help long term.

Notable general feedback:

> * Occasionally, I get busy with work or other projects and having someone else responding to questions or fixing bugs would be nice.
> * We use my project at work, so I've had the ability (within reason) to put time at work into solving critical bugs, instead of it solely being personal time.
> * I'm currently on said "long-term sabbatical" paid for by savings from self-employment contracts, trying to build this OSS product/company.
> * Would have been cool to have someone else responding to questions and fixing a few things so that people don't get the impression that the project is dying.
> * Just not being constantly dragged into issues and pull requests would be nice. I'd like to get around to actually coding rather than managing.

The impact map draft:

<iframe src="https://atlas.mindmup.com/seankilleen/_net_oss_improved_time_support/index.html" width="100%" height="1000"></iframe>

<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>

<script>
const CHART_COLORS = {
  red: 'rgb(255, 99, 132)',
  orange: 'rgb(255, 159, 64)',
  yellow: 'rgb(255, 205, 86)',
  green: 'rgb(75, 192, 192)',
  blue: 'rgb(54, 162, 235)',
  purple: 'rgb(153, 102, 255)',
  grey: 'rgb(201, 203, 207)'
};

const ctxOverallSupportResults = document.getElementById('overallSupportResults').getContext('2d');
const ctxBurnoutResults = document.getElementById('burnoutResults').getContext('2d');
const ctxStagnationResults = document.getElementById('stagnationResults').getContext('2d');

const overallSupportResultsChart = new Chart(ctxOverallSupportResults, {
    type: 'bar',
    responsive: true,
    data: {
        labels: ['Tooling', 'Delivery Support', 'Thanks','Community', 'Non-Code Contributions', 'Time', 'Publicity', 'Code Contributions', 'Funding / Monetary'],
        datasets: [{
            label: 'Matters',
            data: [-16,-33,20,17,30,27,46,53,45],
            borderWidth: 1,
            backgroundColor: CHART_COLORS.green
        },{
            label: 'Supported',
            data: [-1,-10,-18,-44,-52,-56,-42,-38,-56],
            borderWidth: 1,
            backgroundColor: CHART_COLORS.blue
        },
        {
            label: 'Gap',
            data: [15,23,38,61,82,83,88,91,101],
            borderWidth: 1,
            backgroundColor: CHART_COLORS.red
        }]
    },
    options: {
        indexAxis: 'y',
        scales: {
            x: {
                beginAtZero: true
            }
        }
    }
});

const burnoutResultsChart = new Chart(ctxBurnoutResults, {
    type: 'bar',
    responsive: true,
    data: {
        labels: ['1 - Not at all', '2', '3','4 - Neutral', '5', '6', '7 - Very'],
        datasets: [{
            label: 'Your Project',
            data: [6,7,6,8,9,4,2],
            borderWidth: 1,
            backgroundColor: CHART_COLORS.green
        },{
            label: 'OSS In General',
            data: [6,11,4,7,8,4,2],
            borderWidth: 1,
            backgroundColor: CHART_COLORS.blue
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
const stagnationResultsChart = new Chart(ctxStagnationResults, {
    type: 'bar',
    responsive: true,
    data: {
        labels: ['1 - Not at all', '2', '3','4 - Neutral', '5', '6', '7 - Very'],
        datasets: [{
            label: 'Time / Energy / Resources',
            data: [1,4,11,7,9,4,6],
            borderWidth: 1,
            backgroundColor: CHART_COLORS.green
        },{
            label: 'Capability',
            data: [10,12,9,5,4,1,1],
            borderWidth: 1,
            backgroundColor: CHART_COLORS.blue
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});</script>

[^1]: Methodology -- I arrived at these numbers by: taking the 7-point likert scales for how much a given type of support mattered and how much a the respondent felt supported. I converted those numbers to a `-3` through `3` scale to help visualize them. I showed those amounts, and the gap between them. Showed the results in order of smallest support gap to largest support gap.
