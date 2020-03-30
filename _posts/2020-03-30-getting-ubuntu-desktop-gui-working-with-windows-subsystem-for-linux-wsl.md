---
title: Getting Ubuntu Desktop GUI working with Windows Subsystem for Linux (WSL)
comments: true
tags:
  - wsl
  - ubuntu
  - gui
date: '2020-03-30 15:41 -0400'
---
Had a really fun time getting the UI configured for Ubuntu's GUI within my WSL Ubuntu distro, so I figured I'd post it here. I'm spoiled by GUIs and while I know my way around a command line, it's nice to have both available.

## Pre-requisites

We won't discuss how to obtain these things here, but feel free to comment if you get stuck.

* Windows 10
* Windows Subsystem for Linux (WSL)
* An Ubuntu WSL Distribution from the Windows Store
* Chocolatey installed on your Windows machine
* A chunk of free disk space (~2 GBish to dedicate to the effort on top of your normal needs)

## Let's Do this!

Open the Ubuntu WSL instance and login if needed.

* Run `sudo apt-get update`
* Run `sudo apt-get upgrade`

While you're waiting on that, switch back to Windows.

* Open an admin powershell window
* Run `choco install vcxsrv`
* When that completes, look for `XLaunch` in your start menu and run it.
* Set up XLaunch as you'd like. I chose to do full-screen, and then moved the XLaunch window to a virtual desktop once it appears -- best of all worlds!

Return to your WSL Instance

* Run `export DISPLAY=localhost:0.0` to set the display
* If you want this done every time you start up, also run `echo "export DISPLAY=localhost:0.0" >> ~/.bashrc`
* Run `sudo apt install ubuntu-desktop` to install the goodies
* Run `sudo apt install gedit` to install the common GUI-based text editor
* Run `sudo apt install yad` to allow the creation of graphical dialogs from shell scripts