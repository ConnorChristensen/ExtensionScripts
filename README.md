# ExtensionScripts

Some scripts, icons and other software stuff created to extend the functionality of the operating system and alter the looks.

## Demo

A demo of some of the code in action
![](images/pywall_demo.gif)

## Screenshots

The desktop without the dock
![](images/desktop.png)

## Interface

I did a few preference changes to the operating system to hide away most of the icons and buttons. This makes for a minimal setup that keeps away distracting information.

In the **General** tab of the System Preferences, I checked the boxes that

1. Uses the dark menu bar and Dock
1. Automatically hide and show the menu bar

![](images/settings/general.png)

In the **Dock** tab of the System Preferences, I checked the box near the bottom that says *Automatically hide and show the Dock*

![](images/settings/dock.png)


## Structure

This project contains several standalone things that you can install selectively if you like.

The folders are as such

* UI: Everything you can see in the demo video
	* dark-light: The code that controlls the environment dark/light color schemes
	* ubersicht: The files that load the clock and battery on the desktop using the app [ubersicht](http://tracesof.net/uebersicht/)
* hammerspoon: the configuration files for [hammerspoon](http://www.hammerspoon.org/) that allow for window placement through keyboard shortcuts 
* dateStampChanger.sh: A bash script for changing the created time on a file
* connor.vim: A relaxing blue vim color scheme
* connor.h: Some helpful C++ functions
* bash_profile: My bash profile that adds some cool shortcuts for terminal usage

## Author
Created by: Connor Christensen
