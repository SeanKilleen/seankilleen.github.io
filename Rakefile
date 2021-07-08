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