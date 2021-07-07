---
title: How To Automate AWS CloudFront Distribution Folder Changes When Deploying
  a Static Web Site
comments: true
tags:
  - CI/CD
  - deployment.devops
  - aws
  - cloudfront
  - s3
date: 2021-07-06 22:36 -0400
---
I was working on a project that deployed its UI, an Angular site, to an S3 bucket that was then placed behind CloudFront.

So that we had repeatable builds and weren't overwriting code, every deployment when into a new folder in the S3 bucket.

## The Challenge

When our code was deployed, we still needed to update the CloudFront distribution to point to the new location in order to pick up the latest files. Unlike something like a Lambda deployment, AWS doesn't allow you to specify a new folder for the S3 distribution as its own command. You instead have to pull the entire configuration, modify it in a few ways, and then update the configuration.

## The Ingredients

At our disposal in this case we had:

* An OctopusDeploy instance
* An Octopus Linux Worker with [jq](https://stedolan.github.io/jq/) installed.
* The AWS CLI with a profile we could make use of that had appropriate permissions

This approach should work with anyone that has a deployment worker that can run jq and a bash script or similar.

## The Overall Approach

We need to:

* Get the CloudFront distribution's configuration, and save the JSON
* Strip out the ETag (per Amazon docs)
* Modify the configuration we want
* Save the new JSON
* Update the configuration using that JSON

**Danger!** It's really important that you understand the sequence above. CloudFront updates are full replacements, not additive. If you only supply the changed part of the configuration, the rest will be reset, which doesn't sound like a fun time to me.
{: .notice--warning}

## A Few Things I Tried That Didn't Work

* **Using `sed` to do a regex find/replace**: Prior to using `jq`, I attempted to use `sed` to accomplish the find/replace. I spent a long time looking into the right regex to use, only to discover that `sed` doesn't easily support multi-line regex.
* **Using Perl for a multi-line regex**: I've never been great at Perl. This time was no exception.

Thinking about this more deeply led me to `jq` when I realized I didn't want to find/replace -- I wanted to modify the structure of a JSON document. That's the purpose of `jq`.

* Can't just point to new code folder; need to pull config, modify it, and update it
* AWS CLI allows you to pull the configuration
```bash
aws cloudfront get-distribution-config --id $cloudfront_distribution_id --profile $profile_name --region $region > output.json
```
* jq can parse the configuration in a reliable way
 
```bash
cat output.json | jq ".ETag = \"\" | (.DistributionConfig.Origins.Items[] | select(.Id == \"THE_ID_OF_THE_ORIGIN\")).OriginPath = \"/THE_NAME_OF_YOUR_FOLDER\""
```

Some things to understand:

* We escape the quotes using `\`.
* We're escaping them because we're using `"` vs `'` because my actual script uses references to variables, e.g. `$myVariable`, which needs double-quotes in order to be interpolated.

So modify the command above to spit it out to another file: 

```bash
cat output.json | jq ".ETag = \"\" | (.DistributionConfig.Origins.Items[] | select(.Id == \"THE_ID_OF_THE_ORIGIN\")).OriginPath = \"/THE_NAME_OF_YOUR_FOLDER\"" > updated-config.json
```

And now you can modify the config as well:

```bash
TODO -- add bash command
```


Reference the SO question:

* https://stackoverflow.com/questions/68074046/how-can-i-output-the-whole-document-in-jq-while-replacing-an-item-based-on-a-fie/68074394

## Full OctopusDeploy step

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

# Get the current distribution's config as a JSON file and output it 
# to a file.
aws cloudfront get-distribution-config --id $cloudfront_distribution_id --profile $profile_name --region $region > output.json

echo "----- ORIGINAL JSON -----"

cat output.json

echo "----- RUNNING JQ -----"

# This takes the JSON file, removes the ETag field, selects the 
# appropriate distribution config item, and sets the origin path 
# to the S3 folder we expect. It then spits that config out to 
# its own file

cat output.json | jq "del(.ETag) | (.DistributionConfig.Origins.Items[] | select(.Id == \"$cloudfront_s3_origin_id\")).OriginPath = \"/$release_number\" | .DistributionConfig" > updated-config.json

echo "----- UPDATED JSON: -----"
cat updated-config.json

echo "----- GETTING ETAG VALUE FOR LATER USE -----"

# AWS CLI Requires us to specify the etag from this request, to make 
# sure nobody has made a change since we last pulled the config.
# This extracts the content of that tag. The -r parameter outputs
# the field as "raw" data, without quotes, which we want for our
# variable.
etag=`cat output.json | jq -r ".ETag"`
echo $etag

echo "----- CALLING TO UPDATE -----":
# Pass in the modified configuration file and the etag value to
# the cli command to update the distribution.
aws cloudfront update-distribution --id $cloudfront_distribution_id --profile $profile_name --region $region --if-match="$etag" --distribution-config file://updated-config.json
```