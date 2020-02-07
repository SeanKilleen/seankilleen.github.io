---
title: 'How to: Deploy GitHub Pages on a Schedule to Publish Future Posts'
comments: true
tags:
  - github
  - github pages
  - github actions
  - serverless
  - docker
  - jekyll
date: '2020-02-07 14:00 -0500'
---
I have a Jekyll-based blog that is deployed via GitHub Pages. Because Jekyll is a static site generator, you can't release future posts unless you trigger a build (normally by making a commit).

However, today we're going to fix that. With any luck, this is the first post that I scheduled and published in advance!

## Solution

We're going to use GitHub Actions and a little bit of `curl` to accomplish what we need.

### Step 1: Create an Access Token

* Head to <https://github.com/settings/tokens>.
* Click the button to create a new token
* Give it a name, such as "GitHub Pages Automated Build" or something similar.
* Copy the access token somewhere temporarily, since you'll lose it after you navigate away.

### Step 2: Create a Secret for Your Access Token

* Open the repository that holds your GitHub pages site
* Navigate to Settings --> Secrets
* Create a new secret, named `PAGES_ACCESS_TOKEN` and paste in your personal access token that you created.

### Create a GitHub action

In your repository, create a file at `/github/workflows/scheduled-posts.yml`. 

Drop the following lines into it:

```yaml
name: Build every hour

on:
  schedule:
   - cron: '0 * * * *'
jobs:
  curl:
    runs-on: ubuntu-latest
    steps:
    - name: curl
      uses: wei/curl@master
      with:
        args: "-X POST -H 'Authorization: token ${{{{ secrets.PAGES_ACCESS_TOKEN }}}}' -H 'Accept: application/vnd.github.ant-man-preview+json' https://api.github.com/repos/YourUserName/YourRepository/pages/builds"
```

Let's break this down line by line:

* First, we give the workflow a name
* Then, we specify that it will run on a cron schedule of every hour, on the hour.
* We then specify what jobs the action will run.
* In this case, we specify a job called `curl`. 
* We create one step underneath this job, which we also call `curl`.
* We specify that we're using a container, in this case `wei/curl`, which is a container that installs curl on top of Alpine Linux.

We then specify the curl arguments. I'll break these down.

* `-X POST`: this will be an HTTP POST request
* `-H 'Authorization: token ${{{{ secrets.PAGES_ACCESS_TOKEN }}}}'`: Uses the secret that contains our access token, in order to authenticate.
* `-H 'Accept: application/vnd.github.ant-man-preview+json'`: This is apparently required by the GitHub API in order to allow access
* `https://api.github.com/repos/YourUserName/YourRepository/pages/builds`: This is the API endpoint of GitHub pages if you want to trigger a pages build. (substituting your username and repository name)

### The Result?

You can [see the current workflow here in my master branch](https://github.com/SeanKilleen/seankilleen.github.io/blob/master/.github/workflows/scheduled-posts.yml)

I'm excited that GitHub has enabled this kind of functionality; it has a ton of potential to make life easier for those of us using the platform.

Happy publishing!
