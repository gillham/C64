#!/usr/bin/python3
"""
This program reads 'PText' (Markdown-ish plaintext) with additional text formatting codes.
It then generates C64 OS 'MText' help files which have single byte binary representations of the codes.
For example:
    <c:black> (switch text to black)
    <j:right> (right justify/align text)
    <t:strong> (strong emphasis on text, bold)

Shortest unique match up to the full word is supported so are all the same:
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
CODES_REGEX = r"<(.)\:(\w+)?(\s?([/:]?)\w?)+\>"

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


def build_toc(section_list):
    """Build a Table Of Contents aka list of file names"""
    toc_list = []
    for section in section_list:
        # The section string becomes the filename and is removed from the content
        filename = section.pop(0).strip("#").strip()

        if len(filename) == 0:
            filename = None
            content = None
        else:
            content = section

        toc_list.append({"filename": filename, "content": content})
    return toc_list


def find_sections(regex, text):
    """This just looks for lines starting with the regex and collects them up to the next line that matches. Each becomes a section."""
    headers = []
    content = []
    for index, line in enumerate(text):
        # We use re.match to find the first match from the start of the line.
        match = re.match(regex, line)
        if match:
            headers.append(index)

    # Final header section ends at end of file.
    # We use "next header -1" as the end line of each header.
    # So we add a fake new header one past length of file.
    # The 'index + 1' below has the fake header on the least real header
    headers.append(len(text) + 1)
    for index, header in enumerate(headers[0:-1]):
        content.append(text[header : headers[index + 1]])

    return content


def parse_section(content_dict):
    """Parse the actual text contents of a section looking for formatting codes."""
    content = content_dict["content"]
    raw = bytes()
    if content is not None:
        for line in content:
            # returns bytes.
            result = parse_codes(line)
            raw += result

    return raw


def parse_codes(text):
    """Parse a single line of text for formatting codes."""
    encoded = text.encode("utf-8")
    for match in re.finditer(CODES_REGEX, text):
        if match:
            code = match.group(0)
            tag = match.group(1).lower()
            param = match.group(0)[3:-1].lower()

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
    if block in lookup_dict:
        block = lookup_dict.get(block)
    if block in arg_dict:
        return arg_dict.get(block).to_bytes(1, "little")
    return None


def parse_link(block, links, lookup_dict):
    """Parse link codes.  Currently a placeholder."""
    print(f"DEBUG: parse_link block: {block}")
    return int(0xF3).to_bytes(1, "little")


def write_file(filename, data):
    """Writes a file as text or binary depending on the data type."""
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


def write_toc(filename, toc_list):
    """Generates/writes the actual 'toc' file itself."""
    toc = []
    for section in toc_list:
        if section["filename"] is None:
            toc.append("")
        else:
            toc.append(section["filename"])

    return write_file(filename, toc)


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
    """This program reads 'PText' (Markdown-ish plaintext) from the input file and generate C64 OS 'MText' help files in the output directory."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", help="input file name")
    parser.add_argument("--output", help="output *directory*")
    args = parser.parse_args()
    if args.input:
        inputfile = args.input
    else:
        print("Input filename required.")
        sys.exit(1)

    if args.output:
        output = args.output
        if not output.endswith(os.path.sep):
            output += os.path.sep
    else:
        output = os.path.curdir + os.path.sep
    print(f"Writing to directory: {output}")

    # read the input file as a list
    try:
        with open(inputfile, "r") as inf:
            data = inf.readlines()
    except Exception as error:
        print(f"Error: {error}")
        sys.exit(1)

    # We support single header markers '#' starting at the leftmost
    # position with whitespace after. Followed by what will be the
    # filename. (& listed in the TOC)
    # So this: '# Introduction'
    sections = find_sections(r"^#\s", data)
    sections_list = build_toc(sections)

    # Generate/write the toc toplevel file.
    write_toc(output + "toc", sections_list)

    # Process each section into a separate file.
    for section in sections_list:
        result = parse_section(section)
        filename = section.get("filename")
        if filename is not None:
            write_file(output + filename, result)

    print(f"Done!")


if __name__ == "__main__":
    main()
