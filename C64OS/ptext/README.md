# PText <-> MText conversion

NOTE: I'm referring to my plaintext representation of MText as 'PText', but it my term, not officially related to C64 OS.  Don't bug OpCoders about PText.

These Python scripts convert between the C64 OS Help files in [MText format](https://www.c64os.com/post/textrendering). [More MText info](https://www.c64os.com/post/conversionservices)

## Converting one file at a time.
When converting individual files in PText or MText format to individual files of the opposite format, you use the following Python scripts:

`p2mtext.py` -- Converts one PText file to MText, either writing to stdout or to a single file specified with the `-o filename` option. Since MText is a binary format you need to redirect to a file or pipe to something like `hexdump`:
```bash
$ python3 p2mtext.py sample.md | hexdump -vC
```

`m2ptext.py` -- Converts one MText file to PText, either writing to stdout or to a single file specified with the `-o filename` option. To just dump an MText ("Introduction" in this example) to your terminal you would run:
```bash
$ python3 m2ptext.py Introduction
```

When converting a single file to MText you need a plaintext file (or PText) with some control statements/codes.  Below is a basic example showing some codes in use.
```
<j:center>Introduction

This content gets converted to petscii and the control codes are converted to single byte binary codes. (aka MText)

This is <t:strong>strong<t:normal> formatted text.
This text has a <l:link f:Links> to a file called Links.

<c:red>This text is red<c:black>
```

## Converting to/from C64 OS MText Help format
When converting C64 OS Help source file in PText to a "help" directory of MText files including a table of contents, you use the two scripts below.  Of course you can convert one file at a time using the scripts mentioned above as well and generate the `toc.t` file manually.  These scripts are more useful if you want to add it as part of your Makefile or build environment.  You can easily edit a single plaintext file in pseudo Markdown using a normal text editor and have one single file will all of your C64 OS Help content.

### Converting a PText file to a MText help directory

`ptext2mtext_help.py` -- Converts one PText file to a "help" directory of MText files including a table of contents.  You specify the PText input filename and the output *directory* as each topic (delimited by Markdown header '#' symbols) will create a separate file in the output directory. The filename and directory name can be called whatever you want, but in the example below I'm using `help.md` as the PText source and the resulting C64 OS Help MText files will be written into the `help` directory.

Example help.md file:
```markdown
# Topic1
<j:center>This is topic one.
This is <t:emphatic>empahitic (italics when supported)<t:normal> formatted text.
This text has a <l:link f:Topic2> to Topic2 which is in another file.


#
# Topic2
<t:strong>Topic two has bold text!<t:normal>
```
```bash
$ python3 ptext2mtext_help.py --input help.md --output help
```

Once this is run you will have three files in the help directory; `toc.t`, `Topic1`, and `Topic2`.

The contents of `toc.t` should be:
```
Topic1

Topic2
```

The blank line between the two topics is from the bare '#' character in the sample file.  It provides a way to have an empty space in the C64 OS Help table of contents view.

### Converting a MText help directory to a PText file

`mtext_help2ptext.py` -- Converts a C64 OS Help directory of MText files, and a table of contents, to a single PText Markdown-esque file in plaintext.  You specifiy the input *directory* and the output *file* for this direction.  The script looks in the input directory ('help' from the example above) and reads the `toc.t` file.  Since in C64 OS Help directories each topic listed in the table of contents corresponds to a file of the same name, the script can find all the components to convert.  In the example below we convert the MText output generated above back to the original PText format.

```bash
$ python3 mtext_help2ptext.py --input help --output help2.md
```

Note I called the output file `help2.md` here because the original source file in the earlier example is `help.md` and you don't want to overwrite it.  Now you can compare `help.md` and `help2.md` and see how the conversion from PText -> MText -> PText went!  The resulting `help2.md` should match the original `help.md` at this point as the rendering is reversible.

Please report any issues. Here or on Discord is fine.

## Codes
The supported formatting codes are listed in the table below.


| Code            | Meaning     | Code             | Meaning              |
|-----------------|-------------|------------------|----------------------|
| <c:black>       | Black       | <t:normal>       | Normal Text          |
| <c:white>       | White       | <t:strong>       | Strong Text          |
| <c:red>         | Red         | <t:emphatic>     | Emphatic Text        |
| <c:cyan>        | Cyan        | <l:text fn:File> | Link Text            |
| <c:purple>      | Purple      | <j:left>         | Left Justification   |
| <c:green        | Green       | <j:right>        | Right Justification  |
| <c:blue>        | Blue        | <j:center>       | Center Justification |
| <c:yellow>      | Yellow      | <j:full>         | Full Justification   |
| <c:orange>      | Orange      | <h:>             | Horizontal Rule      |
| <c:brown        | Brown       | \$F9             | *reserved*           |
| <c:light red>   | Light Red   | \$FA             | *reserved*           |
| <c:dark grey>   | Dark Grey   | \$FB             | *reserved*           |
| <c:medium grey> | Medium Grey | \$FC             | *reserved*           |
| <c:light green> | Light Green | \$FD             | *reserved*           |
| <c:light blue>  | Light Blue  | \$FE             | *reserved*           |
| <c:light grey>  | Light Grey  | \$FF             | *reserved*           |


The link type, `fn` in the table above, can be 1-3 digits.
The link type field is identified by a space followed by 1-3 digits and a colon character.
The link text, which is after `l:` but before the link type field, can be multiple words but should not start with whitespace.
For any of the tags, not just link, there should not be a space immediately after any colon.

You can use 'gray' spelling as well as 'grey' and you can use the first letter of the first word and no space.  So 'lred' for 'light red'.  Also you can use the shortest unique code and longer, up to the full code of course.

So `<t:n>` is the same as `<t:normal>`, but `<c:bl>` is not valid as we can't differentiate blue/black.  And since both spellings of gray are supported 'light gre' is not unique. 
