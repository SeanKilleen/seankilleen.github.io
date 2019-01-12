---
title: "Sharing my reading list in real-time with Feedly and Azure Functions"

date: 2019-01-11 14:00:00:00.000000000 -05:00

comments: false
---

I've been a fan of RSS feeds for a long time. I love curating a collection of knowledge that streams to me at my pace, and I consider feeds to be a fundamental piece of how I keep up with technology and stay fresh. I currently use [Feedly](http://feedly.com) and have been a happy pro user for years.

But something is missing. As much as I like reading, I also like sharing.

## The Requirements

I think the requirements for this mini-project will be:

* **Only show my development-related feeds**. I've got a ton of RSS feeds, and as much as I'm sure everyone would like to see my politics :wink:, we'll want to filter the RSS feeds list to only those that would be relevant to developers.
* **Can continuously run with minimal intervention**. I need this system to be pretty low maintenance. It can't be held together with duct tape.
* **Cost-effective.** I don't want to spend a ton of money on this.

Luckily, with the benefits of Azure functions and APIs, I think we can make this work in a cost-effective way.

## The Ingredients

My solution is going to make use of:

* **The Feedly API.** Feedly is kind enough to provide a developer API for access to your feeds (I think even for non-pro users?). This is what will give us access to our feeds.
* **Azure Functions** is a perfect fit for this. A small, light-weight, cost-effective, easily-deployable solution to interact with APIs. We'll use functions to keep the Feedly auth token up to date (it needs to be refreshed), and to filter the OPML feed file to to the contents that we want.
* **Azure KeyVault**. Since we're dealing with authorization tokens, I'm not just going to be dumping them any old place, even though it would probably be pretty fast to dump them plain-text into a private Azure storage blob. Safety first!
* **Azure Storage Blobs**. We'll have the function post the current list to a storage blob, where we can expose its contents publicly and link to it directly from this static site.
* **VS Code**. This time around, I'm going to try to do everything from VS Code and the command line. Because why not?

## Getting Started

* **Sign up for an Azure account**. You can [do it here](https://azure.microsoft.com/free/) if you don't already have an account (I believe they provide 30 days free with roughly $200 in credit, which is pretty awesome.)
* **Get a Feedly API key**. You can [obtain the key here](https://feedly.com/v3/auth/dev), which will ask you to sign in, and then will provide you with your User ID and a link to your auth token & refresh token. Place these IDs and tokens in a notepad document or someplace temporary, or in a password manager.
* **Install .NET Core SDK.** We'll be using .NET Core to develop our app. You can get it here. You can get it from <https://dotnet.microsoft.com/>.
* **Install VSCode.** This isn't a requirement by any means. It's just an editor, but it's a mighty fine one and I suggest you familiarize yourself with it. You can get it at <https://code.visualstudio.com/>.

## Create a Resource Group in Azure

* Log into your [Azure Portal](http://portal.azure.com)
* Click `Resource Groups` on the left-hand side, and click "Create Resource Group"
* Enter the information for your resource group. Here, I'm using `sean-feedly-opml-export`.
* Click the review and then create buttons to create the group.

## Setting up the Azure Key Vault

* Open the resource group you created, either by going to `Resource Groups` on the left-hand menu or selecting "Go to resource group" when the success message appears upon creation.
* Click "Add" to add a resource.
* Search for `Key Vault`, and select the Azure Key Vault offering by Microsoft.
* In the blade that opens to the right, click "Create".
* Give the key vault a name. I chose `feedly-export-keyvault`.
* For the `Resource Group`, select the group you previously created.
* The rest of the options (Standard pricing, principle, network access) can all remain in their default selections.
* Click `Create` to create the keyvault, and allow a little time for the deployment to complete

## Add Your Keys to the Key Vault

* Open your Key Vault resource by navigating to "All resources", finding the key vault you created, and clicking on it.
* Under settings, click `Secrets`.
* When the `Secrets` blade appears, click `Generate/Import`.
* Enter the name of the secret. First up, we'll use `feedly-user-id`.
* Paste the user ID you previously generated, and then click `Create`.
* Repeat the process for secrets that we'll call `feedly-access-token` and `feedly-refresh-token`.

Awesome! Now you can delete that notepad doc you have lying around.

## Setting up the Azure Function Project

You can create Azure functions directly from the portal, but that bugs me because I want the benefits of source control, automated deployments, etc. -- so, for the purposes of this project, I'm going to create [a repository on GitHub](https://github.com/SeanKilleen/feedly-opml-export). You can create one and follow along, or feel free to [clone my repo](https://github.com/SeanKilleen/feedly-opml-export).

These instructions assume that you're creating all of the below within a repository that will be hosted on GitHub. If you have any questions about getting that piece set up, drop a line in the comments and I'll be happy to try to assist.

## Creating the Azure Functions Project

### Getting Set up in VS Code

* Clone the new repository you created from GitHub
* Open the root of the repository in VS Code
* Open a terminal in VSCode via the `Terminal` menu or `CTRL + Shift + ``` `

### Downloading the Azure Functions dotnet new templates

We're going to use the `dotnet new` command to create our templates, so first we need to make those templates available to ourselves.

The [Azure Functions docs have a nice guide to doing this](https://github.com/Azure/azure-functions-templates/wiki/Using-the-templates-directly-via-dotnet-new), so I'm following their steps:

* I head to <https://functionscdn.azureedge.net/public/cli-feed-v3.json>
* I look for the latest `v2` release -- at the time of this writing, `2.15.0`.
* I head to the `2.15.0` entry, and copy the URLs for the `itemTemplates` and `projectTemplates` entries.
* I go to each URL in a browsers, which downloads the respective `nupkg` file.
* I then run `dotnet new -i` for each nupkg file I downloaded, e.g. `dotnet new -i C:\users\SeanK\Downloads\microsoft.azure.webjobs.itemtemplates.2.0.10321.nupkg`.

## Setting up a function to refresh the auth key

## Setting up a function to extract the OPML

## Creating the Storage Blob to hold the outputted file

## Creating the function to persist the file

## Updating the readability of the blob so we can access it from the blog

## Adding the link to the content

## See it in action!

You can find the source code for this project on GitHub -- feel free to use it yourself! (TODO: Add link)

## What do you think?

Have you found a similar way to do something? Do you have thoughts on the best way to accomplish this? I'd love to hear your feedback on this or about different approaches. Sound off in the comments!