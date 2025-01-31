# C64 OS support for Prog8

## Prog8 system libraries

Currently just `syslib.p8`

This provides a minimal library to support building C64 OS binaries with Prog8.  It includes things like code to initialize the system as well as the CX16 virtual register support.  

## "Includes" files

Currently just `os.p8`

These were generated from [the official OpCoders, Inc release]
(https://github.com/OpCoders-Inc/c64os-dev) of SDK / headers.

This is not a copy, but probably qualifies as 'substantial portions'
even though it is just definitions not actually code.
