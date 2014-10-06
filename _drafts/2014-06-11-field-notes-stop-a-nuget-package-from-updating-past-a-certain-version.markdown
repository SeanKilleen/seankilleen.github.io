---
layout: post
title: 'Field Notes: Stop a Nuget package from updating past a certain version'
---
Problem

We recently ran into an issue where we relied on a package, but updating that package beyond a certain version introduce new dependencies and bricked our project. We wanted to be able to run "Update-Package" from within Visual Studio and have it support that.

Solution

As of Nuget 1.4, this is possible.

In your packages.config file, for each package you want to stop updating, add:

allowedVersions="(x]"

where x is the current version number.

References


Nuget 1.4
