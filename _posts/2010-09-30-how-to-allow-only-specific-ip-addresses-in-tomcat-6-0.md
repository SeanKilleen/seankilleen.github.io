---
title: 'How To: Allow only Specific IP Addresses in Tomcat 6.0'
date: 2010-09-30 11:47:00.000000000 -04:00
comments: false
redirect_from: 
 - /2010/09/how-to-allow-only-specific-ip-addresses_30.html
---

This one's not exactly under-documented, but I wanted to post here as a reference and in the hopes that someone else might have to not dig around.

### The Problem

Our client needed to take a webapp down for maintenance (re-organization across the institution) and needed to block access to Tomcat for all users except the specific administrators performing the re-organization).

### The Solution

Use Tomcat to block all connections with the exception of administrator IP Addresses (which were static to us and known).

### The Steps

* Open the context.xml file, located in [Tomcat[^1]]`confcontext.xml`.
* If you've never edited this file before, you should see a line like the following:

```conf
<WatchedResource>WEB-INF/web.xml</WatchedResource>
```conf

* Add the following line directly after the `</WatchedResource>` tag:

```conf
<Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="IP1|IP2|IP3">
```

...where IP1, IP2, IP3, etc. are the IP addresses you would like to allow.

* Restart the Tomcat server.

### Notes on How it Works

This valve uses regular expressions, so if you decided to get fancy with it, you certainly could (provided you know a little about Java Regular Expressions). For our purposes, the pipe ("|") character in-between the IP addresses works as an "or" operator. If the Remote Address Value matches any of these full strings, it is allowed.

Note that by default, this denies every other connection.

If you'd like to allow all connections except certain IP addresses, you can change the "allow" attribute to "deny"; all connections will be allowed except those in the deny attribute, which still uses Java regular expressions.

To my knowledge, this "valve" structure can't be stacked. That is to say, you can't do a "deny all" valve and then stack multiple types of "allow valves" on top of it. If anyone knows if this is possible, feel free to sound off in the comments.

Hope this helps!

### Footnotes

[^1]: where [Tomcat] is the base location of your Tomcat server.
