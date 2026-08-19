SOURCE=mults-mo.txt
DEST=regex-mo.txt

echo Parsing $SOURCE
dos2unix -q $SOURCE

awk \
'BEGIN\
{
  FS = "=";
  printf("^(");
  notfirst = 0;
}
{
  if (notfirst++ && $1 != "")
    printf("|");
  printf("%s", $1);
}
END {
  printf(")$\n");
}' $SOURCE | sort > $DEST

unix2dos -q $DEST
echo Created $DEST

exit

