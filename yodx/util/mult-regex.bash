SOURCE=sortedmult.txt
DEST=regex-mult.txt

echo Using $SOURCE
dos2unix -q $SOURCE

awk \
'BEGIN\
{
  FS = "=";
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
}' $SOURCE | sort > $DEST

unix2dos -q $DEST
echo Created $DEST

exit

