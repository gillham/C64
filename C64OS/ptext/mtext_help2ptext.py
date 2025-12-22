#!/usr/bin/python3
"""This converts MText binary files to PText Markdown-ish files."""

import argparse
import os
import re
import sys

MTEXT_MIN = 0xE0
MTEXT_MAX = 0xF8


def emit_color(color):
    return f'<span style="color:{color}">'


# causes a line break.
# END_DIV = "</div>"
END_DIV = ""

# maybe not needed.
# END_SPAN = "</span>"
END_SPAN = ""
# this does work to generate red...
#    0xE0: (str, r"$\textcolor{red}{\textsf{Color didint work .}}$ black"),

MTEXT = {
    # link text / path delimiter
    0x02: (str, " ", ""),
    # link end/stop marker
    0x03: (str, ">", ""),
    0xE0: (str, "<c:black>", ""),
    0xE1: (str, "<c:white>", ""),
    0xE2: (str, "<c:red>", ""),
    0xE3: (str, "<c:cyan>", ""),
    0xE4: (str, "<c:purple>", ""),
    0xE5: (str, "<c:green>", ""),
    0xE6: (str, "<c:blue>", ""),
    0xE7: (str, "<c:yellow>", ""),
    0xE8: (str, "<c:orange>", ""),
    0xE9: (str, "<c:brown>", ""),
    0xEA: (str, "<c:light red>", ""),
    0xEB: (str, "<c:dark gray>", ""),
    0xEC: (str, "<c:medium gray>", ""),
    0xED: (str, "<c:light green>", ""),
    0xEE: (str, "<c:light blue>", ""),
    0xEF: (str, "<c:light gray>", ""),
    0xF0: (str, "<t:normal>", ""),
    0xF1: (str, "<t:strong>", ""),
    0xF2: (str, "<t:emphatic>", ""),
    0xF3: (str, "<l:", ""),
    0xF4: (str, "<j:left>", ""),
    0xF5: (str, "<j:right>", ""),
    0xF6: (str, "<j:center>", ""),
    0xF7: (str, "<j:full>", ""),
    # horizontal rule
    0xF8: (str, "<h:", ""),
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
    print(f"Reading file...{filename}")
    try:
        with open(filename, "rb") as inf:
            return inf.read()
    except Exception as error:
        print(f"ERROR: {error}")
        return None


def file_write(filename, data):
    """
    Write data to a file in binary or text mode depending on the type.
    We do not join() with extra linefeeds, we expect the content to be
    ready to go.
    """
    print(f"Writing file...{filename}")
    try:
        if isinstance(data, bytes):
            with open(filename, "wb") as outf:
                outf.write(data)
            return True
        if isinstance(data, list):
            with open(filename, "w") as outf:
                outf.write("".join(data))
            return True
        print(f"ERROR: Cannot file_write:{type(data)}")
        return None
    except Exception as error:
        print(f"ERROR: {error}")
        return None


def scan_codes(binary):
    content = ""
    end_stack = []

    # convert binary petscii to ascii
    data = pet2ascii(binary)

    for char in data:
        byte = ord(char)
        if (MTEXT_MIN <= byte <= MTEXT_MAX) or (1 < byte < 4):
            if byte in MTEXT:
                # pop any end code for previous tag
                if len(end_stack) > 0:
                    content += end_stack.pop()
                funct = MTEXT.get(byte)[0]
                param = MTEXT.get(byte)[1]
                endmark = MTEXT.get(byte)[2]
                content += funct(param)
                # push end mark for this tag/code onto stack
                end_stack.append(endmark)
        else:
            content += char

    return content


def render_all(block, arg_dict):
    if block in arg_dict:
        return arg_dict.get(block).to_bytes(1, "little")
    return None


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", help="input *directory*")
    parser.add_argument("--output", help="output file")
    args = parser.parse_args()
    if args.input:
        inputdir = args.input
        if not inputdir.endswith(os.path.sep):
            inputdir += os.path.sep
    else:
        print("Input directory required.")
        sys.exit(1)

    if args.output:
        output = args.output
    else:
        print("Output filename required.")
        sys.exit(1)

    print(f"Will read files from directory: {inputdir}")
    print(f"Will write to file: {output}")

    # We will add each line of output to this list as we generate it.
    # It will be written to output once we are done.
    output_data = []

    toc = file_read(inputdir + "toc.t")
    toc_list = []
    for line in toc.splitlines():
        toc_list.append(pet2ascii(line))

    for file in toc_list:
        # should we ignore blank lines.
        if len(file) > 0:
            output_data.append(f"# {file}\n")
            if not os.path.exists(inputdir + file):
                continue
            data = file_read(inputdir + file)
            if len(data) > 0:
                result = scan_codes(data)
                output_data.append(result)
        else:
            output_data.append("# \n")

    file_write(output, output_data)

    print(f"Done!")


if __name__ == "__main__":
    main()
