---
title: 'How to: Show Jasmine test results in TeamCity'
comments: true
tags:
  - jasmine
  - teamcity
  - tests
  - tests runners
  - ci
  - ''
date: '2020-02-04 12:28 -0500'
---
 Add the `jasmine-reporters` package: `npm -i jasmine-reporters --save-dev`

* Add an `index.js` to set up the tests if you haven't already:

```javascript

var Jasmine = require('jasmine'); 

var reporters = require('jasmine-reporters');

var jasmine = new Jasmine();

// Load configuration from a file or from an object. jasmine.loadConfig({
    "spec_dir": "spec",
    "spec_files": [
      "**/*\[sS]pec.js"     ],
    "helpers": [
      "helpers/**/*.js"     ],
    "stopSpecOnExpectationFailure": false,
    "random": true
  });

jasmine.execute();

```

* Prior to executing the steps, add the TeamCity reporter:

```javascript
var teamCityReporter = new reporters.TeamCityReporter();

jasmine.configureDefaultReporter(teamCityReporter);

```

* Update the "test" or "tests" command in your `package.json`:

```javascript

"tests": "node .path/to/specs/index.js"

```

* Prior to executing, add an additional NUnit XML Reporter:

```javascript

var nunitXmlReporter = new reporters.NUnitXmlReporter();

jasmine.addReporter(nunitXmlReporter);

```
