#!/bin/bash
gawk '
BEGIN {
  FS=","
  printf("#TITLE IOTA\n");
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $3 ~ /[0-9]/) {
    printf("%s %s #%s %s\n", $1, $2, $3, $4);
  }
}
END {
}' < $1 | sort | more > IOTA.xdt
echo "IOTA.xdt created"
unix2dos -q IOTA.xdt
exit
