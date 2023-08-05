#!/usr/bin/env python3
"""
Simple tool to dump a 6502 prg to the Master Code assembler
machine code format.
"""
import sys
import click


@click.command()
@click.argument("prg", type=click.File("rb"), required=True)
@click.option("--output", default="aout.prg.txt", help="Output filename.")
def main(prg, output):
    """
    Read a C64 prg and dump it to Master Code format.
    Master Code machine code format is a text file with
    one decimal number per line. The first two lines are
    the load address and the address of the last byte of the file.
    Following that is each byte in the file as a decimal number
    one line at a time.
    """

    data = prg.read()

    # don't count load address (first two bytes)
    size = len(data[2:])
    start = data[1] * 256 + data[0]
    end = start + size

    print(f"Opening {output} for writing...", file=sys.stderr)
    print(f"Decimal starting address: {start}", file=sys.stderr)
    print(f"Decimal   ending address: {end} ({size} bytes)", file=sys.stderr)

    with open(output, "wt", encoding="ascii") as outfile:
        print(start, file=outfile)
        print(end, file=outfile)
        # skip load address (first two bytes)
        for line in data[2:]:
            print(str(line).zfill(3), file=outfile)


if __name__ == "__main__":
    # pylint: disable=no-value-for-parameter
    main()
