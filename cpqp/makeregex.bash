#!/bin/bash
dos2unix $1
gawk '
BEGIN {
  FS="="
  printf("^(");
}
{
  if ($0 !~ /^#/)
    printf("%s|", $1);
}
END {
  printf(")$\n");
}' $1 | sed 's/|)/)/g'
exit
