#!/bin/bash
FILE1=initial.ex
FILE2=UBA_on_db.txt
TMP1=_tmpfile.txt

OUTFILE=UBA_Sections_db.txt
dos2unix -q $FILE1 $FILE2


echo Parsing $FILE1

cat $FILE1 | gawk '
BEGIN {
  FS=" "
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 ~ /^[A-Z]{3}$/) {
    printf("%s=%s\n", $1, $2);
  }
  else
    if ($0 !~ /^;|^$/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
}' > $TMP1

#more $TMP1

cat $TMP1 $FILE2 | gawk '
BEGIN {
  FS="="
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 ~ /^[A-Z]{3}$/) {
    if (section[$1] != "" && section[$1] != $2) {
      printf("Override: %s=%s --> %s\n", $1, section[$1], $2) > "/dev/stderr";
    }
    section[$1] = $2;
    callist[$1] = $1;
  }
  else if ($0 !~ /^#/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#0 Database with UBA sections for UBA, UBA Spring, and UBA ON Contests\n");
  printf("#1 Credit to UR7QM and ON4ZD for data collection\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in callist) {
    printf("%s=%s\n", c, section[c]);
  }
}' | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE 
unix2dos -q $OUTFILE

exit
