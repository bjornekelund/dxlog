#!/bin/bash
OUTFILE=R4C-CUP_db.txt
INFILE=rda-cleaned.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS = ",";
  printf("#00 Saratov Oblast Contest prefill database\n");
  printf("#01 Based on database from https://rdaward.org\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($2 ~ /[0-9,A-Z]/ && $3 ~ /SA-[0-9]{2}/) {
    calll = length($2) - 2;
    call = substr(substr($2, 2), 1, calll);
    rda = substr($3,2,2) substr($3,5,2);
#    printf("call=%s rda=%s\n", call, rda) > "/dev/stderr";
    callist[call] = call;
    rdalist[call] = rda;
  }
  else {
#    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (cs in callist) {
    printf("%s=%s\n", callist[cs], rdalist[cs]);
  }
}' $INFILE | sort | sed 's/#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE


exit
