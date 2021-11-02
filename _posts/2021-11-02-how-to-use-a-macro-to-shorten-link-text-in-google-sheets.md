---
title: How to use a macro to shorten link text in Google Sheets
comments: true
date: 2021-11-01 23:01 -0400
---
Google Sheets is a phenomenal tool for group collaboration, but occasionally I wish it could do a little bit more.

Lately, this came into play when I had 400+ links with their full URLs in a spreadsheet and they were messy looking. I figured it would be nicer to have a link called 

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

```

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

* Use at your own risk etc. etc.
* This 