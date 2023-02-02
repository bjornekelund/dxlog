#!/bin/bash
FILE=`ls N5X* | tail -1 2> /dev/null`
OUTFILE=TENTEN.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=";"
  maxlen = 0;
  longest = "";
}
{
  if ($1 ~ /^[0-9]+$/ && $2 ~ /^[0-9A-Z\/]+$/ && $3 ~ /^[a-zA-Z ]*$/ && $4 ~ /^([A-Z]{2}|)$/)
  {
    # if (calls[$1] != "") 
    #   printf("Duplicated call: \"%s\"\n", $0) > "/dev/stderr"

    calls[$1] = $2;

    for (i = 1; i < length($3); i++) {
      if (substr($3, i, 1) ~ /^( |-)$/) {
        ln = i - 1;
        break;
      }
      ln = i + 1;
    }


    name[$1] = substr($3, 1, ln);

    # printf("Full: \"%s\"  Trunc: \"%s\"\n", $3, name[$1]) > "/dev/stderr"

    if ($4 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
      state[$1] = $4;
    else
      state[$1] = "";

    num[$1] = $1;

    if (length($3) > maxlen) 
    {
      maxlen = length($3);
      longest = $3;
    }
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Bad entry: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
    printf("!!Order!!, Call, Name, Exch1, Misc,  UserText, \n");
  for (c in calls) 
  {
    printf("%s,%s,%s,%s\n", calls[c], name[c], state[c], num[c]);
  }
}' $FILE | sort > $OUTFILE

echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit
