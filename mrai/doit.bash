#!/bin/bash
OUTFILE=mults.txt

gawk '
BEGIN {
    for (i = 1970; i < 2025; i++) {
        mult = substr(sprintf("%d", i), 3);
        printf("%s|", mult);
    }
}
{}' /dev/null > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
