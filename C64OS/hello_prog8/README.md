# C64 OS app in Prog8

Here is a minimal C64 OS app written in Prog8. It is based on the Hello World example
code written in assembler for Turbo Macro Pro.

The include directory has files created by parsing the official C64 OS headers and then
generating Prog8 const definitions and asmsub wrappers for much of the C64 OS API.
Only a few of the functions have been tested with a small program I am writing, so
feedback would be appreciated.

NOTE: Developing for C64 OS with Prog8 *requires* a custom build of the Prog8 compiler
to support the 'c64os' target.  It will not work with the official releases.
Check with me on C64 OS Discord.

## Building

A C64 OS app bundle has a file `main.o` that is the main program for the app. To generate
the needed file, run the command below.  This will generate `main.prg` which can be copied
to your C64 OS media as `main.o` in "applications/Hello Prog8" of your system folder.
Typically that would mean "os/applications/Hello Prog8/main.o" is where it ends up.

```bash
java -jar prog8compiler-custom.jar -srcdirs include/ -target c64os main.p8
```

## Developing with Prog8

I use VICE primarily and launch it with a d64 as device 8 and CMD HD as device 11.
On the modern computer side I run a script that runs the compiler and then builds a fresh
D64 each time.  I have `go.prg` that is a basic program that uses JiffyDOS commands to
copy the freshly compiled main.o to the right spot and launches C64 OS.

Creating the D64 image:
```bash
c1541 -format hello,52 d64 hello.d64
c1541 -attach hello.d64 -write main.prg main.o,p
c1541 -attach hello.d64 -write go.prg go,p
```

The 'go' program:
```basic
 10 rem debug / test cycle
 20 @#11
 30 @"cd//os/applications/Hello Prog8"
 40 @"s:main.o"
 50 @x11
 60 @#08
 70 *"main.o"prg
 80 @#11
 90 @"cd//"
 100 ^"//:c64os"
 ```

I then use a script to launch VICE with the new hello.d64 in device 8.
Running `go` (up arrow go in JiffyDOS) kicks it off.

