#!/bin/bash
INFILE=iaruhq.txt
OUTFILE=multipliers.txt

dos2unix -q $INFILE

cat $INFILE | gawk '
BEGIN {
  FS = "=";
}
{
  printf("%s\n", $2);
}' | sort | uniq | gawk '
BEGIN{
  printf("[MULTIPLIERS START]\n");
}
{
  if ($1 != "") 
  {
    printf("%s=%s\n", $1, $1);
  } 
}
END {
  printf("[MULTIPLIERS END]\n");
}
'> $OUTFILE

unix2dos -q $OUTFILE

echo Created $OUTFILE

exit


BEGIN{
  printf("WINDOWS_CML_LIST_FX=GetList_CustomArray(\"");
  notfirst = 0;
}
{
  if ($1 != "") 
  {
    if (notfirst) printf("|");
    printf("%s", $1);
    notfirst = 1;
  } 
}
END {
  printf("\",\"|\")\n");
}
