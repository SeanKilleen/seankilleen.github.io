---
title: 'How to: Check your Jekyll-based blog for dead links'
comments: true
tags:
  - tips
  - jekyll
  - proofing
  - ruby
date: '2019-09-22 17:40 -0400'
---
I thought someone might find this quick tip useful, so I'm writing it up.

## The Challenge

I have a blog that has a fair amount of posts now, with some of them being as old as 2012. 

I worry that there are some dead links about.

## Solution: Using the html-proofer gem and a RakeFile

* Open your blog's `Gemfile`
* Add `gem 'html-proofer'` to the file 
* Create a `RakeFile`

Now you'll pull down `html-proofer` in your bundle install. So how do we get it to actually do the installation?

Modify your Rakefile to add something along these lines (my current one [can be found here](https://github.com/seankilleen/seankilleen.github.io/blob/main/RakeFile)): 

```ruby
require 'html-proofer' # Ensures we have the html-proofer library available to use

def run_htmlproofer() # The function that will run the proofer, so that we can re-use it between our two rake tasks
  options = { 
    assume_extension: true, # Assumes html file extensions
    :typhoeus => { # The options for the curl library that's used.
      :ssl_verifypeer => false # This will stop you from getting errors when certs can't be parsed, which doesn't matter in this case.
    }, 
    allow_hash_href: true, # Won't fail for local links 
    url_ignore: [/edit\/gh-pages/] # This is because all my pages have a link to edit them, which will fail when generated locally.
  }
  HTMLProofer.check_directory("./_site", options).run # Calls html-proofer and uses the Jektll _site folder
end

task :test do
  sh "bundle exec jekyll build"
  run_htmlproofer()
end

task :testwithoutbuild do # For when I just built the site and I'm doing this a bunch of times
  run_htmlproofer()
end
```

## How to Use it

Once you have the `Rakefile` in place, you should be able to head to that directory and run `rake test` or `rake testwithoutbuild` which will parse your links and help you out.

I just ran it and ended up updating 20+ links so it's definitely a great check!

## That's it!

Questions? Issues? Let me know in the comments. 

Happy coding!
