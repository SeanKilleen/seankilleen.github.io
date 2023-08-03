#!/bin/sh
# We get the first workspace, because there should only be one
# This is so that when someone updates their devcontainer name, it doesn't get screwed up
first_workspace="$(cd /workspaces && ls | head -1)"
alias gotoworkspace="cd /workspaces/$first_workspace"
alias localdev="gotoworkspace && bundle install && bundle exec jekyll serve --future --force_polling --livereload"
alias build="gotoworkspace && bundle exec jekyll build"
alias serve="gotoworkspace && bundle exec jekyll serve --future --force_polling --livereload"
alias spellcheck="gotoworkspace && cspell --no-progress --config cSpell.json **/*.md"
alias lint="gotoworkspace && markdownlint -c .markdownlintrc **/*.md"