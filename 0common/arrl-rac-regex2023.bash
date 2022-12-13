SOURCE1=arrl-sorted.txt
SOURCE2=rac-sorted2023.txt
DEST=regex-arrl-rac2023.txt

echo Parsing $SOURCE1 $SOURCE2
dos2unix -q $SOURCE1 $SOURCE2

cat $SOURCE1 $SOURCE2 | sort |\
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

