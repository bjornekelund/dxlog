#!/bin/bash
XDTFILE=CWOps.xdt
gawk '
BEGIN {
  FS=","
  printf("#TITLE CWOps members\n");
}
{
#  printf("$1=\"%s\", $2=\"%s\"\n", $1, $3) > "/dev/stderr";
  if ($1 ~ /^[0-9A-Z]/ && $3 ~ /^[0-9]+$/) {
    printf("%s %s #%s %s\n", $1, $2, $3, $4);
  }
}
END {
}' < $1 | sed 's/  / /g' | sort > $XDTFILE
echo $XDTFILE "created"
unix2dos -q $XDTFILE
exit
