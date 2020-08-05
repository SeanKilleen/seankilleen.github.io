---
 
title: 'How to: Ensure LESS works with ASP.NET MVC and Continuous Integration [Field
  Notes]'
date: 2012-09-10 18:00:00.000000000 -04:00
comments: true

---
### Problem:

* I use LESS instead of CSS in my ASP.NET MVC app.
* I would like it to actually work.

### Solution

There are two steps (that I know of) to fixing this problem. The first is to make sure that your build package will actually output the LESS files in the first place; the second is to ensure that IIS can serve them.

#### Step 1: Ensuring that the Build Package outputs LESS files

* In your solution, highlight all your LESS files
* Right-click and select properties or look in the properties window.
* Set the `Build Action` property to `Content`. This will ensure that the raw content is outputted from those files during build instead of another build action.
* Set the `Copy to Output Directory` property to `Copy Always`. This ensures that your LESS files will actually make it into the package folder that MSBuild outputs.

#### Step 2: Ensuring that IIS can serve LESS files

* See the instructions in my post titled [When using Twitter Bootstrap LESS with IIS, don't forget to create the MIME Type]({% post_url 2012-09-10-when-using-twitter-bootstrap-less-with-iis-dont-forget-to-create-the-mime-type-field-notes %})
