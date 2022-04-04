FROM jekyll/jekyll:4

RUN apk add dos2unix
RUN npm install -g cspell markdownlint-cli

ENV ENV=/etc/profile

COPY aliases.sh /etc/profile.d/alias.sh

# Coverts CRLF based files (such as those on windows devices) to LF line endings for container
RUN dos2unix /etc/profile.d/alias.sh