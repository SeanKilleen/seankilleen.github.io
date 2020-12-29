---
title: How to force git to prompt you for a password
comments: true
tags:
  - git
  - authorization
  - passwords
date: 2020-12-18 11:18 -0500
---

A fun git challenge! I had to make a request against a remote repository in git. The only issue is that only a shared GitHub account had access, not my own account (due to a vendor limitation). So when I occasionally needed to use this remote, I would have to log out and log in as the service account and it just seemed a bit messy.

I found a reasonable way to do this, and I'll run through the steps below. Have a better way? I'd love to hear about it in the comments!

## Generate an Access Token for the Shared Account

- Login with the shared account. Since I had the credentials, I did this via a normal browser session (in a private window since I was just logging in once.)
- Generate a personal access token. If you're unfamiliar with this, you can [follow the steps in the GitHub docs](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token).
- Store in my password manager. This access token is as good as a password, so I treat it with the respect it deserves.

## Add the Remote in Git

- Add the remote if it's not already added: `git remote add REMOTE_NAME THE_URL_OF_THE_REMOTE`

## Unset the git credential manager temporarily

I'm doing the steps here manually but it could almost certainly be automated in a tiny script.

- Check the value of credential manager: `git config --system credential.helper`. Save this value for later; you will need it to set things back.
- Unset the credential manager, which will prompt you for PW going forward: `git config --system --unset credential.helper`

## Running the command

- Run your applicable command, e.g. `git fetch upstream` in my case
- Use the shared account name as user, and the access token as the password

## Return things to normal

- Set the value of the credential manager back to what it was, e.g manager-core in my case: `git config --system credential.helper manager-core`

That will let you quickly do one-time operations as the other account without needing to log out / in, mess up your other git credentials, etc.

Happy gitting!
