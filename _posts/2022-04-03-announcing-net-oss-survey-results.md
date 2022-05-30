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

## About These Results

### Feedback welcome!

I am not a data scientist nor a data visualization expert. I am doing my best to interpret numbers, but we all know that can be problematic.

I encourage you to respond with ways I might be able to better visualize or interpret the data. Comments are welcome, and you can even submit pull requests against this post if you'd like.

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

Impact is a great brainstorming technique to set up experiments that lead from concrete actions to hopefully moving toward a goal. In our case, the goal will be increasing a certain type of OSS maintainer satisfaction in the .NET Community. We'll have an impact map for each type of satisfaction, though really they are all part of one goal: "Happier .NET OSS Maintainers."

## Test Mindmup iFrame

<iframe src="https://atlas.mindmup.com/seankilleen/test_map/index.html" width="100%" height="1000"></iframe>

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
