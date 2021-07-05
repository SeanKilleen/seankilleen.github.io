---
title: "Using Windows Subsystem for Linux and Ruby with Jekyll"
 
date: 2018-09-14 10:00:00.000000000 -05:00

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
 - title: "Your GitHub Personal Access Tokens"
   url: https://github.com/settings/tokens
   parenttitle: "GitHub"
   parenturl: https://github.com

comments: false
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

Cool! I've got Ruby.

## Git Install and Clone

I've got to get to my blog's repository in order to build it and run html-proofer. That means setting up git with the GitHub repo. I:

* Install git: `sudo apt-get install git`
* Set my username: `git config --global user.name "SeanKilleen"`
* Set my e-mail: `git config --global user.email "SeanKilleen@gmail.com"`
* Check out the blog repo: `git clone https://github.com/SeanKilleen/seankilleen.github.io`

## Building the Blog

I need to:

* Go into the blog's directory: `cd seankilleen.github.io`
* Install Bundler: `gem install bundler`
* Install the gems for the blog: `bundle install`

Now, I can build the blog via `bundle exec jekyll build`

And it works! Not shabby.

## Adding html-proofer (from Windows!)

OK, so I need to add the `html-proofer` gem by modifying the `gemfile` that's sitting on my Ubuntu distro. But ugh, I don't know the landscape as well as I know the windows landscape, and I'd rather just quickly use notepad.

...Thankfully, you can totally edit the Linux distro files from within Windows!

I:

* Opened Windows Explorer
* Navigated to `C:\Users\%USERNAME%\AppData\Local\Packages`
* Clicked into the Ubuntu distro folder: `CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc`
* Navigated to `\LocalState\rootfs\home\sean`

Whoa, there's my repo folder! I just need to click into the `seankilleen.github.io` folder, and then I can open `gemfile` within notepad.

* I add a line: `gem 'html-proofer'` and save.
* I then switch back into my Ubuntu Window. I type `cat gemfile` and lo and behold, I see my changes reflected there. Nice!

It would be pretty great to commit those changes to GitHub right from my Ubuntu distro. Is that doable?

...Heck yeah, it's doable.

## Setting up my GitHub account for push within WSL

Pushing to GitHub requires a personal access token when you have two-factor authentication turned on (as you should!). So, I:

* Open a web browser on Windows and head to <https://github.com/settings/tokens>
* Create a personal access token and save it somewhere that you would save a password (because it essentially is one)
* Switch back to my Ubuntu WSL window
* Navigate to the repo folder if I'm not already in it
* Add my uncommitted files: `git add .`
* Check with `git status`
* Commit the change: `git commit -m "Adding html-proofer gem"`
* Attempt to push the change: `git push`
* Enter username and personal access token in place of the password

Now I've committed the change to my repo, from Ubuntu.

## The payoff: Running html-proofer without issue!

In my WSL window, I:

* Navigate to the repo folder
* Run `bundle install` to make sure I've got everything installed
* Run `bundle exec jekyll build` to create the output, which lives in a `_site` folder.
* Run `bundle exec html-proofer ./_site` to execute html-proofer.

Voila! I see the output.

## Wow. That was cool.

The team behind WSL has put in a ton of work to make this experience seamless. A small bit of googling let me follow instructions to get up and running on Ubuntu without sacrificing the ease and muscle memory of the Windows environment as my main setup.

I hope this helps serve as an introduction to Windows Subsystem for Linux. But if you'll excuse me for now, I have some links to go fix!
