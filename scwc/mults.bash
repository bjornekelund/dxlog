#!/bin/bash
OUTFILE=mults.txt

cat /dev/null | gawk '
BEGIN {}{}
END {
  for (i = 0; i < 100; i++)
    printf("M%02d=M%02d\n", i, i);
}' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit
