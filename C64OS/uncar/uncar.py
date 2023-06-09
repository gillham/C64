#!/usr/bin/env python3

import os
import sys
from pathlib import Path
import cbmcodecs2
import click

ARCHIVE_TYPES = ["General", "Restore", "Install"]
AT_GENERAL = 0
AT_RESTORE = 1
AT_INSTALL = 2
COMPRESS_TYPE = ["none", "RLE", "LZ"]

# header sizes
ARCHIVE_HEADER = 48
FILE_HEADER = 22

codec = "petscii_c64en_lc"
path = ""


def extract(car, file_offset, base, path, ignorerootentry=False):
    header = car[file_offset : file_offset + FILE_HEADER]

    # extract header info.
    file_type = chr(header[0])
    car_lock = header[1]
    car_size = int.from_bytes(header[2:5], "little")

    # the file/directory name is terminated with 0xa0
    car_name = header[5:20]
    end = car_name.find(0xA0)
    if end > 0:
        car_name = car_name[:end]
    car_name = car_name.decode(codec)
    car_comp = header[21]

    if file_type != "D":
        filepath = base + path + car_name

        # Create any directories needed.
        Path(base + path).mkdir(parents=True, exist_ok=True)

        # write out the file..
        data = car[file_offset + FILE_HEADER : file_offset + FILE_HEADER + car_size]
        print(f"Extracting {filepath} ({len(data)} bytes)")
        if car_comp != 0:
            print(f"Not extracting {filepath}. Compressed: ({COMPRESS_TYPE[car_comp]})")
        with open(filepath, "wb") as newfile:
            newfile.write(data)
        return file_offset + FILE_HEADER + car_size
    else:
        # The initial entry of an installer archive type is ignored.
        if not ignorerootentry:
            path = path + car_name + "/"
        else:
            print(f'Install archive, initial entry note: "{car_name}".')

        # skip over file header (directories have just a header, no data)
        offset = file_offset + FILE_HEADER
        for child in range(0, car_size):
            offset = extract(car, offset, base, path)
        # offset points to the next file_header
        return offset


@click.command()
@click.argument("archive", type=click.File("rb"), required=True)
@click.option("--base", default=".", help="Extraction base target directory.")
@click.option("--system", default="os", help="System directory name, defaults to 'os'.")
def main(archive, base, system):
    # We read the archive header and then call
    # extract() with the first file header.
    # Read in the whole archive, they are small.
    contents = archive.read()

    # Parse the archive header
    car_type = contents[0]
    car_magic = contents[1:11].decode(codec)
    car_ver = contents[11]
    car_date = contents[12:17]
    car_yr = 1900 + contents[12]
    car_mon = "{:0>2}".format(contents[13])
    car_day = "{:0>2}".format(contents[14])
    car_hr = "{:0>2}".format(contents[15])
    car_min = "{:0>2}".format(contents[16])
    car_note = contents[17:48]
    end = car_note.find(0x00)
    if end > 0:
        car_note = car_note[:end]
    car_note = car_note.decode(codec)

    # We don't handle non C64 CAR files.
    if car_magic != "C64Archive":
        print(f"ERROR: bad magic: {car_magic}.")
        sys.exit(1)

    # We currently only handle version 2.
    if car_ver != 2:
        print(f"ERROR: unsupported archive version: {car_var}.")
        sys.exit(1)

    # Make sure directories end with a slash.
    if not base.endswith("/"):
        base += "/"
    if not system.endswith("/"):
        system += "/"

    # Installer archives extract into the system directory.
    if car_type == AT_INSTALL:
        base = base + system
        ignorerootentry = True
    else:
        ignorerootentry = False

    # Print out some archive info.
    if car_type <= len(ARCHIVE_TYPES):
        print(f"Archive type: {ARCHIVE_TYPES[car_type]}")
    else:
        print(f"Archive type: unknown? (please report)")
    print(f"Archive vers: {car_ver}")
    print(f"Archive note: {car_note}")
    print(f"Archive date: {car_yr}-{car_mon}-{car_day} {car_hr}:{car_min}")

    # Skip the archive header to find the initial entry.
    foffset = ARCHIVE_HEADER

    # Call extract with the initial entry. It will
    # recursively extract all files / directories.
    result = extract(contents, foffset, base, path, ignorerootentry)
    sys.exit(0)


if __name__ == "__main__":
    main()
