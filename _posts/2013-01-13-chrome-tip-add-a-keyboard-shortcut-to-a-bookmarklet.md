---
 
title: 'Chrome Tip: Add a Keyboard Shortcut to a Bookmarklet'
comments: true

date: 2013-01-13 12:45:00.000000000 -05:00

---
I use [Google Chrome] for a lot of browsing, and I've been getting into [Delicious] for archiving content that I know I might want to find again but don't want hanging out in my Google Reader. It's sort of a take on [Scott Hanselman's workflow] for reading and archiving.

The other day I thought: it would be nice if I had a keyboard shortcut while browsing to save to delicious, instead of navigating through the bookmarks bar to click it? And a short google search later, up popped [a great process]() (Ed. note: unfortunately this link has been lost to time.) from the Switched Download Squad.

#### The abbreviated steps are:

* Copy the text of your delicious bookmarklet (edit the bookmark and then copy the location -- it's a bit of javascript that you'll be copying)
* Right-click on Chrome's address/Search bar and select `Edit Search Engines..`
* Scroll to the bottom of your search engines and add a new one. I chose `Add to Delicious` for the title.
* Give the search engine a keyword -- preferably a short one. I chose `d` for delicious.
* Paste in the javascript.

#### Now, to use it:
* Navigate to a page that you want to save
* Type `CTRL + L` (this activates the search bar), then your keyword (`d` in my case), then enter.

This effectively opens the search bar, chooses your "search engine", and navigates to it (which opens the bookmarklet javascript code).

Use for any bookmarklet you need.

[Google Chrome]: https://www.google.com/intl/en/chrome/browser/
[Delicious]: http://delicious.com/
[Scott Hanselman's workflow]: https://www.hanselman.com/blog/InstapaperDeliveredToYourKindleChangesHowYouConsumeWebContentPlusIFTTTBlogsAndMore.aspx