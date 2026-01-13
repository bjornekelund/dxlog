#!/bin/bash
INFILE=euareas.csv
OUTFILE=a-result.txt

dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS = ",";
  printf("000[MULTIPLIERS START]\n");
}
{
  if ($6 ~ /^[A-Z]{2}\.[A-Z]{2}\.[A-Z]{2}$/) {
    area = substr($6, 1, 2) substr($6, 4, 2) substr($6, 7, 2);
    printf("%s=%s\n", area, $2);
#    printf("area: %s\n", area) > "/dev/stderr";
  }
  else if ($1 != "") {
#    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("ZZZ[MULTIPLIERS END]\n");
}' | sort | sed 's/ZZZ\[/\[/g' | sed 's/000\[/\[/g' > $OUTFILE

unix2dos -q a-result.txt

exit
