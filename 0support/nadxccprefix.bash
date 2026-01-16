SOURCE=cty.dat
DEST=regex-nadxcc.txt

echo Using $SOURCE
dos2unix -q $SOURCE

cat $SOURCE | awk \
'BEGIN {
  printf("^(");
  FS = ":";
  notfirst = 0;
}
{
  if ($4 ~ /NA/) 
  {
  if (notfirst++)
    printf("|");
    printf("%s", $8)
  }
}
END {
  printf(")$\n");
}' $SOURCE | sed 's/ //g' > $DEST

unix2dos -q $DEST
echo Created $DEST

exit

