---
title: >-
  Jekyll Two Ways on Windows: Installing & building Jekyll / GitHub Pages blogs
  with Ruby on Windows 10
comments: true
tags:
  - jekyll
  - ruby
  - windows
  - github pages
  - wsl
date: '2020-03-03 09:00 -0500'
---
I wanted to write up these steps as I took the time to get my blog up and running on my new laptop, in case it helps someone else get started.

Today, we'll explore two ways of doing this -- the Windows way for those of you who like working via Windows, and the WSL way. I like having both set up so that I can use whatever suits me.

## The Windows Way

### Before we Begin: Pitfalls we'll be avoiding

* **FYI: Normally**, I'd run `choco install ruby -y`, which would install ruby `v2.7.0.1` at the time of this writing. However, that led to a pitfall later in the process where I'd see that `nokogiri` is not currently supported on Ruby 2.7, so I need to pin the 2.6.x package, which we'll do during this tutorial for this reason.

* Ruby DevKit used to be a thing for windows. Now ridk uses msys2, so we'll be installing that during this step as well.

### Step 1: Install the Packages

* Open PowerShell as an admin (this is important for chocolately packages)

* We'll need `msys`, so I run `choco install msys2 -y`
* I need to find the 2.6.x version of ruby that will work, so I go to [the Chocolatey page for the Ruby package](https://chocolatey.org/packages/ruby)
* I expand the "Version History" section and see the current 2.6 version is 2.6.5.1
* So, I run `choco install ruby --version=2.6.5.1 -y`
* I then pin the package so it won't accidentally be upgraded later. To do this, I run `choco pin add -n=ruby`.

### Step 2: Getting the Ruby DevKit installed

* I close and re-open PowerShell as a non-admin (to let the paths update, and maybe because I'm just a little superstitious at this point).
* I run `ridk version` to make sure that the prompt shows up and the version numbers look correct
* I run `ridk install`. At the prompt, I hit `enter` to let it do its thing.
* It installs. At the end, I see the phrase `there is nothing to do` so I hit enter at the prompt and allow it to exit.
* I run `ridk enable` to enable it.

### Step 3: Getting the Bundler Installer Configured

* I re-open the PowerShell window (superstition, remember?)
* I run `bundler --version` and see that it's `1.17.x` out of the box.
* I run `gem install bundler` to upgrade it to version `2.x`

### Step 4: Installing the packages

* I go to the source directory that has my `Gemfile`.
* I delete the `gemfile.lock` file, as I'd like to ensure the packages are being recreated as bundler sees fit.
* I run `bundle install`
* I wait. For a while. Because I have native dependencies in some of these gems, some code literally needs to get compiled while I wait. I sip some coffee.

### Step 5: Running the site

* I run `bundle exec jekyll serve` to compile and serve the site

## The WSL (Windows Subsystem for Linux) Way

These steps assume I'll still be committing & pushing code via my Windows install, so they leave out setting up git on Ubuntu. (Happy to discuss how to do that in the comments; just ping me if you get stuck.)

* Enable WSL. If you haven't already open PowerShell as an admin an run `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`. You'll need to restart after.
* Go to the windows store and install a Linux distro of choice. I chose Ubuntu 18.04 LTS.
* Open your WSL instance once it's installed and set a password when you're prompted to do so. (Pssst -- do you have the new Windows Terminal? You can open a prompt right from that. It's nifty.)
* Run `sudo apt-get update` to update your packages
* Run `sudo apt-get install ruby-full build-essential` to install Ruby
* Run `sudo gem install bundler` to install bundler
* Head to your current source code's directory (mine is in `C:\SeanK\Repositories\seankilleen.github.io`, so I used `cd /mnt/c/Users/SeanK/Repositories/seankilleen.github.io`
* You'll have to install some other dependencies (at least on Ubuntu) -- `sudo apt-get install --reinstall zlibc zlib1g zlib1g-dev`
* Run `bundle install`. You'll be prompted for your password during. Allow it time to finish.
* Run `bundle exec jekyll serve`.

And there you have it! Jekyll two ways on Windows. :smile:

Happy publishing!
