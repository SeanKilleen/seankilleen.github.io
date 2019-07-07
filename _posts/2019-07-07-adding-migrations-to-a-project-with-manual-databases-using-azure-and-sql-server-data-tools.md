---
title: >-
  Adding Migrations to a Project with Manual Databases using Azure and SQL
  Server Data Tools
comments: true
tags:
  - azure
  - ssdt
  - sql server
  - sql
  - migrations
  - entityframework
  - ef6
date: '2019-07-07 09:31 -0400'
---
I recently had a bit of a fun experience where I was able to safely pull off an operation that I previously thought would have been too risky, thanks to some of the great tooling in the Azure & SQL Server spaces. Thought I'd write that up.

## The Challenge

A friend has a web site in Azure that has 3 DBs: `Staging` (a preview environment), `Copy` (a copy of prod), and `Prod`. The DBs are on a SQL server within Azure (not CosmosDB or another service offering).

These web sites have been kept (roughly) in sync via manual updates but have small discrepancies here and there.

Any change made to the schema involved generating SQL scripts and was inconsistent at best and often a headache, preventing them from going faster. The site used an EDMX that was generated from a database a long time ago but wasn't necessarily up to date.

## The Goal

I wanted to enable my friend to use Entity Framework's Migrations
