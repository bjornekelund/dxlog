#!/bin/bash
FILE=YOTA_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '\
BEGIN {
  FS = "=";
}
{
  if (lines[$1] != "")
  {
    printf("Repeated call: \"%s\" and \"%s\"\n", lines[$1], $0) > "/dev/stderr";
  }
  if ($1 !~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $0 !~ /^(!|#|$)/)
  {
    printf("Invalid call: \"%s\"\n", $0) > "/dev/stderr";
  }
  if ($2 !~ /^[0-9]{1,2}/ && $0 !~ /^(!|#|$)/)
  {
    printf("Invalid age: \"%s\"\n", $0) > "/dev/stderr";
  }
  lines[$1] = $0;
}' $FILE

exit
