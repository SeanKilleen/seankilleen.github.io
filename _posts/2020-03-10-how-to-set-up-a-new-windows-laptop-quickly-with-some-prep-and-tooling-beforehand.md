---
title: >-
  How to: Set up a new Windows laptop quickly (with some prep and tooling
  beforehand)

tags:
  - setup
  - machine setup
  - chocolatey
date: '2020-03-10 09:00 -0400'
---
I recently got a new laptop (which is incredible! and which I'll do another post on shortly.) Shout-out to my employer, [Excella](http://excella.com/), who picks up 80% of the cost of this machine.

I was very pleased this time at how quickly my new machine was able to become my main machine. In under 2 hours, I was able to close my old laptop and haven't needed to open it since.

Here's how I made that happen.

## Storage: Use the Cloud! (OneDrive in particular)

I'm pretty pleased with the value that my Office365 subscription has given me. One of the valuable parts of the subscription is that it comes with 1TB of OneDrive storage.

I've been storing most of my files within OneDrive, and also using it to back up my Desktop / Documents folders.

## Packages: Chocolatey (and Chocolatey package backup) to the rescue

I install and manage my software as much as humanly possible using [Chocolatey](http://chocolatey.org/). It is the first place I go to when I need to install software, and most of the time there's an official or supported package listed there. I had 122 Chocolatey packages on my old laptop.

I have a particular Chocolatey package, `choco-package-list-backup`, that I use to export my package list & installed programs to OneDrive and Dropbox. I run it on a scheduled task and it does its thing. (Shout out to [Bill Curran](https://www.patreon.com/bcurran3) for making a great tool!). Any machine I own has an up-to-date list of everything that's installed on it.

## Chrome profile sync

I have a lot of extensions, bookmarks, etc. so as much as I don't like Google having even more information about me, I've found that sync settings to be valuable.

## Code: GitHub, GitLab, etc.

If I code anything, it goes into a repository as soon as it's something that I might ever want to keep.

## So, how did this all play out on my new laptop?

* I opened the new laptop and set up Windows. During the course of that setup, I was asked for my Microsoft login, which then also set up my OneDrive account to sync to the new machine. All my files (desktop, docs, etc.) were available to me as soon as I started up.
* I installed Chocolatey, like I normally do with any machine.
* I opened my one-drive folder, found the `packages.config` for my old laptop exported by the Chocolatey package list backup tool.
* I copied and edited the packages config file (removed some old tools I no longer used, etc.)
* I used Chocolatey to install GitHub Desktop and Google Chrome since I knew I'd want to use them in the meantime.
* I ran `choco install packages.config -y` and waited for everything to install.
* While I was waiting for those to install, I used GitHub Desktop to pull down the repositories that I knew I wanted to work with. I also opened Chrome and signed in to sync things up.

## The End Result?

Not long after, my environment was basically ready to go. I found a few more apps that I'd used on the old laptop that were missing, that now had Chocolatey packages, so I installed those too.

In under 2 hours, my new laptop was setup and ready to go, and I felt right at home! A little prep went a long way.

Hope you find this useful. Happy computing!
