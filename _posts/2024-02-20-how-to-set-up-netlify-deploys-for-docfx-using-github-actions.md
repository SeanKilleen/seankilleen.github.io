---
title: How to Set up Netlify Deploys for Docfx using GitHub Actions
comments: true
tags:
  - docfx
  - dotnet
  - nunit
  - githubactions
  - ci
  - devops
date: 2024-02-20 10:00 -0500
---
## Background

We currently use `docfx`` to publish the [NUnit docs](https://docs.nunit.org), because it has a lovely capability of generating docs for our API reference in addition to all our articles.

However, one thing I often yearn for -- that I get on this Jekyll blog and some others I work with -- is the ability to have a live preview within a pull request of what the generated site will look like.

Because the source code for the API docs is in the `nunit` repository, and the docs live in the `docs` repo, it'll be a little extra complicated.

Nevertheless: Let's make it happen.

## The Conceptual Approach

* We pull the NUnit DLL and create the docfx site
* We zip up the site
* We create a custom GitHub environment to be associated with our deployment environment
* We manually update the statuses of that deployment
* We deploy to Netlify
* We post the link as a comment in the PR

## The Build Steps

Below are the steps in [our docfx build process](https://github.com/nunit/docs/tree/master/.github/workflows) -- I'll break them down one at a time:

```yaml
      - uses: actions/checkout@v4
        name: Check out the code
```

Self-explanatory; we need our code if we're going to build it.

```yaml
      - name: Get latest NUnit Asset dir
        uses: dsaltares/fetch-gh-release-asset@master
        with:
          repo: 'nunit/nunit'
          version: 'tags/v${{ env.NUNIT_VERSION_FOR_API_DOCS }}'
          file: 'NUnit.Framework-${{ env.NUNIT_VERSION_FOR_API_DOCS }}.zip'
          token: ${{ secrets.GITHUB_TOKEN }}
```

Because the source code that contains the DLL is in another repository, we use this GitHub action to pull the file via pulling a specific tag (currently hard-coded. I'll get around to fixing that. Probably.)

```yaml
      - name: Unzip NUnit Asset zip file into its own directory
        run: unzip NUnit.Framework-${{ env.NUNIT_VERSION_FOR_API_DOCS }}.zip -d ./NUnit.Framework-${{ env.NUNIT_VERSION_FOR_API_DOCS }}
      - name: Copy NUnit Asset dir
        run: mkdir ./code-output && cp -r ./NUnit.Framework-${{ env.NUNIT_VERSION_FOR_API_DOCS }}/bin/net6.0/* ./code-output
```

We unzip the asset file and copy it to the right spot.

```yaml
      - uses: "nunit/docfx-action@v3.0.0"
        name: Build with Docfx
        with:
          args: docs/docfx.json --warningsAsErrors true
```

With that in place, we run docfx to mash everything up into one deployable site.

```yaml
      - name: zip site contents
        run: zip -r _site.zip docs/_site/
      - name: Archive site artifacts
        uses: actions/upload-artifact@v3
        with:
          name: siteArtifact
          path: _site.zip
```

We zip up and archive the site contents. This is just for reference

```yaml
      - name: Start deployment (PR only)
        if: ${{ github.ref != 'refs/heads/master'}}
        uses: bobheadxi/deployments@v1
        id: deployment
        with:
          env: preview_${{github.event.number}}
          step: start
          token: ${{ secrets.SEAN_PAT_TO_MANAGE_ENVIRONMENTS }}
```

This creates a new deployment environment for the PR number and creates a deployment to it with a status of started.

Note that it requires a personal access token that has the authority to manage environments.

```yaml
      - name: Deploy to Netlify (PR only)
        if: ${{ github.ref != 'refs/heads/master'}}
        uses: South-Paw/action-netlify-cli@v2
        id: netlify
        with:
          # note that the --json flag has been passed so we can parse outputs
          args: deploy --json --dir './docs/_site' --message 'preview [${{ github.sha }}]'
        env:
          NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
          NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}          
```

This uses the Netlify CLI to push all the site's files. We can see it in Netlify because it's a separate preview build with its own message.

Note that it requires a Netlify site to have been created and to produce an Auth token and a site ID, which I store in GitHub secrets for this action.

```yaml
      - name: Update Preview link comment
        if: ${{ github.ref != 'refs/heads/master'}}
        uses: marocchino/sticky-pull-request-comment@v2
        with:
          header: previewlink
          message: |
            Preview link: ${{ fromJson(steps.netlify.outputs.NETLIFY_OUTPUT).deploy_url }}          
```

I was happy with this one. It uses a great GitHub action to post a sticky comment and uses the JSON output of the Netlify CLI to post the URL.

```yaml
      - name: Finish deployment
        uses: bobheadxi/deployments@v1
        if: ${{ github.ref != 'refs/heads/master'}}
        with:
          env: ${{ steps.deployment.outputs.env }}
          step: finish
          status: ${{ job.status }}
          deployment_id: ${{ steps.deployment.outputs.deployment_id }}
          env_url: ${{ fromJson(steps.netlify.outputs.NETLIFY_OUTPUT).deploy_url }}     
          token: ${{ secrets.SEAN_PAT_TO_MANAGE_ENVIRONMENTS }} 
```yaml

And here we go ahead and mark the deployment to the preview environment as "finished".

## A Quick Side Note: I love GitHub Actions!

Thanks to so many people who've worked to make others' lives better, my experience was largely in googling around to discover that people had already done all the things that I needed to do! I look forward to being able to contribute more of that myself if I can ever find something that needs doing.

## What To Do Once a PR is Merged?

We can't leave those environments hanging around in our GitHub. So we delete them, using the same id format that we used when we created them.

```yaml
on:
    pull_request:
      types: [ closed ]
jobs:
    prune:
      permissions: 
        deployments: write
      runs-on: ubuntu-latest
      steps:
      - name: delete environment
        uses: bobheadxi/deployments@v1
        with:
            step: delete-env
            token: ${{ secrets.SEAN_PAT_TO_MANAGE_ENVIRONMENTS }}
            env: preview_${{github.event.number}}
```

## And...That's It!

Once I got all the moving parts working together, it was an absolute delight to see it in action and I've used it so many times since. I hope this article helps someone else arrive at this place in slightly less time than it took me. Questions and feedback welcome in the comments!
