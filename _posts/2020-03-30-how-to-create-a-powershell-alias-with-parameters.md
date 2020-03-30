---
title: 'How to: Create a PowerShell alias with parameters'
comments: true
tags:
  - PowerShell
  - aliases
date: '2020-03-30 11:18 -0400'
---
The example output from the actual command is:

`ffmpeg -i "take 1.avi" -vcodec h264 -acodec mp2 output.mp4`So basically:

function Encode-RyanVideo([string]$VideoFileName, [string]$OutputFileName)
{ 
    ffmpeg -i "$VideoFileName" -vcodec h264 -acodec mp2 "$OutputFileName" 
}