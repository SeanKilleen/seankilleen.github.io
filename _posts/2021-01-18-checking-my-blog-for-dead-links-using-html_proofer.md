---
title: How to Checking a Jekyll Blog for Dead Links using HTML Proofer
comments: true
tags:
  - jekyll
  - ruby
  - github actions
date: 2021-01-18 13:34 -0500
---
Any blog is bound to accumulate dead links over time. I figured I should probably find mine and fix them up.

My current blog platform (Jekyll) uses Ruby, so I've got a great ecosystem of tools to choose from. In this case, I'll be using [HTML Proofer](https://github.com/gjtorikian/html-proofer).

## Adding the HTML Proofer gem



* Add html proofer gem
* Add rakefile
* Specify gem
* Add call to html proofer
* Run the take build
* Fix links
* Adding the GitHub action