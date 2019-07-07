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

A friend has a web site in Azure that has 3 DBs: `Staging` (a preview environment), `Copy` (a copy of prod), and `Prod`. The DBs are on a SQL server within Azure (not CosmosDB or another service offering). The data amount isn't huge but it's important.

These web sites have been kept (roughly) in sync via manual updates but have small discrepancies here and there.

Any change made to the schema involved generating SQL scripts and was inconsistent at best and often a headache, preventing them from going faster. The site used an EDMX that was generated from a database a long time ago but wasn't necessarily up to date.

Migrations weren't an option as/is -- the databases already existed, and none of their models were quite the same (though they were highly compatible), so I would have run into errors when applying to some environment. And also, given that this is on a web site that they're running, I didn't want to screw anything up or add risk for them.

## The Goal

I wanted to enable my friend to:

* Use Entity Framework's Migrations so they'd have consistent schema/data before things got out of hand
* Move to a code-first migrations setup
* Not break anything running

## The Overall Approach

I decided to:

* Move to EF code-first migrations
* Copy the SQL Server using Azure RM
* Apply migrations
* Use SSDT to get the data into my new DBs 
* Switch the connection strings

## What I did
