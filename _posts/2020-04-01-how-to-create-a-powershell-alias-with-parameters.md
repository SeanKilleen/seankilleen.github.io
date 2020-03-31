---
title: 'How to: Create a PowerShell alias with parameters'
comments: true
tags:
  - PowerShell
  - aliases
date: '2020-04-01 10:00 -0400'
---
I was recently asked how to create a PowerShell command alias that accepts parameters.

The asker wanted to know how to run a command such as: 

`ffmpeg -i "take 1.avi" -vcodec h264 -acodec mp2 output.mp4`

but have the input and output values as parameters to the alias.

## You can't do this with PowerShell...

In PowerShell, aliases are meant to be for hard-coded commands and aren't able to be parameterized. Bummer.

## ...but you can accomplish the same thing by storing a function in your profile!

We'll be able to get the desired outcome in just a few steps, by creating our own function and then loading that whenever PowerShell loads, via the `Profile.ps1` file.

## Step 1: Create a PowerShell function

We'll create a function to do what we need to do, with the appropriate parameters.

For example, let's say we call the function `Encode-Video`: 

```powershell
function Encode-Video([string]$VideoFileName, [string]$OutputFileName)
{ 
    ffmpeg -i "$VideoFileName" -vcodec h264 -acodec mp2 "$OutputFileName" 
}
```

## Step 2: Create a Profile.ps1 file

Powershell handily uses a variable for your profile file, `$profile`.

So, if you were to run:

```powershell
notepad $profile
```

You'll either open the existing `Profile.ps1` file, or be prompted to create a new one.

## Step 3: Paste your function and save

Paste the function you created in step 1 into the `Profile.ps1` file and save it.

## And that's it!

Now, whenever PowerShell loads, the definition for that function will also be loaded from your profile file, and you can use it as much as you'd like.

Happy scripting!
