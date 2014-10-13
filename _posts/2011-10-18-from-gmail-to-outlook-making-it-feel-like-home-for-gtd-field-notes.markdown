---
layout: post
title: 'From GMail to Outlook: Making it Feel Like Home for GTD [Field Notes]'
date: 2011-10-18 13:27:00.000000000 -04:00
comments: true

---
I recently started a new job at the [Johns Hopkins Applied Physics Laboratory](http://jhuapl.edu/) in Laurel, MD. It's a great gig so far, but one of the pain points I hadn't expected was moving from Google Apps to Outlook. I had a system in GMail that worked perfectly for my brain, but I needed to find a new solution. This post details how I got myself back to my organizational "happy place".

###Requirements
I really liked my GMail system, so I wanted to keep the basics. I decided that the following were "must-have" capabilities:

* **Labels:** This has been indisputably the best feature of GMail for me. Assign labels that stand for categories, statuses, references, etc. -- I needed to recreate that experience, with distinct colors if possible.
* **The Archive Button:** After I've labeled and sorted my mail, I need to get it out of my inbox and into an Archive folder. A button is best suited to this task.
* **Seeing Status Messages and counts**: It's important to me to be able to do a quick review of what I need to do next, what I'm waiting on from folks, etc. In GMail, I used multiple inboxes with status labeled to achieve this effect. 

###Step 1: Defining Categories and Hot Keys
I created three sets of Categories to start with, and assigned each a different color.

####Status Categories
These start with `S/` and are orange in color. I defined the following:

* S/Next Action
* S/Action
* S/Waiting On
* S/Follow-Up
* S/Someday
* S/Finished

####Project Categories
These start with `P/` and are green in color. I defined one for each project I'm involved with.

####Reference Categories
These start with `R/` and are purple. I defined the following:

* R/General
* R/Credentials
* R/Accomplishments

My next steps will likely be to define context categories (`C/`) and Vendor Categories (`V/`) once I start having interactions that would benefit from them.

I then assigned hot keys to each of the status categories. This can be done from the Categories List. I assigned the following Hotkeys:

| Status | Key |
| S/Next Action | CTRL + F2 |
| S/Action | CTRL + F3 | 
| S/Waiting On | CTRL + F4 |
| S/Follow-Up | CTRL + F5 |
| S/Someday | CTRL + F6 |
| S/Finished | CTRL + F2 |

###Step 2: Creating an Archive Button
Thanks to [this excellent article at Lifehacker](http://lifehacker.com/5175347/add-a-gmail+like-archive-button-to-microsoft-outlook), I was able to create an Archive button similar to Gmail's. The steps I took (slightly different from the article) are below.

####Create an Archive Folder in your Outlook Mailbox
Under the top-level folder of your mailbox, create an "Archive" folder on the same level as Inbox, Junk E-Mail, Outbox, etc.

####Create a Digital Signature for VBA Projects
This is necessary to avoid a macro warning pop-up everytime you do something in Outlook. Highly recommended.

* Open the `Digital Certificate for VBA Projects` utility 
 * Start typing it into the start menu and it should come up).
* Follow the steps to create a certificate. I either named it "Me" or "Sean Killeen", I forget which.

####Creating the Macro
* Select `_Tools > Macro > Macros` from the menu
* Type in the name for your Macro (e.g. "Archive Button") and click `Create`.
* When the VBA Editor opens, enter the following script:

        Sub Archive()
        
        Set ArchiveFolder = Application.GetNamespace("MAPI").GetDefaultFolder(olFolderInbox).Parent.Folders("Archive")
        
        For Each Msg In ActiveExplorer.Selection
            Msg.UnRead = False
            Msg.Move ArchiveFolder
            Next Msg
        
        End Sub

This script marks the message as read and puts it in your archive folder.

###Step 3: Creating Search Folders for Monitoring Statuses
Next, I used search folders to help me monitor different statuses. Unfortunately, the best way to create these search folders is to use the QueryBuilder, which Microsoft for some unfathomable reason has disabled by default.

After a finding a [great article on TechnoSpot](http://www.technospot.net/blogs/outlook-create-powerful-search-folders-with-query-builder/), I answered [my own question on SuperUser](http://superuser.com/questions/346295/outlook-search-folder-how-to-filter-messages-that-have-one-category-but-dont).

####Enabling QueryBuilder in Outlook 2007 via a Registry Hack
* Run `regedit` in your run command or via `Win + R`
* Navigate to `HKEY_CURRENT_USER\Software\Microsoft\Office`
* If you have Outlook 2007 navigate to the `12.0` folder
* Right click on `Outlook` and Add a new key. Name it `QueryBuilder`
* Exit Registry editor.

####Creating the Advanced Query
The process below is using the `S/Next Action` category as an example. Repeat it for each of your Status categories.

* In Outlook, select the `Tools menu > Instant Search > Advanced Find`
* Click the `Query Builder` tab (which did not exist before our registry hack)
* Define the first criteria
 * **Field**: "Categories"
 * **Condition**: "contains"
 * **Value**: "S/Next Action"
* Define the second criteria
 * **Field**: "Categories"
 * **Condition**: "Doesn't Contain"
 * **Value**: "S/Finished"
* Select the logical group
 * From the `Logical Group` drop-down, select `AND`. This is key to making sure that Outlook enforces all the criteria (which is not normally the case; hence this post)
* Set the Scope to of the Search to the Desired Level
 * In the `Look for:` drop-down, select `Messages` (likely already selected
 * Click `Browse`
 * Make sure all appropriate folders are selected (I chose the entire mailbox)
 * Check the `Search Subfolders` checkbox
* Save the Query as a Search Folder
 * In the `Advanced Find` window, click `File`
 * Click `Save as Search Folder` and name the Search Folder.
  
####Customizing Folder Positions and Showing all Messages
In order to be able to move the folders as we like (instead of being locked into alphabetical order), we make the folders "Favorite Folders.

* Right-click on each of the Status folders and choose `Add to Favorite Folders`. This will place the folder in the top list of folders.
* Order the list as you want in favorite folders -- I usually place them in my order of importance, which for me is:
	* Next Action
	* Action
	* Waiting On
	* Follow-Up
	* Someday
* Right-click each status folder and select `Properties`. 
* In the properties window, select `Show total number of items.`

###The Results!
Not "home", per se, but at least a comfortable apartment.

###References
Below is a recap of the list of resources that helped me solve this problem.

* [Add A Gmail-like Archive Button to Microsoft Outlook](http://lifehacker.com/5175347/add-a-gmail+like-archive-button-to-microsoft-outlook) [[Lifehacker](http://lifehacker.com/)]
* [Outlook: Create Power Search Folders with QueryBuilder](http://www.technospot.net/blogs/outlook-create-powerful-search-folders-with-query-builder/) [[TechnoSpot](http://www.technospot.net)]
* [Outlook Search Folder -- How to Filter Messages That Have one Category but Don't Have Another?](http://superuser.com/questions/346295/outlook-search-folder-how-to-filter-messages-that-have-one-category-but-dont) [[SuperUser](http://superuser.com)]
