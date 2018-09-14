---
title: "Using Windows Subsystem for Linux and Ruby With Jekyll"
layout: post
date: 2018-09-14 10:00:00.000000000 -05:00
excerpt: "Ruby and Windows don't always play nice. Here's how I used WSL to solve that problem."

# references:
#  - title: "Work with Azure Functions Core Tools"
#    url: https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local#non-http-triggered-functions
#    parenttitle: "Microsoft Docs"
#    parenturl: https://docs.microsoft.com

comments: true
---



## Obtaining Windows Subsystem for Linux (WSL)

[https://rvm.io/rvm/install]

## Ruby install

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

sudo apt-get install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm

## RVM post setup instructions
sudo usermod -a -G rvm sean
source /etc/profile.d/rvm.sh

[restart system]

rvm install ruby

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