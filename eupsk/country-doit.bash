cp cty.dat cty.tmp

dos2unix -q cty.tmp

sed 's/ //g' < cty.tmp > cty2.tmp
gawk '
BEGIN {
  FS=":";
}
{
  if ($2 ~ /^[0-9]{2}/ && $4 == "EU" && $8 !~ /\*/)
    printf("%s;", $8);
#  else
#    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  printf("\n");
}' < cty2.tmp > c-result.txt

unix2dos -q c-result.txt

exit
