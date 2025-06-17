SOURCE=ARRL-SECTIONLIST.txt
DEST=regex-valid-locations.txt

echo Using $SOURCE
dos2unix -q $SOURCE

gawk \
'BEGIN\
{
  FS=" "
  printf("^(DX|");
  notfirst = 0;
}
{
  if ($2 != "") section = $2; 
  if ($3 != "") section = $3;
  if ($4 != "") section = $4;
  if ($5 != "") section = $5;
  if ($6 != "") section = $6;
  if ($7 != "") section = $7;
  if ($8 != "") section = $8;
  if ($9 != "") section = $9;
  if (notfirst++)
    printf("|");
  printf("%s", section);
}
END {
  printf(")$\n");
}' $SOURCE > $DEST

echo Created $DEST
unix2dos -q $DEST

exit
