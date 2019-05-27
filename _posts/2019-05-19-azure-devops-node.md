---
title: "Adding public CI/CD to a Node project with Azure Pipelines"

date: 2019-05-18 04:50:00.000000000 -05:00

tags: [Azure, DevOps, Pipelines, Node, CI, CD]
comments: true

---

I recently created [’unanet-summarizer’, a small utility to give my colleagues some additional summary information on their timesheets](http://github.com/excellalabs/unanet-summarizer). It got a little more attention than I expected, but best of all it got others wanting to help out, and the codebase grew out rapidly. 

It was time for a build and deployment system, and I'm in love with [Azure DevOps](http://dev.azure.com) so I wanted to take this oportunity to write up the process and document it for my colleagues and others.

# Goals

I wanted to achieve the following for this JS project:

* A build that runs as part of every pull requesr so we can detect any broken changes
* A production release that outputs artifacts to a hosting location (in this case, a simple storage blob on Azure)
* Status badges for builds and releases
* I want anyone to be able to view the builds and deployments

# The Walkthrough

What follows below is a full walkthrough, complete with some struggles, because I want it to be clear when you might miss things or run into confusing steps.

## Setting up the Project

* I go to <http://dev.azure.com> and sign in with my Excella account.
* I create a new project:

> ![the create new project button on azure devops]({{site.post-images}}/2019-05-azure-devops-node/01_create-project.png)

* I give it a name and select the options, keeping it public so that anyone will be able to view the builds & releases:

> ![entering my informaton for the project]({{site.post-images}}/2019-05-azure-devops-node/02_project-info.png)

* In the left navigation, I click pipelines, which tells me (unsurprisingly) that no pipelines exist. I click to create one:
 
> ![new pipeline button on the pipelines page]({{site.post-images}}/2019-05-azure-devops-node/03_new-pipeline.png)

* I select GitHub for the location of the code:

> ![seleting the GitHub option]({{site.post-images}}/2019-05-azure-devops-node/04_select-location.png)

* I select all repositories from the dropdown (since it's not my repo but rather `excellalabs`). I then search for unanet and click the summarizer project.

> ![selecting the project]({{site.post-images}}/2019-05-azure-devops-node/05_select-repo.png)

* I authenticate with GitHub
* In GitHub, I am then asked to give permission for the Azure Pipelines app to access the repo. I approve. 👍 

> ![approving permissions]({{site.post-images}}/2019-05-azure-devops-node/06_grant-permission.png)

* I am then asked to authenticate with my Excella account again. No idea why.

## Setting up the Pipeline

* I'm taken back to the pipelines page, where I am on the "configuration" step and can now choose what kind of pipeline I want. I choose `node.js` because I think that'll be most suitable

> ![choosing the default type of pipeline]({{site.post-images}}/2019-05-azure-devops-node/07_configure-pipeline-node.png)

* Hey cool, Azure DevOps creates a YAML file that has a build set up for us that is triggered on any PR and anytime we push to master. It runs `npm install` and `npm build`. That seems pretty spot on. 

> ![the YAML file that is created for us]({{site.post-images}}/2019-05-azure-devops-node/08_pipeline-yaml.png)

* Azure DevOps also has this nice Save & run button which will commit the YAML file back to our repo and begin the build process. So I click that to save it.

> ![clicking the save and run button]({{site.post-images}}/2019-05-azure-devops-node/09_save-and-run.png)

* We are given options for how to commit to the repo. I choose to commit directly to master because I live on the edge. No, kidding, but I do choose it because I see the contents and know committing to master will allow the build to kick off.

> ![the set up and run screen which allows me to commit the files to the master branch]({{site.post-images}}/2019-05-azure-devops-node/10_commit-message.png)

* An agent prepares itself and then [runs the job](https://dev.azure.com/excellaco/unanet-summarizer/_build/results?buildId=207). It's a success! We're just not doing anything with the output yet.

> ![build success]({{site.post-images}}/2019-05-azure-devops-node/11_build-result.png)

## Status Badge

Next up, I'd like to set up a status badge for the builds that I can show in the `README` file. 

* I go to [the build definition](https://dev.azure.com/excellaco/unanet-summarizer/_build?definitionId=5&_a=summary)

* In the drop-down to the right, I select `Status Badge`:

> ![build menu dropdown](12_status-badge-menu.png)

* I choose the branch, and then copy the provided markdown (which is nice):

> ![copying the provided markdown]({{site.post-images}}/2019-05-azure-devops-node/13_status-badge-info.png)

*  I test that markdown here: (because why not?) 

[![Build Status](https://dev.azure.com/excellaco/unanet-summarizer/_apis/build/status/excellalabs.unanet-summarizer?branchName=master)](https://dev.azure.com/excellaco/unanet-summarizer/_build/latest?definitionId=5&branchName=master)

* Nice! I'll create a PR and add that to the `README`.

## Outputting the distribution files

* I create a PR that adds the following to the azure pipelines file. The YAML will (I think) take the `dist` folder of our build and output it, but only when the branch is the master branch. I chose the `dist` folder so we wouldn't have to deal with `node_modules`, and I chose only the `master` branch because we really only will do anything with the output when it is the master branch we're building, since that's what we'll release.

```yaml
- task: PublishPipelineArtifact@0
  displayName: Publish Pipeline Artifacts
  inputs:
    targetPath: $(Build.ArtifactStagingDirectory)/dist
  condition: eq(variables['Build.SourceBranch'], 'refs/heads/master')
```

You know what. Building this PR makes me realize we never turned on the azure pipelines for PR builds within GitHub. So let's do that.

...wait, nevermind, we don't have to. Azure Pipelines already set that up. 

> ![azure pipelines build status]({{site.post-images}}/2019-05-azure-devops-node/14_status-checks.png)

* I watch the job go through on the Azure Pipelines and it totally! ....fails. Oops, I think I picked the wrong directory maybe?

> ![pipeline error about a path not existing]({{site.post-images}}/2019-05-azure-devops-node/15_artifact-fail.png)

Interesting. In the build output itself I see ` /home/vsts/work/1/s` instead of an `a`. Maybe I'm using the wrong build variable? 

...oh, whoops. In order to publish the staging contents, we'd probably have to put something there first, wouldn't we? So I'll add the below in a PR:

```yaml
- task: CopyFiles@2
  inputs:
    sourceFolder: $(Build.SourcesDirectory)/dist
    contents: '**\*'
    targetFolder: $(Build.ArtifactStagingDirectory)
  displayName: Copy Files to Staging Directory
``` 

OK, well that was actually a little weird. It turns out that the build directories in the variable seem to be `C:\agent` etc. but in the Ubuntu VM it's `/home/vsts/work/1/s`. So I needed to hard-code that in order to find the files. The default didn't work. Strange.

...and when I changed to that, it still didn't work. Azure Pipelines isn't finding the output files. 

OK hmm, all of a sudden it works and I don't know why. I see in the logs:

`Copying /home/vsts/work/1/s/dist/unanet-summarizer-release.js to /home/vsts/work/1/a/dist/unanet-summarizer-release.js`

And it copied 6000 files including node_modules etc.

So i'm going to update it now to output from `dist`. A very interesting issue. 

For some reason, this ended up being the task to do it:

```yaml
- task: CopyFiles@2
  inputs:
    sourceFolder: '/home/vsts/work/1/s/dist' #For some reason, I think we need to hard-code this.
    targetFolder: '$(Build.ArtifactStagingDirectory)'
  displayName: 'Copy Files to Staging Directory'
```

I still don't understand what the final change was that made it work, but this does at least make sense to me.

Onward! 

## Creating the Container for Storage

NOTE: This is only one way amongst many to do this. You might want to push files to GitHub pages, Netlify, etc. -- this just happened to work for me.

The next step will be to create an Azure blob and then deploy the released JS to it.

* I login to the Azure portal using my Excella account
* I navigate to the resource group we use for these things
* I click "Add" to add a resource.

> ![the add resource button]({{site.post-images}}/2019-05-azure-devops-node/16_add-resource.png)

* I type "storage" and select "Storage Account"

> ![selecting the storage type]({{site.post-images}}/2019-05-azure-devops-node/17_select-storage.png)

* I click "Create" on the intro screen.
* I provide a name, region, and type for the blob storage:

> ![filling in the information for our blob storage]({{site.post-images}}/2019-05-azure-devops-node/18_storage-info.png)

* On the review screen, I click create.
* When the creation completes, I click to go to the resource.
* I don't have any containers yet, so I click to add one:

> ![creating a container]({{site.post-images}}/2019-05-azure-devops-node/19_add-container.png)

* I provide a name, and select container level anonymous read access, since our intention is explicitly to serve our scripts for the entire world to see.

> ![providing information on the storage container]({{site.post-images}}/2019-05-azure-devops-node/20_container-info.png)

* After the container is created, I click into it. 
* I then click properties on the left-hand menu, and get the URL of <https://unanetsummarizer.blob.core.windows.net/unanet-summarizer>:

> ![getting the URL for the blob container]({{site.post-images}}/2019-05-azure-devops-node/21_container-url.png)

This is where we'll eventually deploy to.

## Creating the Deployment

Speaking of, sounds like we should go create that deployment!

* Back into Azure DevOps, I choose [Releases](https://dev.azure.com/excellaco/unanet-summarizer/_release) from the left-hand menu. I don't have yet, which makes sense. I choose to create a new one.

> ![screen showing no release pipelines]({{site.post-images}}/2019-05-azure-devops-node/22_no-release-pipelines.png)

* I'm prompted to start with a template but because we're outputting to a blob, I think that an empty job probably makes the most sense.

> ![selecting a job type of empty job]({{site.post-images}}/2019-05-azure-devops-node/23_empty-job.png)

* I get a default stage (what you might do for different environments, etc.). In our case, we have just one stage so far: "Deploy to the production blob". So I give the stage a name.

> ![providing a name for the release stage]({{site.post-images}}/2019-05-azure-devops-node/24_stage-name.png)

* I'm not actually pulling in any artifacts that would kick off a release yet, so I click to do that:

> ![clicking the button to add an artifact]({{site.post-images}}/2019-05-azure-devops-node/25_add-artifact.png)

* I tell the release that I want it to use the artifacts from the latest build of the `master` branch, and I click save:

> ![providing the information for the artifact to pull in]({{site.post-images}}/2019-05-azure-devops-node/26_artifact-info.png)

* Note the lightning bolt on the artifacts. That means that anytime a new one of these artifacts shows up, a release will be created and executed.

> ![showing the label of the lightning bolt, which means continuous deployment]({{site.post-images}}/2019-05-azure-devops-node/27_continuous-deployment.png)

* I click to view the tasks for the stage, since we haven't added any yet:

> ![clicking the link to view stage tasks]({{site.post-images}}/2019-05-azure-devops-node/28_add-task-link.png)

* I click to add a task to the agent job:

> ![clicking the plus icon to add a task]({{site.post-images}}/2019-05-azure-devops-node/29_add-task.png)

* In the tasks, list, I search for "blob" (this is literally my first time doing this), and awesomely, "Azure File Copy" comes up. I click to add it.

> ![searching for and selecting azure file copy]({{site.post-images}}/2019-05-azure-devops-node/30_azure-file-copy.png)

* I see that "some settings need my attention", so I click into it:

> ![a validation warning showing that some settings need attention]({{site.post-images}}/2019-05-azure-devops-node/31_settings-need-attention.png)

* I need to select a source. Luckily, there's an elipsis menu that lets me select the location based on my artifact output:

> ![the empty source with an ellipsis to indicate more options](https://user-images.githubusercontent.com/2148318/57163309-d2d68a00-6dbe-11e9-9096-99f9a10d4a7b.png)


* I choose the artifact folder that I want to copy from:

> ![choosing the drop folder from a list of folders](https://user-images.githubusercontent.com/2148318/57163269-b89cac00-6dbe-11e9-82a4-f8c196a47bff.png)

* I select the subscription ID (omitting that here) and then click `Authorize` to allow azure devops to get the access it needs:

> ![the authorize button for subscription access](https://user-images.githubusercontent.com/2148318/57163391-04e7ec00-6dbf-11e9-8f02-0943fc59adfe.png)

...and I get an error. Which is fair, because I'm using a company resource and don't have full admin rights there (which I'm OK with). Normally on personal subscriptions it Just Works™️ 

So, I'll leave off here for now until my IT dept is able to unblock me. 

## A Note on Azure Subscription Permissions

And we're back! Fun fact: clicking that authorize button attempts to do so for a whole subscription, but if you click the advanced options:

> ![the dropdown button on the authorize menu that shows advanced options](https://user-images.githubusercontent.com/2148318/57164041-e4b92c80-6dc0-11e9-9e4a-696bb0c85194.png)

You can select a resource group, and then it will work since I have access to the resource group: 

> ![selecting a specific resource group rather than a whole subscription](https://user-images.githubusercontent.com/2148318/57164074-fac6ed00-6dc0-11e9-8eab-810b0e76f946.png)

...okay, back to our regularly scheduled show.

## Selecting the Deployment Destination and Deploying

* I select the destination type and point it towards the storage account I created:

> ![information for the storage account to push to](https://user-images.githubusercontent.com/2148318/57164143-306bd600-6dc1-11e9-868c-b62f92540a20.png)

* OK, I think that's pretty much it and I'm ready to save the release and see how this worked out.

> ![clicking the save button on the configuration](https://user-images.githubusercontent.com/2148318/57164182-4e393b00-6dc1-11e9-819d-fd155f6e483c.png)

* Let's give this a shot! I got to the releases page and click to create a release:

> ![clicking the button to create a release](https://user-images.githubusercontent.com/2148318/57164240-80e33380-6dc1-11e9-8c6f-a6cbe3095c4f.png)

* I give the release a description, and then click `Create`: 

> ![adding a description for the release](https://user-images.githubusercontent.com/2148318/57164282-a1ab8900-6dc1-11e9-853a-6312a609b7b7.png)

* Looks like it worked!

> ![a release summary showing all the tasks were successful](https://user-images.githubusercontent.com/2148318/57164357-d7e90880-6dc1-11e9-9cf5-06dde2e816b7.png)

* I go back to the Azure portal to check, an lo and behold, it's there!

> ![showing the file created within the blob container](https://user-images.githubusercontent.com/2148318/57164390-f64f0400-6dc1-11e9-87fc-941ae44d4f3b.png)

* Just to check, I get the URL of the blob (<https://unanetsummarizer.blob.core.windows.net/unanet-summarizer/unanet-summarizer-release.js>) and i hit it in my browser. It works!

## Adding a Release Badge

Now, releases to prod are cool, so I want to show them off publicly. How do I do that?

* I [open the release definition in Azure DevOps](https://dev.azure.com/excellaco/unanet-summarizer/_releaseDefinition?definitionId=1&_a=environments-editor-preview). I click Options, Integrations, enable the status badge, copy the URL, and then Save the release options:

> ![the release integrations options screen](https://user-images.githubusercontent.com/2148318/57164702-ef74c100-6dc2-11e9-9326-d27538dfd926.png)

We can check it here: ![Status](https://vsrm.dev.azure.com/excellaco/_apis/public/Release/badge/ab42bd87-c4a4-44b8-9bcc-02ab7408d6c0/1/1)

Sweet! I think I'll add it to the README as well. 

## Oops: Let's *actually* Continuously Deploy

Oops, one last thing: I'd messed up on the continuous deployment trigger option earlier. When I said it would do so continuously, I forgot you had to explicitly enable that first (which makes sense and I appreciate.)

* I edit the release definition
* I click the lightning bolt, enable continuous deployments, and add a filter for the branch:

> ![clicking the lightning bolt icon](https://user-images.githubusercontent.com/2148318/57165296-a9b8f800-6dc4-11e9-811d-c72e7292161c.png)

* I save the release.

...*now* it deploys automatically. For real for real.

## The Results

Now I see:

* ✅ The build finishes 
* ✅ The release created itself
* ✅ The release deploys the blob appropriately
* ✅ The timestamps on the blob are updated
* ✅ The status indicators on the README are correct.

And with that, our work is done!
