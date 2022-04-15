FROM jekyll/jekyll:pages

RUN apk add dos2unix
RUN npm install -g cspell markdownlint-cli

# Reference: https://stackoverflow.com/questions/38024160/how-to-get-etc-profile-to-run-automatically-in-alpine-docker
ENV ENV="/etc/profile.d"

COPY aliases.sh /etc/profile.d/alias.sh

# Coverts CRLF based files (such as those on windows devices) to LF line endings for container
RUN dos2unix /etc/profile.d/alias.sh