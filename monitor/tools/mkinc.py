#!/usr/bin/env python3

# dictionary of symbols
table = {}

# Read output from cl65
with open("monitorc.vice") as file:
    data = file.readlines()

for line in data:
    _, addr, symbol = line.split()
    if symbol.startswith(".__"):
        continue
    symbol = symbol.strip('.')
    if addr.startswith('00'):
        addr = addr[2:]
    table.update({symbol:addr})

# Read my disassembler label file.
with open("reverse/monitorc.labels") as file:
    data = file.readlines()

for line in data:
    symbol, addr = line.split()
    if not symbol in table:
        table.update({symbol:addr})

# generate combined output.
for item in sorted(table):
    print(f"{item} = ${table[item]}")

#
# end-of-file
#
