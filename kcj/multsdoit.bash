#!/bin/bash
INFILE=multsorig.txt
FILE=mults.txt

dos2unix -q $INFILE

sort -k4 $INFILE |\
awk '
BEGIN {
  FS=" "
  count = 0;
}
{
  prefix[count] = $4;
  pref[count] = $2;
  count++;
}
END {
  prevprefix = "";
  for (i = 0; i < count; i++) {
    if (prefix[i] != prevprefix) {
      printf("\nGroup->%s: %s", prefix[i], pref[i]);
      prevprefix = prefix[i];
    }
    else
      printf(",%s", pref[i]);
  }
  printf("\n");
}' > $FILE

echo Created $FILE
unix2dos -q $FILE

exit
