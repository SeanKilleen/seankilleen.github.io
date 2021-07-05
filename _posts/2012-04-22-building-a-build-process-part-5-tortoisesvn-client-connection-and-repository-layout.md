---
 
title: 'Building a Build Process: TortoiseSVN Client Connection and Repository
  Layout'
date: 2012-04-22 22:24:00.000000000 -04:00
comments: false
series: building-a-build-process
redirect_from: 
 - /2012/04/building-build-process-part-5.html
references: 
 - title: Pluralsight Continuous Integration Course
   url: https://www.pluralsight.com/courses/continuous-integration
 - title: Subversion book
   url:  http://svnbook.red-bean.com/
 - title: Download TortoiseSVN
   url:  https://tortoisesvn.net/downloads.html
 - title: Donate to TortoiseSVN
   url: https://tortoisesvn.net/donate.html
---
{% include _buildseries-intro.md %}

Welcome back! Now that we have a TLS-encrypted Apache setup with SVN, we’re going to take a look at creating the repository layout.

**NOTE:** Before I begin, I should mention that while I will speak about them authoritatively, the methods for laying out repository structures are by no means set in stone, and are in fact debated quite vigorously at times in the tech community. This is the general flavor that I’ve picked up in some places, including an excellent [Pluralsight Continuous Integration Course] by [James Kovacs]. It’s the style that I believe I’ll adopt going forward, though don’t hold me to it.

### Obtaining TortoiseSVN

TortoiseSVN is pretty much the de-facto standard for Subversion clients on Windows. The latest version as of this writing is 1.7.6. You can download the [32-bit version] or [64-bit version] from [their downloads page].

Installing Tortoise is about as standard as it gets. Run the installer, accept the license agreement, and select the options for install.

During this time, I usually right-click `command line client tools` and install it by choosing `will be installed on local hard drive`. You never know when they’ll come in handy (though I don’t intend to refer to them in this series).

After this, the app installs. **NOTE:** If you’ve got some cash, I highly recommend you [donate to the TortoiseSVN project]. It’s a fundamental piece of software for developers and good software deserves our support.

### Linking a Local Folder to the Repository

Our first step is to pull down the repository we created (which is currently blank, but nevermind that):

* Create a folder somewhere on your hard drive where you would store repository data (for example, mine is in `C:\Users\Sean\Repositories`, and I have a Win7 Library configured to point there).  
* Navigate into that folder.  
* Create a new folder called `TestProject`, named after the repository we created on the Subversion CentOS VM.  
* Right-Click on the TestProject Folder. Notice that there’s some new options now; this is where TortoiseSVN lives – in your context menu.  
* Select `SVN Checkout`. This tells Tortoise to attempt to pull down a repository into the folder you have selected.  
* For the URL of the repository, type `https://[ip or hostname of your svn server]/svn/TestProjectRepo`. Note the **https**; we’re going to pull this repository down over a TLS-encrypted connection.  
* Double-check that the checkout directory is the new folder that you created on your local machine called TestProject, and then Click `OK`.  
* At this point, you will likely receive a message about the fact that certificate failed. Click `Accept the certificate permanently`, since we know the certificate is trustworthy (we created it, after all)  
* Next, you’ll be prompted for username and password. Enter one of the two logins we created [when we initially set up Subversion]({% post_url 2012-04-17-building-a-build-process-part-4-source-code-management-via-subversion-and-apache-on-centos %}). You may want to click `save authentication`; otherwise you’ll be prompted for it whenever you communicate with the repository.

You will see through the TortoiseSVN dialog box that the process is completed. The folder may also have a green check-mark overlaid. This is TortoiseSVN’s handiwork; it lets you know that a repository is up to date.

### Creating the Initial Repository Layout

Enter the TestProject folder on your local machine. We’re going to create three empty folders under this directory that have a very specific meaning. Create the following folders:

* trunk  
* branches  
* tags

This is one of the standard layouts for a repository in Subversion, and the one I tend to use. The subversion concepts related to these folders are something like the following:

* **Trunk**: This where the main portion of development takes place. It is sort of the “master timeline” of real-time development of your application source code. More often than not, your working copy (more on this soon) will be the trunk.  
* **Branches**: With subversion, you can create branches. Think of it like creating an alternate reality of your code at a specific point in time. You can take your whole system as it is, and “branch it” to either fix bugs for a specific point in time, or branch it to implement a certain feature based on the code at that point. Branching can be kind of a pain in Subversion, as you then have to merge your changes back into the trunk, so you tend to do a lot of branching and merging to ensure things stay in sync. For this reason, I avoid it unless it’s necessary. I do however, like the idea of branching when code is released, so that you can fix bugs for that release and then merge it back into production.  
* **Tags**: Think of tags like a read-only branch, or a copy of your code frozen at a specific point in time. This is actually pretty cool. It allows you to do things like tag every major release, so that at any point your developers can pull it back up and compile it to check it out. Imagine a big client comes to you and they have a bug in a legacy version of the application you put out. You can’t force them to upgrade. How do you figure out what the code was at that point in time? Simple; just pull down the tag folder and it’s there.

Normally, you won’t be looking at all three of these at once. You’ll want to create what’s called a **working copy** of the source that is connected either to the trunk, or a specific branch. Think of your working copy as your lens into the source code. We’ll be creating the working copy soon, but first we have to commit this initial structure.

### A Word on the Update / Commit Cycle

A big idea behind subversion is that instead of locking files so only one person can use them, it allows all people to edit all files in the repository (assuming they don’t have read-only access). This is usually vastly more efficient, but it does come with some caveats. If two people edit the same file, it will create a conflict, and that conflict will have to be resolved by a differential view and resolution (“diff”) of the two versions of a file with another developer. This isn’t usually a bad thing, but it becomes cumbersome if the files haven’t been checked in for a long time.
To avoid this, I usually stick to the following principles:

* Before you begin coding, update the repository by right-clicking on the project folder and choosing `SVN Update`. This will get the latest copy of the source code.  
* As you work on the code, update once in a while in case someone has made changes that need to be merged with your file. Little changes made more often means smaller, more manageable conflicts.  
* Update once before you check your code in to ensure that no conflicts will arise.  
* Check in your code several times a day (if you’ve added something complete and useful that works.) this will ensure that your changes are smaller for other developers (more on the check-in process below.)  
* Always add a message when you check in and describe your changes in enough detail so that others can understand them. No novels are necessary, but it’s important to know in human-readable form who changed what, when, and why.

### Committing Our First Changes

So, we added three folders to the repository. As small of a change as it is, it is a change, and so we need to check those changes in so Subversion can pass them along to anyone else. To do this:

* Right-click on the TestProject folder and select `SVN Commit…`  
* Enter a message into the message box that makes sense (e.g. “Added initial folder structure”.)  
* Note that since we added new items, they’re not currently under source control. Subversion is smart enough to not add new items unless you tell it to.  
* If you don’t see any files, make sure the `Show unversioned files` checkbox is checked.
* Click the `All` button and subversion will select all items to commit them to the repository.  
* Click `OK` and the folders will be committed to the repository. You see that it added each folder, and that the repository is now at revision 1.

### Creating the Working Copy

Now that we have the files committed to the repository, we can delete the local folder because we know the files are committed to the repository and we can pull them down again later. That’s exactly what we’re going to do, but this time, we’re going to create our working copy by pulling down only the trunk.

* Delete the TestProject folder in windows explorer.  
* Create a new folder called TestProject.  
* Right-click the TestProject folder and select “SVN Checkout…” from the menu.  
* Make the URL of the checkout path `https://[ip or hostname of svn server]/svn/TestProjectRepo/trunk` and click `OK`.

The trunk will be pulled down, and you’ll see it’s at revision one. Now, even though “branches” and “tags” exist in the universe, the world we know will consist of the trunk folder. If we ever need to switch to a branch, we can do this through the `Switch` statement (but we have no use for that now).

### Creating the Project Folder Structure

After watching the Pluralsight course on Continuous Integration, I really like the layout that was chosen for the project. We’re going to create a folder structure, and then I’ll explain why we created it like we did.
Create some new directories so the folder structure looks like the following:

```none
    TestProject/ (already exists)  
        buildartifacts /
        src/
            app/
            test/
        thirdparty/  
            libs/  
            tools/
        doc/
```

These folders have the following purposes:

* `TestProject` (root folder): This is where your solution file will be. Later in this series, it will also be where we place the MSBuild XML file that applies to our software.  
* `buildartifacts`: This is the place where we’re eventually going to put all of the code that we’ve compiled, automatically, via the MSBuild script. This folder should be left out of source control because everyone’s binaries will be different and not of much use except to the developer (more on that later).  
* `src`: as you probably guessed, this is where all our actual source code is going to go.  
* `app`: this will store all the application source code (your individual projects will eventually be in this directory)  
* `test`: this is where all your unit testing and integration testing projects will live. This will let us do some handy things later as far as packaging up the project for release, etc.  
* `thirdparty`: this where code goes that isn’t yours. Could be something you referenced, or an open-source project that you make use of, etc.  
* `libs`: this is specifically for third-party libraries that you use within your source code.  
* `tools`: this is for DLLs or applications that help you with the build process or things external to your source code. Think NUnit for running unit tests, or special add-ons to the MSBuild DLLs.  
* `doc`: this is where all your documentation for your projects should live, if you need to reference it. It could be internal documentation if you choose to keep it this way, a user manual that evolves along with the project, a dictionary of acronyms or documentation on processes for your developers or business use cases or marketing materials. Any documentation that is based on the code in the src folder that evolves along with it should be included here.

At this point, let’s update the solution by right-clicking TestProject and selecting `SVN Update`. Since no other changes to our files were detected, the update completes successfully. We then commit the changes by right-clicking on TestProject and choosing `SVN Commit`, following the same process as we did earlier. (did you remember to add a commit message?)

### Creating the Solution in our Project’s Root Directory

After all our hard work to set up the solution right, we’re finally ready to create the solution within Visual Studio.
First, we’ll likely want to [enable the Always Show Solution option within Visual Studio]({% post_url 2012-04-12-quick-tip-always-show-solution-in-visual-studio-2010 %}) so that it’s easier to create a blank solution – which is what we’ll be doing first.
Next, complete the following steps:

* Open Visual Studio 2010 (or version of your choice)  
* Select `New Project`.  
* In the New Project folder, expand the `Other Project Types` folder and click the `Visual Studio Solutions` category.  
* Name the solution `TestProject`.  
* Since a folder is always created for a solution, but we have a folder already, we’re going to choose the location as the folder *above* the TestProject folder. (for example, my TestProject folder is in `C:\Users\Sean\Projects\TestProject`, so I select `C:\Users\Sean\Projects`.) This keeps us from having to copy/paste the solution to the right spot manually later.  
* The new solution is created and you see it within Visual Studio.

### Adding Other Projects Under the src Directory

* Right-click on the newly-created solution in Visual Studio and select `Add > New Project`.  
* Add a C# class library called `TestProject.Core`, in the location of `Test\Project\src\app (the folder structure that we’d created previously). This will be the project that holds all of your application’s shared core logic (in case you need to share code common to both a web site and a WPF app, etc).  
* Delete the `class1.cs` file from the Core Project (we won’t need it).  
* Right-click on the solution and add another C# class project, `TestProject.Core.Tests` (this will hold the tests for the core business code). Give the location of this project `TestProject\src\test`. Delete its class1.cs file as well.  
* Repeat this process for two more projects, An MVC3 Web App called `TestProject.Web` and a class library called `TestProject.Web.Tests`. Can you figure out the right directories to put them in?

At this point, we’ve got a full project setup.

### Committing our Changes – and Ignoring a Directory

We’re ready to commit our changes – or are we?

I’d mentioned earlier that the `buildartifacts` directory doesn’t really make sense to commit, as everyone will have their own, and the files are highly likely to cause conflicts as they are binary files. It would be useless to attempt to try to do much with them outside the contest of our personal development, so we’re going to have subversion ignore the buildartifacts folder, ensuring that it won’t add that information to the repository ever.

* In Windows Explorer, right-click on the buildartifacts folder.  
* Select `TortoiseSVN > Unversion and add to ignore list > buildartifacts`. Subversion will now ignore the whole folder.

With this done, we’re ready to commit all our changes.

* Right-click on the TestProject folder and select …if you guessed *commit*, you’re wrong! Remember, we should update the solution first (it’s a good habit to get into). Select `Update`.  
* With no conflicts detected, select `Commit` and click `all` to select all the new un-versioned files.  
* Hit `OK` and the files will be committed to the repository.

Congratulations! You’ve fully completed a solution setup with Visual Studio and Subversion.

{% include _buildseries-footer.md %}

[32-bit version]: http://sourceforge.net/projects/tortoisesvn/files/1.7.6/Application/TortoiseSVN-1.7.6.22632-win32-svn-1.7.4.msi/download?accel_key=61%3A1335136466%3Ahttp%253A//tortoisesvn.net/downloads.html%3A8d0d4796%24cd1234e7403f638c725cf3902d68531a99393cc5&amp;click_id=e7a29518-8cd0-11e1-9aae-001d0968d1a5&amp;source=accel

[Pluralsight Continuous Integration Course]: https://www.pluralsight.com/courses/continuous-integration

[James Kovacs]: https://www.pluralsight.com/authors/james-kovacs

[64-bit version]: http://sourceforge.net/projects/tortoisesvn/files/1.7.6/Application/TortoiseSVN-1.7.6.22632-x64-svn-1.7.4.msi/download?accel_key=61%3A1335136466%3Ahttp%253A//tortoisesvn.net/downloads.html%3A8d0d4796%24cd1234e7403f638c725cf3902d68531a99393cc5&amp;click_id=e7a29518-8cd0-11e1-9aae-001d0968d1a5-1&amp;source=accel

[their downloads page]: http://tortoisesvn.net/downloads.html

[donate to the TortoiseSVN project]: https://tortoisesvn.net/donate.html
