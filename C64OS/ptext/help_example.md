# Introduction
<j:center>Introduction

App Launcher is one of two <t:emphatic>Homebase Applications<t:normal> built into C64 OS.

You can use it to customize desktops configured with color coded <l:aliases f:Aliases> to Applications, Utilities and regular C64 Software.

Each <l:desktop f:Desktops> can have a backdrop, a hint color, and up to 32 aliases.

Get started designing your own favorite desktops!

# 
# Desktops
<j:center>Desktops<j:left>
App Launcher supports up to 5 desktops. Each desktop can have a different backdrop, hint color and up to 32 aliases.

You can use different desktops to organize your aliases in whatever way
# Aliases
<j:center>Aliases<j:left>
An alias is a file that appears on the desktop in App Launcher, which can be used to open its corresponding C64 OS Application or Utility, or regular C64 software by means of a PRG alias and the PRG Runner Utility.
# Backdrops
<j:center>Backdrops<j:left>
These are low-resolution images that can be selected to appear behind the aliases on a desktop in App Launcher.

A backdrop is a SEQ file containing 1000 bytes of screencodes, no more no less. Backdrops can be created with the screenedit tool.
# Management
<j:center>File Manager<j:left>
One of two Homebase Applications in C64 OS. File Manager has 4 tabs allowing you to be in up to 4 places at once.

Files and subdirectories can be recursively scratched, or recursively copied and/or moved between any two directories, and partitions of any two devices.

File Manager can also be used to open documents in assigned Applications and Utilities.
# 
# PRG Runner
<j:center>PRG Runner<j:left>
There are a number of ways that a regular C64 program can be loaded and run, and several hardware configuration issues that can prevent a program from loading or running correctly.

A PRG alias is a small file containing metadata about a C64 program. PRG alias files can be opened with the PRG Runner Utility, which uses the metadata to test that the PRG can be loaded and run under the current hardware conditions.

It can also make some hardware changes, such as swapping device numbers or mounting disk images or swaplists. Then it loads the PRG file, does a controlled reboot and runs the program.
