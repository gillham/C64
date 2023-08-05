#!/usr/bin/env python3
"""
Simple script to generate a C64 binary from Master Code's machine code format
"""
import sys
import click


@click.command()
@click.argument("file", type=click.File("rb"), required=True)
@click.option("--output", default="aout.prg", help="Output file name.")
def main(file, output):
    """
    Read the Master Code format (one decimal string per line)
    and write the equivalent bytes out to a C64 file.
    """
    data = file.readlines()
    start = int(data[0].strip())

    written = 0
    print(f"Opening {output} for writing...", file=sys.stderr)
    print(f"Load address: {start:02X}", file=sys.stderr)
    with open(output, "wb") as outfile:
        outfile.write(start.to_bytes(2, "little"))

        for line in data[2:]:
            try:
                line = line.strip()
                if 0 == len(line):
                    break
                num = int(line)
            except ValueError as error:
                print("DEBUG: end of file?:", error, line, file=sys.stderr)
                break
            outfile.write(num.to_bytes())
            written += 1

    print(f"{written} bytes written.", file=sys.stderr)


if __name__ == "__main__":
    # pylint: disable=no-value-for-parameter
    main()
