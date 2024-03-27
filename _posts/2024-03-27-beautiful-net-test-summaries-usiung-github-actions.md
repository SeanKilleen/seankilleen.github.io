---
title: Beautiful .NET Test Reports Using GitHub Actions
comments: true
tags:
  - devops
  - ci
  - cd
  - github
  - githubactions
  - azuredevops
  - azdo
date: 2024-03-27 11:01 -0400
---
I know some folks who would like to move to GitHub Actions from Azure DevOps, but would really miss the "Test View" that Azure DevOps provides. Let's see if we can work some magic with GitHub Actions to get us close to that within GitHub.

## Goals

* Work entirely within GitHub Actions
* Show test results within a pull request
* Show difference in number of tests
* When tests fail, be able to quickly see which tests failed, and the failure/trace
* Understand test coverage

## Sample Project

I've created [a sample project that uses these techniques](https://github.com/SeanKilleen/ExampleTestResultsWithGithubActions) at <https://github.com/SeanKilleen/ExampleTestResultsWithGithubActions>. Feel free to submit a pull request to see it in action!

## Project Structure

For the sample, I created a basic project structure that you might find in the wild:

```console
ExampleTestResultsWithGithubActions.sln
src
  /Project1
  /Project2
test
  /Project1.Tests
  /Project2.Tests
```

## Creating the GitHub Action for our Build

