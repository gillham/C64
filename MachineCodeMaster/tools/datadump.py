#!/usr/bin/env python3
"""
Simple tool to dump a 6502 binary as DATA statements
"""
import click


@click.command()
@click.argument("prg", type=click.File("rb"), required=True)
@click.option(
    "--linenum", default=63822, help="Starting line number, defaults to '63822'."
)
@click.option("--increment", default=1, help="Line number increment, defaults to '1'.")
def main(prg, linenum, increment):
    """
    Read a C64 prg and dump it.  Line number defaults are convenient
    for Master Code BASIC statement checksum routine.
    """

    data = prg.read()
    count = 0

    # skip load address (first two bytes)
    for line in data[2:]:
        if count == 0:
            print(linenum, "DATA ", end="")
        print(str(line).zfill(3), end="")
        count += 1
        if count > 9:
            print("")
            count = 0
            linenum += increment
        else:
            print(",", end="")


if __name__ == "__main__":
    # pylint: disable=no-value-for-parameter
    main()
