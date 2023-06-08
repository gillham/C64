#!/usr/bin/env python3

import os
import sys
from pathlib import Path
import cbmcodecs2
import click

ARCHIVE_TYPES = ["at_gnrl", "at_rstr", "at_instl"]
COMPRESS_TYPE = ["none", "RLE", "LZ"]

# header sizes
ARCHIVE_HEADER = 48
FILE_HEADER = 22

codec = "petscii_c64en_lc"
path = ""


def extract(car, file_offset, base, path):
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
        # how should we handle this special top level directory?
        if "<-" not in car_name:
            path = path + car_name + "/"
        else:
            print(f"Initial directory entry: \"{car_name}\". Not using.")

        # skip over file header (directories have just a header, no data)
        offset = file_offset + FILE_HEADER
        for child in range(0, car_size):
            offset = extract(car, offset, base, path)
        # offset points to the next file_header
        return offset


@click.command()
@click.argument("archive", type=click.File("rb"), required=True)
@click.option("--base", default="./", help="Extraction base target directory.")
def main(archive, base):
    # We read the archive header and then call extract()
    # with the first file header.  It should be a 'D' type header.
    # Read in the whole archive, they are small.
    contents = archive.read()

    # Parse the archive header
    car_type = contents[0]
    car_magic = contents[1:11]
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

    # Installer archives extract into the system directory.
    # The system directory should be an cli option.
    if not base.endswith("/"):
        base += "/"
    if car_type == 2:
        base = base + "os/"

    # Print out some archive info.
    if car_type <= len(ARCHIVE_TYPES):
        print(f"Archive type: {ARCHIVE_TYPES[car_type]}")
    print(f"Archive note: {car_note}")
    print(f"Archive date: {car_yr}-{car_mon}-{car_day} {car_hr}:{car_min}")

    # Skip the archive header to find the initial directory.
    foffset = ARCHIVE_HEADER

    car_type2 = contents[foffset + 0]
    file_type = chr(car_type2)
    car_lock = contents[foffset + 1]
    car_size = contents[foffset + 2 : foffset + 5]
    car_sizeint = int.from_bytes(contents[foffset + 2 : foffset + 5], "little")
    car_name = contents[foffset + 5 : foffset + 20]
    car_comp = contents[foffset + 21]

    end = car_name.find(0xA0)
    if end > 0:
        car_name = car_name[:end]
    car_name = car_name.decode(codec)
    if file_type == "D":
        result = extract(contents, foffset, base, path)
    else:
        print("Initial file header is not a directory? Archive error?")
        sys.exit(1)


if __name__ == "__main__":
    main()
