DEST=regex-$1
echo creating $DEST
#exit
echo Parsing $1
dos2unix -q $1

cat $1 | sort |\
awk \
'BEGIN\
{
  FS=" ";
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

