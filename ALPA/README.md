# BASIC source code for `ALPA`

## Intro

This directory has the source code, written in BASIC, for a Commodore 64 Assembly Language Programming Aid (ALPA) from a book.  This is from the book "Machine Language for the Absolute Beginner" written by Danny Davis.  It was published in 1984 by Melbourne House in Australia.

ALPA allows entering machine code in a text format like below:

```
10 A905
20 8D3412
```

In response to the above ALPA prints:
```
10 : A9 05       LDA #$05
20 : 8D 34 12    STA 41234
```

## Origin

I planned to type this in if necessary after purchasing a physical book on eBay.  I first checked online and after a bit of searching found a post on Lemon 64 by user Dark Programmer.

[Forum post link](https://www.lemon64.com/forum/viewtopic.php?t=63854)

The Internet Archive has a PDF copy of the book if you don't have a physical copy or to augment your physical copy.

[Machine Language for the Absolute Beginner](https://archive.org/details/Machine_Language_for_the_Absolute_Beginner_1984_Melbourne_House)

The version of ALPA on the linked D64 did not include the checksum utility (lines 60000+) and had several lines that did not match the checksum once I added it.  Still the vast majority of the program was already typed in and correct which saved me a lot of work.

The version in this repository is an exact match (per line checksum and total checksum) of the book and may have some bugs. I will post an updated version alongside this original version if I find some updates are needed.

This program loads/saves to cassette tape.  I will be working on a modified version that will use drive number 8. (and you can easily change that in the ALPA source)

## Usage

### Loading
Commodore 64:
```
LOAD"ALPA",8
RUN
```

ALPA will take a few seconds to start (saying `INITIALIZING` on the screen) and then ask you the start address. ALPA will ask `LOCATE PROGRAM AT ADDRESS : ?` and wait for your response.
A typical location would be `C000` (49152) above BASIC memory & the BASIC ROM.

This start address should have no leading `$` and consist of just 4 hex digits.  So `C000` as above, not `$C000` or decimal `49152` for example.

It will then show the address you entered and prompt you: `COMMAND OR LINE(####) : ?`
Here you can enter your program using BASIC style line numbers (as above) or issue a command.


## Entering Machine Code

You can enter your program using the format of: line #<space>HEX byte\[HEX Byte\]\[HEX Byte\]
Here's the example from above again, but now showing one, two or three bytes.

You can enter a line number alone to delete line, just like in BASIC

```
10 A905
15 EA
20 8D3412
```

In response to the above ALPA prints:
```
10 : A9 05       LDA #$05
15 : EA          NOP
20 : 8D 34 12    STA 41234
```

## ALPA Commands

ALPA supports various commands at the prompt for saving or running your program. Refer to the book starting on the bottom of page 27.

You only  need to enter the first two letters of for most commands below.  To list from a specific line number you must enter the whole command `LIST 20` not just `LI 20`.

Commands:
 - LIST or LIST line ###
   Lists the first 22 lines of your program or starting from the specified line number.
 - ENTER (the word 'ENTER' not the ENTER key)
   Stores your program in memory at the address specifed (C000 in the example above).
   Must be done before you can RUN your program.
 - RUN
   Executes your program starting at the enter address.  Must use the ENTER command first.
 - WATCH
   Asks for a memory address whose contents will be printed before and after your program runs.
 - NWATCH
   Turns off the WATCH feature
 - CHANGE
   Allows you to change the load / memory address of your program without restarting ALPA.
 - MEMORY
   Asks you the starting address to disassemble from memory.
 - DUMP
   Asks an address to produce a hex/ascii dump of memory.
 - LOAD
   Reads a saved ALPA program from cassette tape
 - SAVE
   Saves your currently entered program to cassette tape
 - NEW
   Clears the current ALPA program, load/memory address and any WATCH address.
 - QUIT
   Exits back to BASIC


## Type-In Checksum

The ALPA program has a builtin checksum utility that can be started by loading it and typing
`RUN 62000` instead of just `RUN`.

It will ask if you want to redirect to the printer and then generate a checksum for each line and then a total at the end.

The checksum of ALPA in this repository matches the book.

