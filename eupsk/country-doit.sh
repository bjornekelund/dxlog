dos2unix -q cty.dat

sed 's/ //g' < cty.dat > .ctytemp
gawk '
BEGIN {
  FS = ":";
}
{
  if ($2 ~ /^[0-9]{2}/ && $4 == "EU" && $8 !~ /\*/)
    printf("%s;", $8);
#  else
#    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
END {
  printf("\n");
}' < .ctytemp > c-result.txt

unix2dos -q c-result.txt

rm -rf .ctytemp 

exit
