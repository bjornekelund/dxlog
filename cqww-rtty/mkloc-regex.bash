SOURCE=ARRL-SECTIONLIST.txt
DEST=regex-valid-locations.txt

echo Using $SOURCE
dos2unix -q $SOURCE

awk \
'BEGIN\
{
  FS=" "
  printf("DX\n");
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
  printf("%s\n", section);
}' $SOURCE | sort > .sections.txt

awk \
'BEGIN\
{
  FS=" "
  printf("^(");
  notfirst = 0;
}
{
  if (notfirst++)
    printf("|");
  printf("%s", $1);
}
END {
  printf(")$\n");
}' .sections.txt | sort > $DEST

unix2dos -q $DEST
echo Created $DEST
exit
