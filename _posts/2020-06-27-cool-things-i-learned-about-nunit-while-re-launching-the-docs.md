---
title: Cool things I learned about NUnit while re-launching the docs
comments: true
tags:
  - nunit
  - testing
  - automation
date: 2020-06-27 08:14 -0400
---
Things I learned from looking at the NUnit documentation over the weekend (I am possibly helping them port their docs to docfx ) :

* There are [Combinatorial] and [Pairwise] operators for combinatorial testing
* There is a syntax for multiple asserts, so that a test will fail but give you more information Assert.Multiple(() => { // things to assert });
* There's an Assume.That syntax which works like an assertion but sets the test to Inconclusive instead of failed. So you can use it to assert things that need to be true for the test to make sense. While this is a bit of a smell, I can see it being potentially useful in integration tests.
* Similarly, there's a Warn.If syntax that is mentioned as being useful for integration tests that will tell you if something smelly might be happening.
* custom comparers for greater than, etc. e.g `Assert.That(myOwnObject, Is.GreaterThan(theExpected).Using(myComparer));`
