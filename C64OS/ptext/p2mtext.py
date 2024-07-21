#!/usr/bin/python3
"""
This program reads 'PText' (Markdown-ish plaintext) with additional text formatting codes.
It then generates C64 OS 'MText' file with single byte binary representations of the codes.
For example:
    <c:black> (switch text to black)
    <j:right> (right justify/align text)
    <t:strong> (strong emphasis on text, bold)

Shortest unique match up to the full word is supported so these are all the same:
    <j:r>
    <j:ri>
    <j:rig>
    <j:righ>
    <j:right>
    ... etc ...
"""

import argparse
import os
import re
import sys

# with '/' or ':' allowed in link
CODES_REGEX = r"<(.)\:(\w+)?(\s?([/:\.]?)\w?)+\>"

# For the paramater portion of a link.
LINK_REGEX = r"([\w\s]+)\s(..):(.*)"

COLORS = {
    "black": 0xE0,
    "white": 0xE1,
    "red": 0xE2,
    "cyan": 0xE3,
    "purple": 0xE4,
    "green": 0xE5,
    "blue": 0xE6,
    "yellow": 0xE7,
    "orange": 0xE8,
    "brown": 0xE9,
    "lred": 0xEA,
    "light red": 0xEA,
    "dgray": 0xEB,
    "dark gray": 0xEB,
    "dgrey": 0xEB,
    "dark grey": 0xEB,
    "mgray": 0xEC,
    "medium gray": 0xEC,
    "mgrey": 0xEC,
    "medium grey": 0xEC,
    "lgreen": 0xED,
    "light green": 0xED,
    "lblue": 0xEE,
    "light blue": 0xEE,
    "lgray": 0xEF,
    "light gray": 0xEF,
    "lgrey": 0xEF,
    "light grey": 0xEF,
}
HRULE = {
    "": 0xF8,
}
ALIGN = {
    "left": 0xF4,
    "right": 0xF5,
    "center": 0xF6,
    "full": 0xF7,
}
TEXT = {
    "normal": 0xF0,
    "strong": 0xF1,
    "emphatic": 0xF2,
}

# Link components
LINK_CODE = b"\xF3"
LINK_PATH = b"\x02"
LINK_STOP = b"\x03"

# pet <-> ascii characters to remap
ASC_REMAP = {"_": 0xA4, chr(0x0A): 0x0D}


def ascii2pet(ascii, binary=False):
    """Convert ASCII string to PETSCII with some substitutions."""
    petscii_bytes = bytes()
    # based on the algorithm SD2IEC uses for FAT32 names.
    for char in ascii:
        if not binary:
            char = ord(char)
        if 64 < char < 91:
            char += 128
        elif 96 < char < 123:
            char -= 32
        elif 192 < char < 219:
            char -= 128
        elif char == "~":
            char = 255
        # remap some special characters
        if chr(char) in ASC_REMAP:
            char = ASC_REMAP[chr(char)]
        petscii_bytes += char.to_bytes(1, "little")
    return petscii_bytes


def build_lookup(lookup_dict):
    """create a lookup table of unique substrings"""
    lookup_table = {}
    unique = False
    for key in lookup_dict.keys():
        # Look at substrings until one short of whole word
        for length in range(len(key)):
            substring = key[0:length]
            for otherkey in lookup_dict.keys():
                if key == otherkey:
                    continue
                if otherkey.startswith(substring):
                    # not unique break this inner loop
                    unique = False
                    break
                unique = True
            if unique:
                lookup_table.update({substring: key})
                # keep going to find all valid substrings from the
                # first unique (aka don't break here)
    return lookup_table


