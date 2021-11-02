---
title: How to Use a Macro to Shorten Link Text in Google Sheets
comments: true
tags:
  - google drive
  - macro
  - automation
date: 2021-11-08 10:00 -0400
---
Google Sheets is a phenomenal tool for group collaboration, but occasionally I wish it could do a little bit more.

Recently, I had 400+ links with their full URLs in a spreadsheet -- and reader, they were messy looking. I figured it would be nicer to have a link text of "Link" that points to the URL, rather than the URL itself.

## How I did it

You'll repeat this process twice, one for each macro you want.

* Open the Google Sheet
* Click `Tools --> Macro --> Record Macro`:

![The dialog menu to record the macro]({{site.post-images}}/2021-google-sheet-macro/01_RecordMacro.png)

* Save the Macro with a Name and keyboard shortcut:

![The dialog to save a macro]({{site.post-images}}/2021-google-sheet-macro/02_SaveMacroWithShortcut.png)

* Click to edit the script:

![The notification that the script has been created, which allows edits]({{site.post-images}}/2021-google-sheet-macro/03_EditScript.png)

If you miss it, you can click the script editor from the menu:

![The script editor menu]({{site.post-images}}/2021-google-sheet-macro/03b_ScriptEditor.png)

* Replace the contents of that function with the contents of this function to shorten links:

```js
// Sets link text to "Link" in current cell
function ShortenHyperlinkText() {
  var spreadsheet = SpreadsheetApp.getActive();
  var currentText = spreadsheet.getCurrentCell().getRichTextValue().getText();
  
  spreadsheet.getCurrentCell().setRichTextValue(SpreadsheetApp.newRichTextValue()
  .setText('Link')
  .setLinkUrl(currentText)
  .build());
};
```

Or this function to expand links:

```js
// Sets link text to the full URL
function ElongateHyperlinkText() {
  var spreadsheet = SpreadsheetApp.getActive();
  var currentLinkText = spreadsheet.getCurrentCell().getRichTextValue().getLinkUrl();

  spreadsheet.getCurrentCell().setRichTextValue(SpreadsheetApp.newRichTextValue()
  .setText(currentLinkText)
  .build());
};
```

## Caveats

* Use at your own risk etc. etc. (luckily, if you change anything you don't want changed, you should be able to undo it.)
* This doesn't work on a range of highlighted cells. For this particular script, you have to highlight the cell with the link text and then run the macro.
* This assumes that when you run the shortener, you have a link. It also assumes that when you elongate a cell with a link, it actually has a link.

It's pretty rudimentary, but it helped me out in a pinch so I figured I'd share.
