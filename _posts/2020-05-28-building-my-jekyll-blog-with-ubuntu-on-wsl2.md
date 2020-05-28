---
title: Building my Jekyll blog with Ubuntu on WSL2
comments: true
tags:
  - wsl
  - wsl2
  - ruby
  - jekyll
  - ubuntu
date: 2020-05-28 10:52 -0400
---
The steps weren't entirely obvious to me so I thought I'd write about it here for others who are newer to that ecosystem.

Windows 10 v2004 is available, and with it comes the addition of long-awaited toolset -- WSL2, the successor to the original Windows Subsystem for Linux. WSL2 is great -- much faster, and it uses an actual Linux kernel, making it 100% Linux compatible. 

## High-level view 

Here's what I did.

* Installed the Win10 May 2019 (v2004) update
* Installed WSL2 (essentially following the prompts along the way)
* Installed Ubuntu 20.04 from the store, which installed it using WSL2.

(If you'd like help on any of the above, leave a message in the comments and I'll expand on this blog post.)

* Pulled my repo
* Went back and forth installing ruby and gems, installing missing libs along the way. 

## The shortcut, if you don't want to do all that

* For Ruby: `sudo apt-get install ruby-full`
* For Bundler: `sudo gem install bundler`
* Install dev dependencies that my gems need: `sudo apt-get install make gcc gpp build-essential zlib1g zlib1g-dev`
* Run `bundle install` which prompts for my password when things need elevation
* _now_ it works.
* Run `bundle exec jekyll serve`
* Watch it build and run in Linux and watch my blog be available in Windows.

Sweet!