cp cty.dat .ctytemp

dos2unix -q .ctytemp

sed 's/ //g' < .ctytemp > .cty2temp
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
}' < .cty2temp > c-result.txt

unix2dos -q c-result.txt

exit
