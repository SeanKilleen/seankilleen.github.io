# Our own public container that we've published to assist with this project
FROM ghcr.io/seankilleen/blog-in-a-box-container:ruby2.7.4-node21

VOLUME /docs
WORKDIR /docs

COPY aliases.sh /etc/profile.d/alias.sh

# Coverts CRLF based files (such as those on windows devices) to LF line endings for container
RUN dos2unix /etc/profile.d/alias.sh

RUN cat /etc/profile.d/alias.sh >> ~/.bashrc


### Add the aliases
# We get the first workspace, because there should only be one
# This is so that when someone updates their devcontainer name, it doesn't get screwed up
RUN echo 'first_workspace=\"$(cd /workspaces && ls | head -1)\"; alias spellcheck="cspell --config /workspaces/$first_workspace/cSpell.json \"/workspaces/$first_workspace/**/*.md\" --no-progress"' >> ~/.bashrc
RUN echo 'first_workspace=\"$(cd /workspaces && ls | head -1)\"; alias lint="markdownlint-cli2 --config /workspaces/$first_workspace/.markdownlint-cli2.jsonc /workspaces/$first_workspace/**/*.md"' >> ~/.bashrc
RUN echo 'first_workspace=\"$(cd /workspaces && ls | head -1)\"; alias build="bundle exec jekyll build"' >> ~/.bashrc
RUN echo 'first_workspace=\"$(cd /workspaces && ls | head -1)\"; alias serve="bundle exec jekyll serve --future"' >> ~/.bashrc

EXPOSE 4000
