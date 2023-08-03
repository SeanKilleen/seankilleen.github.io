---
title: How To Specify Pairs of Items in GitHub Actions Matrix Strategies
comments: true
tags:
  - github
  - github-actions
  - devops
  - cicd
date: 2023-08-03 09:03 -0400
---
Came across this and wasn't aware of it (though it makes total sense in retrospect), so I figured I'd pass the tip along.

## Background: What is a Matrix Strategy in GitHub Actions?

Sometimes you need an GitHub Action Job to run for multiple combinations of items. In my case, I was looking to run an action to publish a Docker container across a combination of Ruby, Node, and GitHub Pages versions.

Running an action in this way will create an instance of that job for every combination in the matrix entries:

```yaml
jobs:
  build_release:
    name: "Build and Release"
    strategy:
      matrix:
        RUBY_VERSION: [2.7.3]
        NODE_MAJOR_VERSION: [16, 18]
        GITHUB_PAGES_VERSION: [226]
    runs-on: ubuntu-latest
    env:
{% raw %}
      RUBY_VERSION: ${{ matrix.RUBY_VERSION }}
      NODE_MAJOR_VERSION: ${{ matrix.NODE_MAJOR_VERSION }}
      GITHUB_PAGES_VERSION: ${{ matrix.GITHUB_PAGES_VERSION }}
{% endraw %}
```

## ...But do we really want every combination?

In my case, I wanted to introduce Ruby 2.7.4 and GitHub Pages 228. But if I had added those entries to the matrix strategy I was using, it would generate a combination of Ruby 2.7.3 and 228, which would be incorrect (GitHub Pages 228 requires Ruby 2.7.4)

## Solution: Using Objects Within the Matrix

It turns out you're able to pair things as needed in the matrix strategy by using an object within the array. My modified code:

```yaml
jobs:
  build_release:
    name: "Build and Release"
    strategy:
      matrix:
        VERSIONS: [ {ruby: 2.7.3, ghpages: 226}, {ruby: 2.7.4, ghpages: 228}]
        NODE_MAJOR_VERSION: [16,18,20]
    runs-on: ubuntu-latest
    env:
{% raw %}
      RUBY_VERSION: ${{ matrix.VERSIONS.ruby }}
      NODE_MAJOR_VERSION: ${{ matrix.NODE_MAJOR_VERSION }}
      GITHUB_PAGES_VERSION: ${{ matrix.VERSIONS.ghpages }}
{% endraw %}
```

Now, I'll still get a build for each node version I specified (16, 18, and 20) and I'll get those in combination with Ruby 2.7.3 / GH Pages 226 and Ruby 2.7.4 / GH Pages 228.
