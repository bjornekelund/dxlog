#!/bin/bash
FILE=$1
OUTFILE=$2

dos2unix -q $FILE
gawk '
BEGIN {
  FS=","
}
{
  if ($0 !~ /^(#|!)/) {
    section = $4;
    prec = $2;
    check = $3;
    if ($1 ~ /^VE9/ && section ~ /^MAR$/)
      section = "NB";
    else if ($1 ~ /^V[AE]1/ && section ~ /^MAR$/)
      section = "NS";
    else if ($1 ~ /^VY2|\/VY2$/ && section ~ /^MAR$/)
      section = "PE";
    else if (section ~ /^GTA$/)
      section = "GH";
    else if (section ~ /^NT$/)
      section = "TER";
    printf("%s=%s;%s;%s\n", $1, prec, check, section);
  }
  else {
    printf("%s\n", $0);
  }
}
END {
}' $FILE | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE

exit
