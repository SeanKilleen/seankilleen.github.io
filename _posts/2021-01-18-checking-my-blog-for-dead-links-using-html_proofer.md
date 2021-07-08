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

In my project's `Gemfile`, I added

```ruby
gem 'html-proofer'
```

## Adding a Rakefile

I create a file called `Rakefile` at the root of my project. The contents, as of this writing, are annotated below. The [current `Rakefile` can be found here](https://github.com/SeanKilleen/seankilleen.github.io/blob/main/RakeFile)

```ruby
require 'html-proofer' # Ensures we have the html-proofer library available to use

def run_htmlproofer() # The function that will run the proofer, so that we can re-use it between our two rake tasks
  options = { 
    assume_extension: true, # Assumes html file extensions
    http_status_ignore: [999,429], # 999 means you're being blocked; 429 is a rate limit
    :typhoeus => { # The options for the curl library that's used.
    
      :ssl_verifypeer => false, # This will stop you from getting errors when certs can't be parsed, which doesn't matter in this case.
      :headers => { "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101 Firefox/84.0"}
    }, 
    allow_hash_href: true, # Won't fail for local links 
    url_ignore: [/edit\/gh-pages/], # This is because all my pages have a link to edit them, which will fail when generated locally.
    :hydra => { :max_concurrency => 5 }
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

What's actually going on here? 

* We reference `html-proofer` so that we can utilize it
* We define take tasks, `test` and `testwithoutbuild`
* We define a function called `run_htmlproofer()`
* We add an object of options for html-proofer, based on [the docs](https://github.com/gjtorikian/html-proofer).

## Running the Rake Task

* Run `bundle install` to install all of the gems in my project
* Run `bundle exec rake test`, which will execute the rake task

## Examining the Output

When I run this script on this current run, I see the following output:

```console
Running ["ScriptCheck", "LinkCheck", "ImageCheck"] on ["./_site"] on *.html...


Checking 1062 external links...
```

It then takes...a little while. Remember, in the current configuration, we're checking 5 links in parallel across 1,062 links.

It does eventually finish, and I see:

```console
- ./_site/2010/12/suntrust-is-awesome/index.html
  *  External link http://www.banksimple.com/ failed: response code 0 means something's wrong.
             It's possible libcurl couldn't connect to the server or perhaps the request timed out.
             Sometimes, making too many requests at once also breaks things.
             Either way, the return message (if any) from the server is: Server returned nothing (no headers, no data)
- ./_site/2012/01/crafty-google-very-crafty/index.html
  *  External link https://seankilleen.com/2012/01/crafty-google-very-crafty/ failed: 404 No error
- ./_site/2012/02/how-to-compare-two-sets-of-internet-explorer-security-settings-field-notes/index.html
  *  External link https://msdnshared.blob.core.windows.net/media/TNBlogsFS/prod.evol.blogs.technet.com/telligent.evolution.components.attachments/01/5808/00/00/03/45/50/87/IEZoneAnalyzer.3.5.0.5.zip failed: 404 No error
- ./_site/2012/04/psa-ibm-maximo-7-1-user-guide-is-now-the-product-reference-guide-field-notes/index.html
  *  External link http://www.ibm.com/developerworks/wikis/display/maximo/Related+Resources failed: 503 No error
- ./_site/2015/06/A-Quick-Guide-To-Azure-CDN/index.html
  *  External link http://manage.windowsazure.com/ failed: response code 0 means something's wrong.
             It's possible libcurl couldn't connect to the server or perhaps the request timed out.
             Sometimes, making too many requests at once also breaks things.
             Either way, the return message (if any) from the server is: Couldn't resolve host name
- ./_site/2018/08/vscode-tip-watch-files/index.html
  *  External link https://vscodecandothat.com/ failed: got a time out (response code 0)
- ./_site/Talks/index.html
  *  External link https://github.com/SeanKilleen/Presentations/tree/master/AkkaIntro/code-dotnetcore failed: 404 No error

HTML-Proofer found 7 failures!
```

Welp, let's get to work.

## Fixing the Links

* The BankSimple link is dead because Simple itself shut down and became part of BBVA. So we'll remove that link
* The link in the 2012 "Craft, Google+" post stumps me a bit. It looks like Jekyll might be generating something with this URL but formatting it wrong. Odd that it only happens there. I'm going to let it slide for now.
* IEZoneAnalyzer appears to no longer be available. The file location apparently no longer exists and the link is dead on Microsoft's web page about it. Looks like it was lost to time. I left the link to the web page but removed the direct download link.
* The `manage.windowsazure.com` link was a fun blast from the past. Updated the links to point to `portal.azure.com`.
* The `VSCodeCanDoThat` timeout was a fluke. Checked the site, it's up. 
* Looks like my [Talks page](https://SeanKilleen.com/Talks) page had some old references to code that I'd since consolidated. Fixed that up.

## Feels Better!

As someone who's been writing on the internet for a little while now, I feel a sense of duty to keep my links from leading people to the wrong place. Cleaning this up feels good.

## A GitHub Action?

I might automate this in the future with a GitHub action, but for now I'm going to hold off, because I don't want to be hammering sites with every build request getting 429 errors. A scheduled task may be the way to go here, so that I regularly receive notice of failures.