#!/bin/bash
INFILE="CP QSO Party Mult List-2025 Update.txt"
ABFILE=ALBERTA.txt
MBFILE=MANITOBA.txt
SKFILE=SASKATCHEWAN.txt
CTFILE=COUNTIES.txt

echo Parsing \"$INFILE\"

dos2unix -q "$INFILE"

gawk 'BEGIN { FS="," }
{
  if ($3 == "AB") {
    # printf("$1=\"%s\", $2=\"%s\", $3=\"%s\"\n", $1, $2, $3) > "/dev/stderr"
    printf("%s=%s\n", $2, $1)
  }
}' "$INFILE" > $ABFILE
echo Created $ABFILE

gawk 'BEGIN { FS="," }
{
  if ($3 == "MB")
    printf("%s=%s\n", $2, $1)
}' "$INFILE" > $MBFILE
echo Created $MBFILE

gawk 'BEGIN { FS="," }
{
  if ($3 == "SK")
    printf("%s=%s\n", $2, $1)
}' "$INFILE" > $SKFILE
echo Created $SKFILE

gawk 'BEGIN { FS="," }
{
  if ($3 ~ /^\S\S$/)
      printf("%s=%s\n", $2, $1)
}' "$INFILE" > $CTFILE
echo Created $CTFILE

unix2dos -q "$INFILE" $ABFILE $MBFILE $SKFILE $CTFILE

exit