def file_read(filename):
    """Read a file with some exception handling."""
    try:
        with open(filename, "r") as inf:
            return inf.read()
    except (FileNotFoundError, PermissionError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return b""


def file_write(filename, data):
    """
    Write data to a file in binary or text mode depending on the type.
    We do not join() with extra linefeeds, we expect the content to be
    ready to go.
    """
    flag = "w"
    encoding = "utf-8"

    if isinstance(data, bytes):
        flag += "b"
        encoding = None

    if isinstance(data, list):
        data = "".join(data)

    print(f"Writing file...{filename} ({len(data)} bytes)", file=sys.stderr)

    try:
        with open(filename, flag, encoding=encoding) as outf:
            outf.write(data)
        return True
    except (FileNotFoundError, PermissionError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return None


def parse_codes(text):
    """Parse a single line of text for formatting codes."""
    encoded = text.encode("utf-8")
    for match in re.finditer(CODES_REGEX, text):
        if match:
            code = match.group(0)
            tag = match.group(1).lower()
            # Don't lower() the param here or we mess up links
            # Do it in the parse_all routine.
            param = match.group(0)[3:-1]

            if tag in CODES:
                result = CODES[tag][0](param, CODES[tag][1], CODES[tag][2])
                if result is not None:
                    encoded = encoded.replace(code.encode("utf-8"), result)
                else:
                    print(f"WARN: Unhandled tag:parameter: {tag}:{param}")
            else:
                print(f"WARN: parse_codes unhandled tag: {tag}")
    # return text encoded as it now has unprintable formatting bytes
    return encoded


def parse_all(block, arg_dict, lookup_dict):
    """
    Parse the values (right side of ':') of the codes.
    Use a lookup table to allow shortest unique matches.
    So color brown can be <c:br> or <c:bro> up to <c:brown>
    """
    block = block.lower()
    if block in lookup_dict:
        block = lookup_dict.get(block)
    if block in arg_dict:
        return arg_dict.get(block).to_bytes(1, "little")
    return None


def parse_link(block, links, lookup_dict):
    """
    Parse link codes.
    The following link prints the text 'word' and generates
    a link to 'File':
        <l:word fn:File>

    This becomes: <LINK_CODE>word<LINK_PATH>fn:File<LINK_STOP>

    This function processes the 'parameter' portion of the link.
    That is without the '<l:' on the left and the '>' on the right.
    In the example above that would be: "word fn:File"

    The link parameter is parsed with regex into three components.
    link_text -- What will be shown and is everything left of the ':'
                 without the trailing whitespace.

    link_type -- The link type like 'f' for file.

    link_dest -- The destination of the link. For example a filename.

    It should really support:
        <LINK_CODE>Multiple words here<LINK_PATH>fn:File with space<LINK_STOP>
    """

    # Don't bother to check these.
    if len(block) == 0:
        return b""

    match = re.match(LINK_REGEX, block)

    # Didn't find a valid link.
    if not match:
        print(f"WARN: Invalid link: {block}")
        return b""

    link_text = match.group(1)
    link_type = match.group(2)
    link_dest = match.group(3)
    link_ref = link_type + ":" + link_dest

    # build link as bytes
    link = LINK_CODE
    link += link_text.encode("utf-8")
    link += LINK_PATH
    link += link_ref.encode("utf-8")
    link += LINK_STOP

    print(f"DEBUG: link: {link}")
    return link


# The key is the code.
# The value is (parsing_function,  lookup_table, substring_lookup_table)
CODES = {
    "c": (parse_all, COLORS, build_lookup(COLORS)),
    "h": (parse_all, HRULE, {}),
    "j": (parse_all, ALIGN, build_lookup(ALIGN)),
    "l": (parse_link, "link", {}),
    "t": (parse_all, TEXT, build_lookup(TEXT)),
}


def main():
    """
    This program reads 'PText' (Markdown-ish plaintext) from the input file.
    The PText is scanned for formatting codes and converted to MText binary codes.
    The results are written to stdout or a file. It is binary so you should pipe
    it through hexdump or similar.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument("input", help="input file")
    parser.add_argument("-o", "--output", help="output file")
    args = parser.parse_args()
    if not args.input:
        print("Input file required.", file=sys.stderr)
        sys.exit(1)

    # We read the input file, scan it, write the output file.
    # Only basic error checking.
    if args.output:
        print(f"Reading from file: {args.input}", file=sys.stderr)
    data = file_read(args.input)
    if len(data) > 0:
        # result = parse_text(data.splitlines())
        raw = bytes()
        for line in data.splitlines():
            # returns bytes.
            result = parse_codes(line)
            # add a linefeed on the end of each line.
            raw += result + b"\x0A"

        if args.output:
            file_write(args.output, ascii2pet(raw, binary=True))
        else:
            with os.fdopen(sys.stdout.fileno(), "wb", closefd=False) as stdout:
                stdout.write(ascii2pet(raw, binary=True))
                stdout.flush()

    else:
        print("ERROR: data is zero length. Not writing anything.", file=sys.stderr)
        sys.exit(1)

    if args.output:
        print("Done!", file=sys.stderr)


if __name__ == "__main__":
    main()
