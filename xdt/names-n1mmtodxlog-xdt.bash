gawk '
BEGIN {
  FS=","
  printf("#TITLE Name and QTH\n");
}
{
#  printf("$1=\"%s\", $2=\"%s\"\n", $1, $3) > "/dev/stderr";
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $3 ~ /[0-9]/) {
    name = (toupper(substr($2,1,1))tolower(substr($2,2)));
    printf("%s ", $1);
    if (name != "")
      printf("%s ", name);
    printf("%s %s\n", $3, $4);
  }
}
END { 
}' < $1 | sort | more > Names.xdt
echo "Names.xdt created"
unix2dos Names.xdt
exit
