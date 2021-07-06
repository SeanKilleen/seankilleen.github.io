---
title: 'How to: Show Jasmine test results in TeamCity'

tags:
  - jasmine
  - teamcity
  - tests
  - tests runners
  - ci
date: '2020-02-13 14:00 -0500'
---
A colleague wanted to surface their jasmine tests in a TeamCity build system. Wanted to document the steps I used to help them solve their problem.

## Setting up the Jasmine Output

* Add the `jasmine-reporters` package: `npm -i jasmine-reporters --save-dev`
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

## Updating TeamCity

* Open the build in question
* From the Menu, add a build feature:

![TeamCity build menu showing the option to add a build feature]({{site.post-images}}/jasmine_tests_teamcity/AddBuildFeatureMenu.png)

* Select the "XML Report Processing" feature, choose an NUnit-style report, and point it to `nunitresults.xml` (the default location for the jasmine NUnit output):

![XML report processing options]({{site.post-images}}/jasmine_tests_teamcity/XMLReportProcessingFeature.png)

* Double-check the saved feature:

![The added build feature]({{site.post-images}}/jasmine_tests_teamcity/BuildFeatureResult.png)

## The Results

We see our tests listed in the build list:

![Tests in the build list]({{site.post-images}}/jasmine_tests_teamcity/TestsPassing.png)

And we see the test output in the overview tab:

![Tests in the overview page of the build]({{site.post-images}}/jasmine_tests_teamcity/TestsPassing_OnOverview.png)

And we see the a tests tab with the output of each individual test:

![Tests in the build's tests tab]({{site.post-images}}/jasmine_tests_teamcity/TestsTab.png)

Hope this helps! Happy testing!
