INFILE=locations.txt
OUTFILE=regex-locations.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=" ";
  printf("%s", "^(");
}
{
  if ($1 ~ /^[A-Z]/)
    printf("%s|", toupper($1));
  else
    printf("Error: %s\n", $0) > "/dev/stderr";
}
END {
  printf("%s\n", ")$");
}' $INFILE > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
