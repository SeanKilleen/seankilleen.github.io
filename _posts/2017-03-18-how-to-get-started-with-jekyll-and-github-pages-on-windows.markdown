---
title: "How to Get Started with Jekyll and Github Pages on Windows"
layout: post
date: 2017-03-18 02:38:00.000000000 -05:00
excerpt: "A few setup steps and you're off and running!"

references:
 - title: "Github Pages"
   url: https://pages.github.com/
   parenttitle: "Github"
   parenturl: http://github.com
 - title: "Jekyll"
   url: https://jekyllrb.com/
 - title: "RubyInstaller Downloads"
   url: https://rubyinstaller.org/downloads/


comments: true
---

[Github Pages](https://pages.github.com/) has become a great place to host content on the web. You can host HTML and JavaScript files there and even map them to domain names for free. As a result, many sites (including this blog) use Github Pages to host their site.

But even better, Github Pages supports [Jekyll](https://jekyllrb.com/). Jekyll is a static content site builder which allows you to render Markdown files as a web site, use includes and layouts across pages, and highlight source code snippets.

You may need (or want!) to work with a Github Pages based site at some point in the future. But if you haven't used Ruby before, the setup required to get started could seem daunting.

So, below are some steps I put together to help folks on Windows get started with Ruby and Jekyll on Windows.

## Installations

### Install Ruby via RubyInstaller
* Download the latest x64 version of Ruby from <https://rubyinstaller.org/downloads/>. At the time of this writing, that's `2.3.3 (x64)`
* Run the download
* Accept the license
* Allow the install to go to `C:\tools\ruby23` (trust me, it's easier later)
* Check the box to `Add Ruby Executables to your PATH`
* Complete the installation.

### Install Ruby DevKit 2
* Download the latest DevKit version from <http://rubyinstaller.org/downloads/>. The correct version will say `For Use With Ruby 2.0 and above (x64 - 64 bits only)`. **NOTE**: The download will be on the left-hand side mid-way down the page, under a heading called "Development Kit"
* Run the installer. Install to `C:\tools\DevKit2`.

## Environment Setup

### Ensure Ruby is present on your path
* Open a new command prompt or powershell window. Must be new so that the updated `PATH` variable will take effect.
* Run `ruby --version`

You should see a result along the lines of `ruby 2.3.3p222 (2016-11-21 revision 56859) [x64-mingw32]`.

### Initialize DevKit
* Open a new command prompt or powershell window
* Move to the `C:\tools\DevKit2` directory
* Run `ruby dk.rb init`. This will use one of DevKit's files to initialize itself and create a config file.

### Add Your Ruby Install to the DevKit Config

* Open the file at `C:\tools\DevKit2\config.yml`
* Add a line for your ruby folder, such as `- C:/tools/ruby23`. **NOTE:** The dash is important. It denotes a list item (YML format). Don't leave it off.
* Save the file.

### Link KevKit to your Ruby Install
* Open a command prompt or powershell window
* Move to the `C:\tools\DevKit2` directory
* Run `ruby dk.rb install`.

You should see a message about DevKit being installed.

### Install the Bundler gem
In simplified terms, Bundler is like nuget for Ruby. You'll use it to manage the packages that sit in the `gemfile`.

**NOTE:** For Github pages setup, you'll rarely have to do much with this, because GitHub pages dependencies all live in the one package which is already in the `gemfile`.

To install bundler, run `gem install bundler` from the command prompt. This should install it globally.

### How to Build and Run this Site Locally
Assuming you've followed the installation steps above, you should be able to do the following:

* Open a command prompt
* Open the root directory of this repository
* Run `bundle install`. The github-pages related bundles should install. If you see any errors at this point, you'll want to stop and dig further.
* Once the gems have installed, run `bundle exec jekyll serve`

After Jekyll builds the site, you'll see it hosted at `http://localhost:4000` (the default).

## Feedback? See something wrong? Need help?
I'd love to hear your questions or help you get set up. Ping me in the comments below.

Happy site generating!