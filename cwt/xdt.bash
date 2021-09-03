gawk '
BEGIN {
  FS=","
  printf("#TITLE CWOps members\n");
}
{
#  printf("$1=\"%s\", $2=\"%s\"\n", $1, $3) > "/dev/stderr";
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $3 ~ /[0-9]/) {
    printf("%s %s #%s %s\n", $1, $2, $3, $4);
  }
}
END { 
}' < $1 | sed 's/  / /g' | sort | more > CWOps.xdt
echo "CWOps.xdt created"
unix2dos CWOps.xdt
exit
