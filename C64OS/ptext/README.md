# PText <-> MText conversion

NOTE: I'm referring to my plaintext representation of MText as 'PText', but it my term, not officially related to C64 OS.  Don't bug OpCoders about PText.

These Python scripts convert between the C64 OS Help files in [MText format](https://www.c64os.com/post/textrendering). [More MText info](https://www.c64os.com/post/conversionservices)

There are two main scripts; `ptext2mtext.py` and `mtext2ptext.py`.

To generate MText you need a Markdown-esque plaintext file (or PText) with some control statements/codes.

Here is a sample.md file:
```
# Introduction
<j:center>Introduction

This section ends up in a file called Introduction

This is <t:strong>strong<t:normal> formatted text.
This text has a <l:link f:Links> to a file called Links.

<c:red>This text is red<c:black>

#
# Links
This second section would go into another file called Links.
```

## ptext2mtext.py
You would generate MText formatted help files by running the script like this:
```bash
$ python3 ptext2mtext.py --input sample.md --output help
```

In this case `sample.md` is a plaintext file written as PText.  The output `help` is a directory and will be created if it doesn't exist.

The above sample should result in the following files in the help directory:
```
Introduction
Links
toc.t
```

The `toc.t` file is build from the sections (Markdown headers denoted with '#') and bare sections leave a blank line.

So `toc.t` contents will be:
```
Introduction

Links
```

Note the blank line due to the '#' on a line by itself above '# Links' in the sample.

## mtext2ptext.py
You can convert existing or freshly created MText back to PText by running `mtext2ptext.py` and providing the MText directory (`help` in the above example) as the input and a filename as the output.

```bash
$ python mtext2ptext.py --input help --output converted.md
```

The resulting `converted.md` should match the original `sample.md` at this point as the rendering is reversible.

## Codes

| Code            | Meaning     | Code            | Meaning              |
|-----------------|-------------|-----------------|----------------------|
| <c:black>       | Black       | <t:normal>      | Normal Text          |
| <c:white>       | White       | <t:strong>      | Strong Text          |
| <c:red>         | Red         | <t:emphatic>    | Emphatic Text        |
| <c:cyan>        | Cyan        | <l:text f:File> | Link Text            |
| <c:purple>      | Purple      | <j:left>        | Left Justification   |
| <c:green        | Green       | <j:right>       | Right Justification  |
| <c:blue>        | Blue        | <j:center>      | Center Justification |
| <c:yellow>      | Yellow      | <j:full>        | Full Justification   |
| <c:orange>      | Orange      | <h:>            | Horizontal Rule      |
| <c:brown        | Brown       | \$F9            | *reserved*           |
| <c:light red>   | Light Red   | \$FA            | *reserved*           |
| <c:dark grey>   | Dark Grey   | \$FB            | *reserved*           |
| <c:medium grey> | Medium Grey | \$FC            | *reserved*           |
| <c:light green> | Light Green | \$FD            | *reserved*           |
| <c:light blue>  | Light Blue  | \$FE            | *reserved*           |
| <c:light grey>  | Light Grey  | \$FF            | *reserved*           |


You can use 'gray' spelling as well as 'grey' and you can use the first letter of the first word and no space.  So 'lred' for 'light red'.  Also you can use the shortest unique code and longer, up to the full code of course.

So `<t:n>` is the same as `<t:normal>`, but `<c:bl>` is not valid as we can't differentiate blue/black.  And since both spellings of gray are supported 'light gre' is not unique. 