# Craig Bruce's C64/C128 keyboard scanner

This has Craig Bruce's "Three-key rollover" keyboard scanner from Hacking issue #6 from September 5, 1993.

The C128 source code was published as well as the C64/C128 binaries.  There was a note from Craig about differences in the C64 version.  I modified the C128 version to generate the same binary as the original C64 version, essentially re-sourcing the binary.  I'll probably contact Craig to ask for his original code but decided to spend a couple hours on this as an exercise.

Anyway, here is the C64 & C128 source that compiles with 64tass (TASS64) and creates the same binary as the original.

Checkout Craig's page about this issue: [https://csbruce.com/cbm/hacking/](https://csbruce.com/cbm/hacking/)

# Usage

You should read issue #6 for more information but to load the C64 version just run `keyscan64.boot` in the same directory as `keyscan64` and it should install it.

