#!/bin/bash
FILE1=StewPerry-002.txt
FILE2=Russian160_CallHist.txt
FILE3=disagreement.txt

OUTFILE=StewPerry-100.txt

echo Parsing $FILE1 and $FILE2 and $FILE3
dos2unix -q $FILE1 $FILE2 $FILE3

cat $FILE1 $FILE2 $FILE3 | gawk '
BEGIN {
  FS = ",";
}
{
  if ($1 ~ /^[A-Z0-9]+$/ && $3 ~ /^[A-R]{2}[0-9]{2}$/)
  {
    if (call[$1] != "" && exchange[$1] != $3) 
    {
      printf("Replaced: \"%s\" \"%s\" with \"%s\" \n", $1, exchange[$1], $3) > "/dev/stderr";
#      printf("%s\n", $1) > "/dev/stderr";
    }
    call[$1] = $1;
    name[$1] = $2;
    exchange[$1] = $3;
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
#    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("!!Order!!,Call,Name,Loc1,UserText,\n");
  printf("#00 Call history file for HF contests with four-position grid as exchange\n");
  printf("#01 Created by merging StewPerry-002.txt, Russian160_CallHist.txt,\n");
  printf("#02 and verifying differing grids by qrz.com lookup.\n");
  for (c in call) 
  {
    printf("%s,,%s,\n", call[c], exchange[c]);
  }
}' | sort | sed 's/^#0. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
