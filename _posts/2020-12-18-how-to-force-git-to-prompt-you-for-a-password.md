---
title: How to force git to prompt you for a password
comments: true
tags:
  - git
  - authorization
  - passwords
date: 2020-12-18 11:18 -0500
---
## Challenge

I had to make a request against a remote in git. The only issue is that only a shared github account had access, not my own account (due to a vendor limitation). So when I occasionally needed to use this remote, I would have to log out and log in as the service account and it just seemed a bit messy.

I found a reasonable way to do this, and I'll run through the steps below. 

## Step 1: Generate an Access Token for the Shared Account

* Login with the shared account
* Generate a personal access token
* store in my password manager

## Add the Remote in Git

* Add the remote it's not already added: `git remote add REMOTE_NAME THE_URL_OF_THE_REMOTE`

## Unset the git credential manager temporarily

I'm doing the steps here manually but it could almost certainly be automated in a tiny script.

- Check the value of credential manager: `git config --system credential.helper`
- Unset the credential manager, which will prompt you for PW going forward: `git config --system --unset credential.helper`

## Running the command
- Run your applicable command, e.g. `git fetch upstream` in my case
- Use the shared account as user, and the access token as the password

## Return things to normal

- Set the value of the credential manager back to what it was, e.g manager-core in my case: `git config --system credential.helper manager-core`

That will let you quickly do one-time operations as husky-episerver without needing to log out / in, mess up your other git credentials, etc.

Happy gitting!