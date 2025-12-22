#!/usr/bin/python3

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
    0x02: (str, "{link_path}", ""),
    0x03: (str, "{link_stop}", ""),
    0xE0: (emit_color, "black", END_SPAN),
    0xE1: (emit_color, "white", END_SPAN),
    0xE2: (emit_color, "red", END_SPAN),
    0xE3: (emit_color, "cyan", END_SPAN),
    0xE4: (emit_color, "purple", END_SPAN),
    0xE5: (emit_color, "green", END_SPAN),
    0xE6: (emit_color, "blue", END_SPAN),
    0xE7: (emit_color, "yellow", END_SPAN),
    0xE8: (emit_color, "orange", END_SPAN),
    0xE9: (emit_color, "brown", END_SPAN),
    0xEA: (emit_color, "lightred", END_SPAN),
    0xEB: (emit_color, "darkgray", END_SPAN),
    0xEC: (emit_color, "mediumgray", END_SPAN),
    0xED: (emit_color, "lightgreen", END_SPAN),
    0xEE: (emit_color, "lightblue", END_SPAN),
    0xEF: (emit_color, "lightgray", END_SPAN),
    # normal
    0xF0: (str, "", ""),
    # strong (bold?)
    0xF1: (str, "**", "**"),
    # emphatic (italics?)
    0xF2: (str, "*", "*"),
    0xF3: (str, "{link_code}", ""),
    0xF4: (str, '<div align="left">', END_DIV),
    0xF5: (str, '<div align="right">', END_DIV),
    0xF6: (str, '<div align="center">', END_DIV),
    0xF7: (str, '<div align="justify">', END_DIV),
    # horizontal rule
    0xF8: (str, "---", ""),
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
    print(f"Writing file...{filename}")
    try:
        if isinstance(data, bytes):
            with open(filename, "wb") as outf:
                outf.write(data)
            return True
        if isinstance(data, list):
            with open(filename, "w") as outf:
                outf.write("\n".join(data))
            return True
        print(f"ERROR: Cannot write that")
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
                    # print(f"DEBUG: len(end_stack) {len(end_stack)}")
                    content += end_stack.pop()
                funct = MTEXT.get(byte)[0]
                param = MTEXT.get(byte)[1]
                endmark = MTEXT.get(byte)[2]
                # print(f"DEBUG: calling funct {funct} with param {param}")
                content += funct(param)
                # push end mark for this tag/code onto stack
                end_stack.append(endmark)
        else:
            # append linefeed twice (wrecks tables, but.. not used in MText)
            # if byte == 0x0A or byte == 0x0D:
            #    content += char
            # append to content
            content += char

    return content


def render_all(block, arg_dict):
    if block in arg_dict:
        return arg_dict.get(block).to_bytes(1, "little")
    return None


def render_link(block, links):
    print(f"DEBUG: parse_link block: {block}")
    return int(0xF3).to_bytes(1, "little")


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
    #    print("toc_list:", toc_list)

    for file in toc_list:
        # should we ignore blank lines.
        if len(file) > 0:
            output_data.append("# " + file)
            if not os.path.exists(inputdir + file):
                continue
            data = file_read(inputdir + file)
            if len(data) > 0:

                result = scan_codes(data)
                # print(f"DEBUG: main result: {result}")
                output_data.append(result)
        else:
            output_data.append("# ")

    file_write(output, output_data)

    print(f"Done!")


if __name__ == "__main__":
    main()
