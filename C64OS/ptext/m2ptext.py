#!/usr/bin/python3
"""This converts a MText binary file to a PText Markdown-ish file."""

import argparse
import sys

MTEXT_MIN = 0xE0
MTEXT_MAX = 0xF8


MTEXT = {
    # link text / path delimiter
    0x02: (str, " "),
    # link end/stop marker
    0x03: (str, ">"),
    0xE0: (str, "<c:black>"),
    0xE1: (str, "<c:white>"),
    0xE2: (str, "<c:red>"),
    0xE3: (str, "<c:cyan>"),
    0xE4: (str, "<c:purple>"),
    0xE5: (str, "<c:green>"),
    0xE6: (str, "<c:blue>"),
    0xE7: (str, "<c:yellow>"),
    0xE8: (str, "<c:orange>"),
    0xE9: (str, "<c:brown>"),
    0xEA: (str, "<c:light red>"),
    0xEB: (str, "<c:dark gray>"),
    0xEC: (str, "<c:medium gray>"),
    0xED: (str, "<c:light green>"),
    0xEE: (str, "<c:light blue>"),
    0xEF: (str, "<c:light gray>"),
    0xF0: (str, "<t:normal>"),
    0xF1: (str, "<t:strong>"),
    0xF2: (str, "<t:emphatic>"),
    0xF3: (str, "<l:"),
    0xF4: (str, "<j:left>"),
    0xF5: (str, "<j:right>"),
    0xF6: (str, "<j:center>"),
    0xF7: (str, "<j:full>"),
    # horizontal rule
    0xF8: (str, "<h:"),
}

# pet2ascii characters to remap
PET_REMAP = {0xA4: "_", 0x0D: chr(0x0A)}


def pet2ascii(petscii):
    """Convert PETSCII string to ASCII with some substitutions."""
    ascii_string = ""
    # based on the algorithm SD2IEC uses for FAT32 names.
    for char in petscii:
        if (128 + 64) < char < (128 + 91):
            char -= 128
        elif (96 - 32) < char < (123 - 32):
            char += 32
        elif (192 - 128) < char < (219 - 128):
            char += 128
        elif char == 255:
            char = "~"
        # remap some special characters
        if char in PET_REMAP:
            char = ord(PET_REMAP[char])
        ascii_string += chr(char)
    return ascii_string


def file_read(filename):
    """Read a file with some exception handling."""
    try:
        with open(filename, "rb") as inf:
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


def scan_codes(binary):
    """Scan petscii byte stream for MText codes."""
    content = ""

    # convert binary petscii to ascii
    data = pet2ascii(binary)

    for char in data:
        byte = ord(char)
        if (MTEXT_MIN <= byte <= MTEXT_MAX) or (1 < byte < 4):
            if byte in MTEXT:
                funct = MTEXT.get(byte)[0]
                param = MTEXT.get(byte)[1]
                content += funct(param)
        else:
            content += char

    return content


def render_all(block, arg_dict):
    """Lookup MText codes in the dictionary and return their plaintext version."""
    if block in arg_dict:
        return arg_dict.get(block).to_bytes(1, "little")
    return None


def main():
    """Simple script that reads a MText file and writes a PText to stdout or a file"""
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
        result = scan_codes(data)
        if args.output:
            file_write(args.output, result)
        else:
            print(result, file=sys.stdout)
    else:
        print("ERROR: data is zero length. Not writing anything.", file=sys.stderr)
        sys.exit(1)

    if args.output:
        print("Done!", file=sys.stderr)


if __name__ == "__main__":
    main()
