source 'http://rubygems.org'

install_if -> { RUBY_PLATFORM =~ /mingw|mswin/i } do
    gem "wdm"
end
install_if -> { RUBY_PLATFORM =~ /linux/i } do
    gem "rb-inotify"
    gem "webrick"
end

gem 'github-pages', group: :jekyll_plugins
gem 'rake'
gem 'tzinfo-data'
gem 'html-proofer', '~> 5.0.0'
gem 'jekyll-github-metadata'
gem 'minimal-mistakes-jekyll'
gem 'jekyll-include-cache'
