---
title: "Extracting VA Townhall Comments on Youngkin's Reversed School Protections for Transgender Students"
comments: true
tags:
  - artoo
  - javascript
  - docker
  - sqlserver
  - sql
  - vscode
date: 2022-10-03 11:33 -0400
excerpt: "Analyzing Reactions, and providing a little of my own."
header:
 overlay_image: /images/overlays/unsplash/pawel-czerwinski-2dyR13FNg2I-unsplash.jpg
 overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
 caption: "Photo credit: [**Pawel Czerwinski @ Unsplash**](https://unsplash.com/@pawel_czerwinski?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"
---

Virginia's current Governor Youngkin [has recently made headlines](https://www.nytimes.com/2022/09/18/us/virginia-transgender-students.html) by announcing a rollback to policies that previously sought to affirm the identity of transgender youth. I've placed my full take on the policy at the end of this article, but that's not what I want this article to be about. (Spoiler: I stand with the Transgender community and believe students are in charge of their identity. And if you know me, I hope that statement is already obvious.)

[VA has a system called Townhall that is accepting public comment through 10/26](https://townhall.virginia.gov/L/Comments.cfm?GDocForumID=1953).[^1] One of the things that's been eating at me as public comments poured in is that I want the ability to analyze things better, and the VA Townhall site appears to be an old ColdFusion app with only basic CRUD abilities. Is there a way I could get it into a format where I could query the data?

So I decided to do that, and I'm going to list the steps I took here in case you'd like to do the same.

## First: Some Disclaimers

* I didn't see anything anywhere saying I couldn't do this, and the site itself appears to be public. If I've run afoul of any regulations, I'll remove this post, but as far as I can tell I'm in the clear.
* This post is quick &amp; dirty. I'm trying to get the information out there. If something seems hasty, that's because it is. Feel free to add questions & observations in the comments.
* I fiddled with this stuff a bunch over the course of an evening. Don't want anyone to get the impression that I just turn this sort of thing out stream-of-consciousness. :smile:
* You can suggest edits to this page. There's a link at the top. Take me up on it!

## The Ingredients

I used the following to help me out:

* Artoo.js
* jq
* VS Code
* Docker
* SQL Server (the Linux version, running in Docker)
* Azure Data Studio

## Step 1: Load the pages

* Load [the comments page](https://townhall.virginia.gov/L/ViewComments.cfm?GdocForumID=1953)
* Set the page size to `1000` comments per page and hit `Go` to bring back the first page.

## Step 2: Load Artoo and Figure out how to scrape a page

[Artoo.js](https://medialab.github.io/artoo/) is a delightful little client-side scraper. You load it into your browser via bookmarklet and it lets you do all sorts of fun stuff.

In this case, I fiddled around to understand how to extract things. The Townhall site leaves a little to be desired in terms of element naming etc, so some of it's a bit funky.

This script was a one-liner in my browser console window, but I've expanded it here to help make sense of it and explain things.

```javascript
// Comment box has a class of Cbox
var pageNum = artoo.$('#vpage').val();

artoo.saveJson(artoo.scrape('.Cbox', {
    date: function($, el) {
        // normally it's not this hard but their site isn't awesome and I had to do some cleanup
        return $(el).children('div > div').text().split('\n')[1].trim()
    },
    commenter: function($, el) {
        // you get a reference to jQuery and the element so you can do all the things you need
        return $(el).children('div:nth-of-type(2)').text().split('\n')[2].trim()
    },
    subject: function($, el) {
        return $(el).children('div:nth-of-type(2)').text().split('\n')[4].trim()
    },
    comment: function($, el) {
        return $(el).children('div.divComment').text().trim()
    },
    commentId: {
        // or you can simplify it if you don't need a whole big function
        sel: 'a.linklight',
        method: 'text'
    }
}), {
    // easily save out to files -- does JSON, CSV, Text, HTML, etc.
    filename: 'page' + pageNum + '.json',
    pretty: true
})
```

## Step 3: Repeat Step 1 above...for every page.

There are currently 55,000+ comments on this policy.

That meant that for each one of the 56 pages, I had to:

* Click `Next` (this causes a refresh. Thanks, Townhall!)
* Click the bookmarklet to load Artoo
* Hit the up arrow in my browser console to run the scrape again

It wasn't fun, and I'm sure I could have automated it, but I did it manually while I thought about automating it and got through it pretty quickly.

But I was definitely thinking "Hmm, I'll only want to do this for new comments in the future without creating duplicates", so I built that into later steps.

## Step 4: Combine those JSON files

I love [jq](https://stedolan.github.io/jq/) as a tool for processing JSON files.

I concatenated a quick list of filenames together in Excel and then ran:

```cmd
jq -s 'add' page1.json page2.json page3.json page4.json page5.json page6.json page7.json page8.json page9.json page10.json page11.json page12.json page13.json page14.json page15.json page16.json page17.json page18.json page19.json page20.json page21.json page22.json page23.json page24.json page25.json page26.json page27.json page28.json page29.json page30.json page31.json page32.json page33.json page34.json page35.json page36.json page37.json page38.json page39.json page40.json page41.json page42.json page43.json page44.json page45.json page46.json page47.json page48.json page49.json page50.json page51.json page52.json page53.json page54.json page55.json page56.json >> theBigOne.json
```

Now I had one big happy file.

## Step 5: Data Cleanup

But my big happy file also had some bizarre Unicode stuff going on.

* I opened in VS Code and did some find &amp; replace to remove the symbols I saw.
* I also tried a plugin called [Native-Ascii Converter](https://marketplace.visualstudio.com/items?itemName=cwan.native-ascii-converter) but I'm not sure I understood what I was trying to accomplish enough in the moment to use it well.
* I also changed the file encoding to `UTF-8`.
* I spot-checked a bit. It wasn't perfect (see my queries later)

## Step 6: SQL Server (in Docker) Time

* I move my JSON file to `C:\DockerData\youngkin\theBigOne.json` so that I can map it into my Docker container easily
* I mostly wanted a quick setup with default values so I copied from the SQL Server Dockerhub docs with the exception of mapping my import folder:

```cmd
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=yourStrong(!)Password" -p 1433:1433 -v C:\DockerData\youngkin:/var/opt/mssql/import -d mcr.microsoft.com/mssql/server:2019-latest
```

Now I had a container running I could connect to.

## Step 7: A SQL-ing we go!

* I open [Azure Data Studio](https://azure.microsoft.com/en-us/products/data-studio/#overview) -- I've come to really enjoy it as a light go-to SQL GUI.
* I log into `localhost`, with SQL Server authentication. I use the `sa` username and the password we specified in the docker command above.
  * (Obviously not production worthy, but it works for this.)
* I create the table:

```sql
CREATE TABLE Comments (
    -- Note the `IGNORE_DUP_KEY = ON` on the primary key. This way if I keep bulk importing things, I won't get errors; it will only ignore my duplicate entries.
    CommentID int NOT NULL PRIMARY KEY WITH(IGNORE_DUP_KEY = ON),
    CommentDate datetime,
    Commenter nvarchar(MAX),
    Subject nvarchar(MAX),
    Comment nvarchar(MAX)
);
```

## Step 8: Importing my Data

I learned a bunch about the ability to quickly import JSON into SQL Server. [^2] Pretty nice!

```sql
INSERT INTO Comments(CommentID, CommentDate, Commenter, Subject, Comment)
    SELECT 
        -- Some of my scraping turned out to be bad and in certain cases, like when someone left a comment, it would turn the ID into a list of all IDs. At least it started with the correct ID. :) 
        LEFT(thing.commentId, 6) as commentId, 
        -- Yeah, I named the object thing. No, I didn't clean it up for this post. It's late.
        thing.date,
        thing.commenter,
        thing.subject,  
        CASE 
            -- Another weird scraping issue. When someone didn't leave a comment, the comment was scraped as CommentId: [Id]. So I just scrub it out here.
            WHEN LEFT(thing.comment, 10) = 'CommentID:' THEN ''
            ELSE thing.comment
        END as comment
        -- I think this is pretty nifty. Import from the location I mapped with my volume, and auto pull the fields from the JSON.
        FROM OPENROWSET (BULK '/var/opt/mssql/import/theBigOne.json', SINGLE_CLOB, MAXERRORS = 50000) as j 
            CROSS APPLY OPENJSON(BulkColumn)
            WITH(date datetime, commenter nvarchar(max), subject nvarchar(max), comment nvarchar(max), commentId nvarchar(max)) As thing
```

## Now for Some Analysis!

Just getting started on that part. :smile: let me know what you want to see!

* I have 55,000 comments in the DB.
* Of those, 11,342 have a subject that includes `support`, 18,323 have a subject that includes `oppose`, 26,075 have both words and 240 have neither.
  * Hard to gauge sentiment from this though because I didn't analyze who/what the comments claim to be supporting & opposing.
* 33,065 of the 55.5k comments are anonymous
* The top 4 subject lines are `Strongly oppose` (6,366), `Leave Trans Kids Alone` (4,428), `Youngkin Hates` (2,633), and `Glenn Youngkin Is a Bot` (1,363)
  * When taking anonymous items out, they were `Strongly Oppose` (1,342), `STRONGLY OPPOSE.` (844), `This will bring Harm to trans kids.` (797), and `I oppose this fully` (774)

## Jump in!

What do you want to know about this data set? Ask me in the comments and I'll try to get you an answer!

## My Personal Feelings on the Policy

I wanted to make this blog post more about enabling anyone to analyze the comments, but my personal opinion is that I 100% stand with the transgender community.

[My comment can be found here officially](https://townhall.virginia.gov/L/viewcomments.cfm?commentid=179497), but I'm re-posting it here as a matter of record as well.

> This policy's callousness is matched only by its cowardice.
>
> It seeks to roll back existing protections and affirming policies -- ones that support children -- at a time when mental health and well-being is most crucial for students. It denies a student the name of their choice, and the pronouns of their choice. Who benefits from this? Who is made safer? Which students are more supported and accepted and cared for as a result? NONE. Furthermore, this policy cowardly approaches the changes under the guise of empowering parents, which adds additional insult to its transparent bigotry. This parent would like to make it clear that I expect Virginia schools to honor their students -- which means honoring their choices around their identity.
>
> As a white, cisgender man, I don't check many "diversity" boxes. Which is why I want it to be clear and on the record that I wholeheartedly renounce this policy. I know and have known several trans people so far in my life, and one common theme in all of their threads is an incredible and painful struggle to come to the realization, despite societal and institutional pressure, that their identity is not what had been assigned at birth. I have known their joy as they have finally discovered and began living as their true selves. And I have seen the toll it has exacted on them and their families. Their story is one of bravery and resilience and an often painful journey of self-actualization.
>
> I stand with trans people, and I want trans and queer youth reading this to know that you are not alone. You deserve to be yourself as you define, and no matter how this administration might try to couch it in other language, we see right through it, too. "These are good days for bad people", but your living your full lives well -- as your true selves, on your own terms -- will be the best revenge on these backwards policies and those who seek to implement them. Glenn Youngkin and his administration may fail you, but you may yet still thrive. May this policy and his administration be consigned to the rubbish bin of history where they belong.  And may you shine on.

[^1]: I hope you will lend your voice to oppose this policy change.
[^2]: Yes, other databases do this. Yes, I could have used another database. I just chose SQL Server. And the docs were really helpful, quickly.
