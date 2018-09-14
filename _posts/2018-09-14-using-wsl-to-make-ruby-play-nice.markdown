---
title: "Using Windows Subsystem for Linux and Ruby With Jekyll"
layout: post
date: 2018-09-14 10:00:00.000000000 -05:00
excerpt: "Ruby and Windows don't always play nice. Here's how I used WSL to solve that problem."

references:
 - title: "Installing RVM"
   url: https://rvm.io/rvm/install
   parenttitle: "RVM: Ruby Version Manager"
   parenturl: https://rvm.io
 - title: "rvm/ubuntu_rvm Repository"
   url: https://github.com/rvm/ubuntu_rvm
   parenttitle: "GitHub"
   parenturl: https://github.com
 - title: "gjtorikian/html-proofer Repository"
   url: https://github.com/gjtorikian/html-proofer
   parenttitle: "GitHub"
   parenturl: https://github.com
 - title: "Windows Subsystem for Linux Documentation"
   url: https://docs.microsoft.com/en-us/windows/wsl/about
   parenttitle: "Microsoft Docs"
   parenturl: https://docs.microsoft.com

comments: true
---

## The Goal / Problem

This blog has been around for a little bit now. I'm bound to have some dead links or images. I figured I'd check those out and clean up the place.

Luckily, this blog also runs on Jekyll and Ruby, and the ruby ecosystem has a great gem called [html-proofer](https://github.com/gjtorikian/html-proofer) that will help us do this.

So I added the gem to my project, installed it, and ran html-proofer, only to see:

> (LoadError)y23/lib/ruby/gems/2.3.0/gems/ffi-1.9.18-x64-mingw32/lib/ffi/library.rb:147:in `block in ffi_lib': Could not open library 'libcurl': The specified module could not be found.

> Could not open library 'libcurl.so.4.dll': The specified module could not be found.

That's...not great. I googled a bunch and it appears that some of the tools in that chain don't play well with Windows, and I wasn't able to find a solution quickly. So I was about to give up on the task for a bit rather than fighting the Ruby/Windows ecosystem.

...until I remembered that I could bring Linux right into my environment and get the job done.

## The Solution: Enter Windows Subsystem for Linux (WSL)

If you haven't heard of [Windows System for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/about), it's a fantastic project from Microsoft that allows you to run certain Linux distributions right from within Windows, allowing you to get the best of both worlds.

I figured it was worth giving it a shot. Boy, was I right.

## Obtaining WSL

I opened the Microsoft Store App and searched for "Ubuntu". I found the Ubuntu distribution from Canonical and clicked `Install`. When that was done, I clicked `Launch`.

I waited a few minutes for some setup to complete, followed the prompts to create a username and password, and then I had a shell ready to go.

...was it really that straight-forward? Indeed it was.

## Installing Ruby

[RVM](https://rvm.io) seemed like the right way to go to install and manage versions of Ruby, so I decided to use that.

I followed [the install instructions](https://rvm.io/rvm/install). All of the below steps were performed within the Ubuntu window.

* Accept the public keys: `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
* Install some prerequisites for rvm: `sudo apt-get install software-properties-common`
* Add the RVM source repo: `sudo apt-add-repository -y ppa:rael-gc/rvm`
* Update apt-get: `sudo apt-get update`
* Install RVM: `sudo apt-get install rvm`

After RVM installs, it prints out some additional instructions, so I also:

* Add my user to the "rvm" group: `sudo usermod -a -G rvm sean`
* Run the additional post-install script: `source /etc/profile.d/rvm.sh`
* Logout of the vm: `logout`
* Re-launch the app from within Windows and bring the shell back up.

I then used RVM to install Ruby: `rvm install ruby`

## Git Install and Clone
sudo apt-get install git 
git config --global user.name "SeanKilleen"
git config --global user.email "SeanKilleen@gmail.com"
git clone https://github.com/SeanKilleen/seankilleen.github.io

## Getting Bundler up to date
gem install bundler

## Up and running!
`bundle install` 
`bundle exec jekyll build`

## Editing the gemfile to add html-proofer

* Opened Windows Explorer
* C:\Users\%USERNAME%\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\home
* From there, navigated to the repository's directory
* I found the gemfile and could edit and save it from within Windows

## Setting up my GitHub account for push wihtin WSL
Pushing to GitHub requires a personal access token when you have 2FA turned on (as you should!) 

* https://github.com/settings/tokens
* Create a personal access token and save it somewhere that you would save a password (because it essentially is one)
* In WSL, navigate to repo
* `git add .`
* `git commit -m "Adding html-proofer gem"`
* `git push`, enter username and personal access token in place of the password

## Running html-proofer

In WSL, run `bundle exec html-proofer`

Voila! I see the output.

I hope this helps serve as an introduction to Windows Subsystem for Linux. But if you'll excuse me for now, I have some links to go fix.