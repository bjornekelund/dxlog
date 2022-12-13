SOURCE1=arrl-sorted.txt
SOURCE2=rac-sorted2023.txt
SOURCE3=xe-sorted.txt
DEST=regex-arrl-locations2023.txt

echo Parsing $SOURCE1 $SOURCE2 $SOURCE3
dos2unix -q $SOURCE1 $SOURCE2 $SOURCE3

cat $SOURCE1 $SOURCE2 $SOURCE3 | sort |\
awk \
'BEGIN\
{
  FS="=";
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
}' > $DEST

unix2dos -q $DEST
echo Created $DEST

exit

