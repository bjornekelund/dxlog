#!/bin/bash
INFILE=bcc-members.txt
OUTFILE=BCC.xdt

echo Downloading $INFILE...
wget -q --no-hsts http://www.bavarian-contest-club.de/members/bcc-members.txt -O $INFILE


echo Parsing $INFILE...
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=","
  printf("# BCC members (%s)\n", strftime("%Y-%m-%d"));
}
{
  call = toupper($1);
  gsub(/ /, "", call);
  name = $2;
  if (call ~ /^[0-9,A-Z,\/]+$/ && name != "") {
    printf("%s %s\n", call, name);
  }
  else if ($0 !~ /^(!|#)/) {
    printf("Skipped: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
}' $INFILE > .tmp
iconv -f "windows-1252" -t "UTF-8" .tmp -o BCC.xdt
echo $OUTFILE created
unix2dos -q $OUTFILE
exit

