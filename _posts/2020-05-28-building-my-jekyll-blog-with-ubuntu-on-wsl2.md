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

Then, I went back and forth on dependencies and installation stuff, but it wasn't that bad.

## The shortcut, if you don't want to do all of that back and forth

* Update package list: `sudo apt update`
* For Ruby: `sudo apt-get install ruby-full`
* For Bundler: `sudo gem install bundler`
* Install dev dependencies that my gems need: `sudo apt-get install make gcc gpp build-essential zlib1g zlib1g-dev`
* Run `bundle install` which prompts for my password when things need elevation
* _now_ it works.
* Run `bundle exec jekyll serve`
* Watch it build and run in Linux and watch my blog be available in Windows.

## The (more painful) long steps

I re-did this again the hard way, for you dear reader! I'll try to capture what I learned along the way.

* Install Ubuntu 20.04 LTS from the windows store. Start it up set a PW, etc.
* `mkdir repos` to create a directory for my repositories
* `cd repos`
* Pulled my repo: `git clone https://github.com/SeanKilleen/seankilleen.github.io.git`
* Update package list: `sudo apt update`
* Install ruby: `sudo apt-get install ruby`
* Bundler: `sudo gem install bundler`
* Open my repo: `cd seankilleen.github.io`
* `bundle install`
* See an error: `Gem::Ext::BuildError: ERROR: Failed to build gem native extension.` Also: `An error occurred while installing commonmarker (0.17.13), and Bundler cannot continue.`
* Do some googling, see that I might need more of ruby
* `sudo apt-get install ruby-full`
* Try again: `bundle install`. See error: `make not found`
* `sudo apt-get install make`
* Try again: `bundle install`. Get error: `make: gcc: Command not found`
* `sudo apt-get install gcc`
* Try again: `bundle install`. We get further! Commonmark is now installed. but we see another error: `make: g++: Command not found`
* `sudo apt-get install gpp` (got lucky here and assumed `++` translated to `pp`)
* Try again: `bundle install`. Same error. Weird.
* Google. Find [an answer that suggests](https://askubuntu.com/questions/284779/g-installation) using `build-essential` instead. Seems reasonable. (I think I also could have actually done `sudo apt-get install g++` as well. So much for my translation!)
* `sudo apt-get install build-essential`
* Try again: `bundle install`. We get farther! `eventmachine` is now installed.
* nokogiri installation fails. See error: `zlib is missing; necessary for building libxml2`
* `sudo apt-get install zlib`. Not found. 
* Google. [Find some help](https://www.systutorials.com/how-to-install-the-zlib-library-in-ubuntu/). Apparently it's `zlib1g`.
* `sudo apt-get install zlib1g`. Weird. It's already installed? 
* The error is a build error, so let's try `sudo apt-get install zlib1g-dev`.
* Try again: `bundle install`. INSTALLATION SUCCEEDS!
* `bundle exec jekyll serve`
* Things are built an served on `localhost:4000`. Looks good!

---

Sweet! Happy WSLing, all.