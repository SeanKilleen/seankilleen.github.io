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

## The Overall Goal of This Survey

I hoped this survey can drive a few different outcomes:

* Surfacing quantitative and qualitative feedback on the .NET OSS Maintainer experience
* Serving as feedback into an impact map of the type of impact we'd like to make for .NET OSS Maintainers
* Serving as the starting point for a backlog of re-launching <https://awider.net>, a site I'd dreamed of starting long ago at .NET Fringe and have been meaning to get off the ground ever since.

## How I'm breaking down the results

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
* The qualitative responses in many cases were lengthy and thought-out, which I appreciated. Those who responded appeared to be very passionate.
* There are many ways to be an OSS developer. This might seem obvious, but it was very helpful for me to see how perspectives differed across those who are running businesses based on OSS, to those who consider it purely a hobby and avoid any form of monetization in their project, and everyone in-between. I think it's important to keep in mind that the goals are often different across community segments in order to work toward OSS maintainer happiness in general.

## Support Gaps by Category [^1]

<canvas id="overallSupportResults" width="200" height="200"></canvas>

Observations here: 

* Not surprisingly, 

[^1]: Methodology -- I arrived at these numbers by: taking the 7-point likert scales for how much a given type of support mattered and how much a the respondent felt supported. I converted those numbers to a `-3` through `3` scale to help visualize them. I showed those amounts, and the gap between them. Showed the results in order of smallest support gap to largest support gap. 


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

const ctx = document.getElementById('overallSupportResults').getContext('2d');
const myChart = new Chart(ctx, {
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
</script>