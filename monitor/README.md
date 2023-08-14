# C64 Machine Language Monitor

THIS IS A WORK IN PROGRESS.  Be kind.

See (https://www.c64os.com/c64os/softwareupdates/) for a short summary on available commands put together by Greg @ OpCoders, Inc.  Thanks to Greg for bringing this tool to my attention.

Original file:
(ftp://c64.rulez.org/pub/c64/Tools/Assembler/Monitor_C000.prg)
The author is unknown.
If you have any information about the origins of this software please contact me.
This software does not identify itself, make any copyright claim or have anything embedded in it that is recognizable.
It seems there was a lot of source code sharing with monitor work in the late 70s / early 80s and without an other identification of this tool, I'm assuming it is in the public domain.  If you know otherwise, again please contact me.

This source code was created by using the excellent [JC64dis](https://iceteam.itch.io/jc64dis) by Ice Team. Note that I am far from done with the disassembly and my labels / comments reflect my lack of expertise and the overall process of learning about this code.  Nevertheless I was able to get far enough to make a small extension to test out that capability somewhat.

If you have any assistance to offer with the disassembly let me know.  Especially the area around the opcodes currently confuses me and I'll be looking at other tools (like supermon64) and source code to get some ideas.


## USAGE

Copy Monitor_C000.prg to a C64 storage device as "MONITORC" for this example.

```
LOAD"MONITORC",8,1
SYS 49152
```

## Extensions

To use an extension load it into memory along with the monitor.  The monitor or extension can be loaded in any order but both need to be loaded prior to `SYS 49152` to use the extension.

Copy `monext.prg` to a C64 storage device as `MONEXT` for this example. The `MONEXT` and `MONITORC` files should be in the same location.

```
LOAD"MONITORC",8,1
LOAD"MONEXT",8,1
SYS 49152
```

### Extension usage
For this example extension you can do two commands as outlined below.

I for inspect shows memory as characters with no hex like the memory command.
```
.I A000 A1FF
```

@ for disk command currently just gets the current drive's status from the command channel.
```
.@
```

