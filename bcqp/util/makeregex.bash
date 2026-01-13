#!/bin/bash
FILE=ELECTORAL.txt
dos2unix -q $FILE
gawk '
BEGIN {
  FS = " ";
  printf("^(");
}
{
  if ($0 !~ /^#/)
    printf("%s|", $1);
}
END {
  printf(")$\n");
}' $FILE | sed 's/|)/)/g' > electoral-regex.txt

exit
