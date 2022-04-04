#!/bin/sh
# We get the first workspace, because there should only be one
# This is so that when someone updates their devcontainer name, it doesn't get screwed up
first_workspace="$(cd /workspaces && ls | head -1)"
alias gotoworkspace="cd /workspaces/$first_workspace/docs"
alias localdev="gotoworkspace && bundle install && bundle exec jekyll serve --future"
alias build="gotoworkspace && bundle exec jekyll build"
alias serve="gotoworkspace && bundle exec jekyll serve --future"
alias spellcheck="gotoworkspace && cspell --config /workspaces/$first_workspace/cSpell.json /workspaces/$first_workspace/docs/**/*.md"
alias lint="markdownlint -c /workspaces/$first_workspace/.markdownlintrc /workspaces/$first_workspace/docs/**/*.md"