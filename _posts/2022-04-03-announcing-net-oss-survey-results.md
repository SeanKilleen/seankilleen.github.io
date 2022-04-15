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

## Testing a Chart

<canvas id="myChart" width="200" height="200"></canvas>

<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>

<script>
const ctx = document.getElementById('myChart').getContext('2d');
const myChart = new Chart(ctx, {
    type: 'bar',
    responsive: true,
    data: {
        labels: [
          'One-time donations', 'Recurring', 'Small Monetary Donations','Larger monetary donations'],
        datasets: [{
            label: '# of Votes',
            data: [19,26,18,21],
            borderWidth: 1
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
