---
title: How to Disable GitHub Actions in a Forked Project
comments: true
tags:
  - github
  - github actions
  - automation
  - tips
date: 2021-11-05 10:00 -0400

header:
  overlay_image: /images/overlays/unsplash/richy-great-MAYEkmn7G6E-unsplash2.jpg
  overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
  caption: "Photo credit: [**Richy Great @ Unsplash**](https://unsplash.com/@richygreat?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)"

---
Some GitHub repositories have [GitHub Actions](https://github.com/features/actions) with helpful automation. Because actions are stored in the `.github` folder within a codebase, they come over along with any forks that are created. In many cases, this could be really helpful, as you get a great level of automation out of the box.

However, when you fork the project in order to contribute back or for your own purposes, you don't necessarily want those actions to run in _your_ repository (such as attempting to publish releases).

## To Turn Off GitHub Actions for a Forked Repository

* Open the repository.
* Click `Settings`.
* In the left-hand navigation menu, click `Actions`.

You can then set your preferences to disable actions in the repository, or to only allow certain actions.

Happy 'hubbing!
