# seankilleen.github.io

Sean's blog hosted at <https://SeanKilleen.com>

## You'll need a GitHub token for certain functionality

* Generate a personal access token with `public_repo` permissions
* Use that token to set the `JEKYLL_GITHUB_TOKEN` environment variable

This will allow the `jekyll-github-metadata` plugin to perform as expected and make things like edit links and the contributors page work correctly.

## To Run

* Install ruby, ruby devkit
* `gem install bundler`
* cd to the project's rood
* `bundle install`
* `bundle exec jekyll serve` should build the site and serve it at `http://localhost:4000`. For future posts, you can build with `bundle exec jeykll serve --future true`
