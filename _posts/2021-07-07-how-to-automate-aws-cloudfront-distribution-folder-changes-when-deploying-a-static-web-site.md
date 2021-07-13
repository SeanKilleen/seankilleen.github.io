---
title: How To Automate AWS CloudFront Distribution Folder Changes When Deploying
  a Static Web Site
comments: true
tags:
  - CI/CD
  - deployment
  - devops
  - aws
  - cloudfront
  - s3
date: 2021-07-06 22:36 -0400
---
I was working on a project that deployed its UI, an Angular site, to an S3 bucket that was then placed behind CloudFront.

So that we had repeatable builds and weren't overwriting code, every deployment went into a new folder in the S3 bucket.

## The Challenge

When our code was deployed, we still needed to update the CloudFront distribution to point to the new location in order to pick up the latest files. Unlike, say, a Lambda deployment, AWS doesn't allow you to specify a new folder for the CloudFront distribution as its own CLI command. You instead have to pull the entire configuration, modify it in a few ways, and then update the configuration.

## The Ingredients

At our disposal in this case we had:

* An OctopusDeploy instance
* An Octopus Linux Worker with [jq](https://stedolan.github.io/jq/) installed.
* The AWS CLI with a profile we could make use of that had appropriate permissions

The approach outlined below should work for an environment that has a deployment worker that can run jq and a bash script or similar.

## The Overall Approach

We need to:

* Get the CloudFront distribution's configuration, and save the JSON
* Strip out the ETag (per [Amazon's docs](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudfront/update-distribution.html))
* Modify the configuration to make our intended updates
* Save the new JSON
* Update the configuration using that JSON

**Danger!** It's really important that you understand the sequence above. CloudFront updates are full replacements, not additive. If you only supply the changed part of the configuration, the rest will be reset, which doesn't sound like a fun time to me.
{: .notice--warning}

## A Few Things I Tried That Didn't Work

* **Using `sed` to do a regex find/replace**: Prior to using `jq`, I attempted to use `sed` to accomplish the find/replace. I spent a long time looking into the right regex to use, only to discover that `sed` doesn't easily support multi-line regex. I could have forced `sed` to do what I wanted, but it wouldn't have been easily understandable to a fresh set of eyes.
* **Using Perl for a multi-line regex**: I've never been great at Perl. This time was no exception.
* **Some incorrect approaches to `jq`**: I hit a wall a few times understanding `jq`'s syntax but [StackOverflow came to my rescue.](https://stackoverflow.com/questions/68074046/how-can-i-output-the-whole-document-in-jq-while-replacing-an-item-based-on-a-fie/68074394)

Thinking about this more deeply led me to `jq` when I realized I didn't want to find/replace -- I wanted to modify the structure of a JSON document. That's the purpose of `jq`.

## Walking Through the Script

Below is the solution I wound up with. Note that all the steps below are all a part of the same bash script; I've only broken them out here to walk through them.

### A Few General Points to Understand

* We escape the quotes using `\`.
* We're escaping them because we're using `"` vs `'` because my actual script uses references to variables, e.g. `$myVariable`, which needs double quotes in order to be interpolated. (...I think. My bash is rusty.)

### Setting up our variables

We use variable references that Octopus fills in here (I love their variable management, btw), but you can feel free to populate them however you'd like.

```bash
cloudfront_distribution_id=`get_octopusvariable "CloudfrontDistributionId"`
profile_name=`get_octopusvariable "AWSProfileName"`
region=`get_octopusvariable "AWSRegion"`
release_number=`get_octopusvariable "Octopus.Release.Number"`
cloudfront_s3_origin_id=`get_octopusvariable "CloudfrontS3OriginId"`

echo "Distribution ID: $cloudfront_distribution_id"
echo "Profile Name: $profile_name"
echo "Region: $region"
echo "Release Number: $release_number"
echo "Cloudfront S3 Origin ID: $cloudfront_s3_origin_id"
```

### Getting the Current Configuration

```bash
# Get the current distribution's config as a JSON file and output it 
# to a file.
aws cloudfront get-distribution-config --id $cloudfront_distribution_id --profile $profile_name --region $region > output.json

echo "----- ORIGINAL JSON -----"

cat output.json
```

### Filtering and modifying the JSON with `jq`

We need to remove the ETag field and update the origin path in the JSON, and output that to an updated JSON file.

```bash
echo "----- RUNNING JQ -----"

# This takes the JSON file, removes the ETag field, selects the 
# appropriate distribution config item, and sets the origin path 
# to the S3 folder we expect. It then spits that config out to 
# its own file

cat output.json | jq "del(.ETag) | (.DistributionConfig.Origins.Items[] | select(.Id == \"$cloudfront_s3_origin_id\")).OriginPath = \"/$release_number\" | .DistributionConfig" > updated-config.json

echo "----- UPDATED JSON: -----"
cat updated-config.json
```

### Getting the ETag

Even though we're removing the ETag, we still need to supply it to the update command, which is how AWS makes sure we're not supplying conflicting changes. If the ETag has changed since we last pulled the configuration, our command will fail.

```bash
echo "----- GETTING ETAG VALUE FOR LATER USE -----"

# AWS CLI Requires us to specify the etag from this request, to make 
# sure nobody has made a change since we last pulled the config.
# This extracts the content of that tag. The -r parameter outputs
# the field as "raw" data, without quotes, which we want for our
# variable.
etag=`cat output.json | jq -r ".ETag"`
echo $etag
```

### Updating the CloudFront Distribution

I initially got stuck here on the ETag issue and then on passing in the JSON string. Upon reading further, I was relieved to know I could specify `file://` and a path to the JSON rather than the long escaped text itself.

```bash
echo "----- CALLING TO UPDATE -----":
# Pass in the modified configuration file and the etag value to
# the cli command to update the distribution.
aws cloudfront update-distribution --id $cloudfront_distribution_id --profile $profile_name --region $region --if-match="$etag" --distribution-config file://updated-config.json
```

## That Ought to do it!

With this script in place in our build step and the variables populated correctly, the CloudFront distribution is updated to point to the S3 folder of our latest deployment.

## Next Steps

* This script will exit with a success code when the CloudFront distribution deployment begins. However, there is still a chunk of time prior to that deployment completing. I'd like to add a wait for that, which I think is an additional call to get the deployment status and wait on it.
* It is still unclear to me whether I need to force an empty of the CloudFront cache in order to have the new files be picked up. My expectation is that pointing to a new distribution folder would take care of that, but I haven't confirmed. it.

## That's a Wrap!

It was fun for me to dive into AWS, the AWS CLI, `jq`, and bash all at the same time to pull this off. And being on the other side of it feels good.
