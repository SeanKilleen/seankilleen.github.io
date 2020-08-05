---
title: "Preparing .NET Projects for Business Trips"
 
date: 2018-08-21 10:00:00.000000000 -05:00

comments: true
---

I have the the good fortune to take some interesting business trips occasionally. However, there are few business trip feelings worse than being mid-flight and realizing that you've forgotten to pull the latest changes for that project you meant to work on.

Below are some steps I've developed -- with some convenient Powershell scripts -- to prepare my code when I travel.

## Defining Some Variables

I begin with two variable definitions:

* `$RepoBaseFolder = "C:\Users\SeanK\Repositories"`
* `$OfflineNugetLocation = "C:\Users\SeanK\OneDrive\Nuget_Offline"`

## Update all the Repositories

I store all of my repositories in `C:\users\SeanK\Repositories`, and I use git for 99% of my source code management. So first up, I pull all of the folders that are in my `Repositories` location, and I git pull to get the latest for each of them.

```Powershell
Get-ChildItem C:\Users\SeanK\Repositories\ -Directory | Foreach-Object { cd $_.FullName; git pull }
```

## Pull and Update Nuget Packages

This ensures I don't run into any restore issues.

I find the location of every `.sln` file within my repositories folder, and I run `nuget install` from that directory.

```Powershell
Get-ChildItem -Path $RepoBaseFolder -Recurse -Include *.sln | Where-Object { $_.Directory.FullName -NotLike "*node_modules*" } | | Foreach-Object { cd $_.Directory.FullName; nuget install }
```

## Pull and Update npm packages

Similarly, it probably makes sense to have all of my npm packages updated -- as much as I hate all of the GBs that's likely going to consume:

```Powershell
  Get-ChildItem $RepoBaseFolder -Recurse -Include package.json | Where-Object { $_.Directory.FullName -NotLike "*node_modules*" } | Foreach-Object { cd $_.Directory.FullName; npm install }
```

Note the additional call to `-NotLike "*node_modules*"`. If we pulled an npm install for every component within `node_modules`, things miiiiiiight take a little longer than expected.

## Move all Nuget packages to the Offline Nuget folder

OK, so I've got the Nuget packages installed for my existing projects, which is great. But what if I want to start a new project? How will I be able to do that without pulling down a ton of things from the internet?

I copy the Nuget packages into my offline packages folder, which happens to be a OneDrive folder as well (so it syncs across my machines).

 ```Powershell
Get-ChildItem -Path $RepoBaseFolder -Recurse -Directory | Where-Object { $_.FullName -NotLike "*node_modules*" -and$_.FullName -like "*packages" } | Foreach-Object { Copy-Item $($_.FullName+"\*.*") $OfflineNugetLocation  -ErrorVariable capturedErrors -ErrorAction SilentlyContinue; $capturedErrors | foreach-object { if ($_ -notmatch "already exists") { write-error $_ }}}
 ```

A few things to note here:

* The additional call to `-NotLike "*node_modules*"`.
* We also make sure that we're only looking at paths that end in `packages`
* We pipe the errors into an `ErrorVariable` so that we can suppress the "already exists" errors when copying

## Enable NPM offline package store

Some people use packages tools such as [npm_lazy](https://github.com/mixu/npm_lazy) or [local-npm](https://github.com/nolanlawson/local-npm), but [according to the docs](https://docs.npmjs.com/cli/cache), npm caches on my local directory of `%AppData%/npm-cache` which means I should be able to restore easily enough if I need to.

So I don't need to actually take any action on this as long as I restore everything ahead of time.

## Enable Nuget Offline Package Source

If I need to, I add an offline package source (only need to do this once):

`nuget source add -Name "Local offline" -Source C:\Users\SeanK\OneDrive\Nuget_Offline`

When I'm in Visual Studio, to ensure that the offline source is the only one that's in use, I do the following:

* Open Visual Studio
* From the menu, select `Tools` --> `Nuget Package Manager` --> `Package Manager Settings`
* Select `Package Manager Sources`
* Un-select all the available package sources that aren't your offline source

## Putting it all Together: the Script

The full script can be found below -- feel free to modify the variables up top and save as your own `.ps1` file.

```Powershell
$RepoBaseFolder = "C:\Users\SeanK\Repositories\"
$OfflineNugetLocation = "C:\Users\SeanK\OneDrive\Nuget_Offline"

Get-ChildItem $RepoBaseFolder -Directory | Foreach-Object { cd $_.FullName; git pull }

Get-ChildItem -Path $RepoBaseFolder -Recurse -Include *.sln | Where-Object { $_.Directory.FullName -NotLike "*node_modules*" } | Foreach-Object { cd $_.Directory.FullName; nuget install }

Get-ChildItem $RepoBaseFolder -Recurse -Include package.json | Where-Object { $_.Directory.FullName -NotLike "*node_modules*" } | Foreach-Object { cd $_.Directory.FullName; npm install }

Get-ChildItem -Path $RepoBaseFolder -Recurse -Directory | Where-Object { $_.FullName -NotLike "*node_modules*" -and$_.FullName -like "*packages" } | Foreach-Object { Copy-Item $($_.FullName+"\*.*") $OfflineNugetLocation  -ErrorVariable capturedErrors -ErrorAction SilentlyContinue; $capturedErrors | foreach-object { if ($_ -notmatch "already exists") { write-error $_ }}}

nuget source add -Name "Local offline" -Source $OfflineNugetLocation
```

## What are Your Steps?

Am I missing any steps that you use to prepare? What other steps do you take to prep your code for travel? Sound off in the comments!

I hope you found this tutorial useful. Happy travels!