I create a file at [`.github/workflows/build.yaml`](https://github.com/SeanKilleen/ExampleTestResultsWithGithubActions/blob/main/.github/workflows/build.yaml). You can view the [full file contents](https://github.com/SeanKilleen/ExampleTestResultsWithGithubActions/blob/main/.github/workflows/build.yaml) but I'll break down the relevant portions below.

## Enabling Permissions

Some of these steps need to write pull requests comments, etc. so in the job definition I include `permissions: write-all`. I probably could get away with less permissions, but for this example I'm living dangerously.

## Setup and Running our Tests

First, I check out the code and set up .NET:

```yaml
      - name: Check out the code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0        
      - name: Setup .NET
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: |
            8.x
```

Next, we run our tests:

```yaml
      - name: "Restore/Build/Test"
        run: dotnet test --configuration Release --verbosity normal --logger trx --collect:"XPlat Code Coverage"
```

A few things to note here:

* We're specifically logging to TRX files, which will make our reporting easier later
* `--collect: "XPlat Code Coverage"` is a signal to Coverlet for the type of output it's going to produce.
* The projects themselves have the NUnit packages installed but also the `Coverlet.Collector` NuGet package.

## Reporting Code Coverage

First, we combine our coverage reports. This is because each project has its own coverage output, so we need to combine them.

```yaml
      - name: Combine Coverage Reports # This is because one report is produced per project, and we want one result for all of them.
        uses: danielpalme/ReportGenerator-GitHub-Action@5.2.4
        with:
          reports: "**/*.cobertura.xml" # REQUIRED # The coverage reports that should be parsed (separated by semicolon). Globbing is supported.
          targetdir: "${{ github.workspace }}" # REQUIRED # The directory where the generated report should be saved.
          reporttypes: "Cobertura" # The output formats and scope (separated by semicolon) Values: Badges, Clover, Cobertura, CsvSummary, Html, Html_Dark, Html_Light, Html_BlueRed, HtmlChart, HtmlInline, HtmlInline_AzurePipelines, HtmlInline_AzurePipelines_Dark, HtmlInline_AzurePipelines_Light, HtmlSummary, JsonSummary, Latex, LatexSummary, lcov, MarkdownSummary, MarkdownSummaryGithub, MarkdownDeltaSummary, MHtml, PngChart, SonarQube, TeamCitySummary, TextSummary, TextDeltaSummary, Xml, XmlSummary
          verbosity: "Info" # The verbosity level of the log messages. Values: Verbose, Info, Warning, Error, Off
          title: "Code Coverage" # Optional title.
          tag: "${{ github.run_number }}_${{ github.run_id }}" # Optional tag or build version.
          customSettings: "" # Optional custom settings (separated by semicolon). See: https://github.com/danielpalme/ReportGenerator/wiki/Settings.
          toolpath: "reportgeneratortool" # Default directory for installing the dotnet tool.
```

I then choose to upload the combined coverage report to our build's artifacts:

```yaml
      - name: Upload Combined Coverage XML
        uses: actions/upload-artifact@v4
        with:
          name: coverage
          path: ${{ github.workspace }}/Cobertura.xml
          retention-days: 5
```

Next up, we publish the coverage report -- this takes the `Cobertura.xml` file and turns it into `code-coverage-results.md`, a nice Markdown file.

```yaml
      - name: Publish Code Coverage Report
        uses: irongut/CodeCoverageSummary@v1.3.0
        with:
          filename: "Cobertura.xml"
          badge: true
          fail_below_min: false # just informative for now
          format: markdown
          hide_branch_rate: false
          hide_complexity: false
          indicators: true
          output: both
          thresholds: "10 30"
```

A few things to note here:

* We can choose to fail the build if it falls below a minimum threshold. I set this to `false` since the purpose of this demo is just informative.
* We can set the thresholds for failure and warning. Here, they are 10% and 30% respectively.
* I set `indicators` to true to show markdown emoji indicators for easier visuals.

Lastly, I surface the code coverage statistics in a PR comment:

```yaml
      - name: Add Coverage PR Comment
        uses: marocchino/sticky-pull-request-comment@v2
        if: github.event_name == 'pull_request'
        with:
          recreate: true
          path: code-coverage-results.md
```

## Reporting on Test Outcomes

Coverage is one thing, but knowing whether our tests have passed or failed is the key. We don't just want to see a failed build, we want a test summary, and we want to be able to go directly to any failing tests.

I choose to upload the test results to my build's artifacts:

```yaml
      - name: Upload Test Result Files
        uses: actions/upload-artifact@v4
        with:
          name: test-results
          path: ${{ github.workspace }}/**/TestResults/**/*
          retention-days: 5
```

And then I use another great GitHub Action to publish those results:

```yaml
      - name: Publish Test Results
        uses: EnricoMi/publish-unit-test-result-action@v2.16.1
        if: always()
        with:
          trx_files: "${{ github.workspace }}/**/*.trx"
```

Note: 

* I specify the TRX files that we previously set our `dotnet test` to produce in our earlier action
* The `if: always()` ensures that this step will run even if prior steps fail. This is key, because if my tests fail, the build will fail, but I still want to produce this report so that I'll know _what_ failed.

## Let's See the Results!

In a PR where I add a test, I see the results and the coverage report:

TODO

When test coverage increases:

TODO

When test coverage decreases:

TODO

When a test fails, I see a notice:

TODO

And I can click into that notice to see the list of failed tests in the summary:

TODO

## Roll the Credits

I am continually amazed at what can be accomplished by GitHub Actions thanks to smart and talented people who have chosen to share with the community. A reminder that I didn't use a single custom piece of code in this example; it was all GitHub Actions provided by others. That blows my mind.

* [ReportGenerator-GitHub-Action](https://github.com/danielpalme/ReportGenerator-GitHub-Action) by [Daniel Palme](https://github.com/sponsors/danielpalme) allows us to combine our coverage reports into a lovely Cobertura report file.
* [CodeCoverageSummary](https://github.com/irongut/CodeCoverageSummary) by [irongut](https://github.com/sponsors/irongut) generates the great markdown from our coverage files
* [sticky-pull-request-comment](https://github.com/marocchino/sticky-pull-request-comment) by [GitHub user `@marocchino`](https://github.com/marocchino) allows us to hand-roll our own comment from Markdown
* The phenomenal [publish-unit-test-result-action](https://github.com/EnricoMi/publish-unit-test-result-action) by [Enrico Minack](https://github.com/sponsors/EnricoMi) puts our test results into an easily accessible format within GitHub.

All of these authors deserve our respect, appreciation, and sponsorship.

## I'd Love Your Thoughts!

How are you currently accomplishing this within GitHub Actions?

Until next time -- happy coding!
