# Our own public container that we've published to assist with this project
FROM ghcr.io/seankilleen/blog-in-a-box-container:ruby2.7.4-node20

VOLUME /docs
WORKDIR /docs

COPY aliases.sh /etc/profile.d/alias.sh

# Coverts CRLF based files (such as those on windows devices) to LF line endings for container
RUN dos2unix /etc/profile.d/alias.sh

RUN cat /etc/profile.d/alias.sh >> ~/.bashrc

EXPOSE 4000
