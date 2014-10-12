---
layout: post
title: 'How to: Quickly update an MVC4 project with Bootstrap LESS and FontAwesome
  [Field Notes]'
date: 2012-12-10 17:30:00.000000000 -05:00
redirect_from:
 - /2012/12/how-to-quickly-update-mvc4-project-with.html
---
###Problem
I'd like to update my MVC4 project to use the following:

* Bootstrap LESS source (Twitter.Bootstrap.Less nuget package)
* FontAwesome instead of Bootstrap's icon set

However, this can be a pain for the following reasons:

* Dotless and Bootstrap's LESS used to not play nicely together
* The "@import" directives sometimes gave dotless an error and had to be worked around.
* Font-Awesome's MIME types are not all recognized by the internal webapps

###Solution
Thanks to the Excellent [Twitter.Bootstrap.Less.MVC4](https://nuget.org/packages/Twitter.Bootstrap.Less.MVC4) package by Christopher Deutsch, this process is a lot easier.

####Install Bootstrap LESS and Dotless

* Create a net ASP.NET MVC4 Web Project.
* Open the package manager console.
* Ensure that your MVC4 Project is set as the current project in the package manager
* Install Chris's package by using the following command: 

```
install-package Twitter.Bootstrap.Less.MVC4
```
* The project will automatically install dotless and Twitter.Bootstrap.Less.</ul>

####Reconciling BundleConfig and Bootstrap.BundleConfig

* If you have an existing BundleConfig.cs that you've made changes to, merge those changes into Bootstrap.BundleConfig.
* If you haven't customized it, you can just delete BundleConfig.cs as all the defaults are in Bootstrap.BundleConfig.cs.

####Install FontAwesome

* From the package manager, run: 

```
install-package FontAwesome
```
* In the Bootstrap.BundleConfig.cs file, add the font-awesome.css file to the StyleBundle so that the line reads as follows:

```csharp
var css = new StyleBundle("~/Content/css")
   .Include("~/Content/site.less", "~/Content/font-awesome.css");
```
* Open your twitter.bootstrap file and comment out the line importing sprites.less. FontAwesome and Bootstrap's sprites naturally conflict as FontAwesome is designed to replace them.

####Update IIS Settings to allow FontAwesome's Static Content
* Add the following to web.config in the `<system.WebServer>` section:

```xml
<staticContent>
       <remove fileExtension=".svg" />
       <remove fileExtension=".eot" />
       <remove fileExtension=".woff" />
       <mimeMap fileExtension=".svg" mimeType="image/svg+xml"  />
       <mimeMap fileExtension=".eot" mimeType="application/vnd.ms-fontobject" />
       <mimeMap fileExtension=".woff" mimeType="application/x-woff" />
</staticContent>
```

####Ensure That Content is Processed on the Server

* In Visual Studio, Select all files in the `/less`, `/font`, and `/content` directory and in the properties for the file, ensure that the Build Action is `Content` and the Copy to Output option is `Copy Always`. This ensures that FontAwesome, Bootstrap, etc will show up in custom builds and when you package for IIS, etc.

###References

* <a href="https://nuget.org/packages/Twitter.Bootstrap.Less">Twitter.Bootstrap.Less</a>&nbsp;[<a href="https://nuget.org/">Nuget</a>]
* <a href="https://nuget.org/packages/Twitter.Bootstrap.Less.MVC4">Twitter.Bootstrap.Less.MVC4</a> [<a href="https://nuget.org/">Nuget</a>]
* <a href="http://blog.cdeutsch.com/">CDeutsch's Blog</a>&nbsp;[<a href="http://cdeutsch.com/">CDeutsch.com</a>]
* <a href="http://stackoverflow.com/questions/13309138/how-to-get-fontawesome-to-work-on-an-azure-web-pages-deployment">How to Get FontAwesome to work on Azure web pages deployment?</a> [<a href="http://stackoverflow.com/">StackOverflow</a>]</ul>
