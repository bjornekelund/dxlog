gawk '
BEGIN {
  FS=","
  printf("#TITLE FOC members\n");
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $2 != "" && $3 != "" && $3 ~ /[0-9]/) {
    name = toupper(substr($2,1,1))tolower(substr($2,2));
    printf("%s %s #%s %s\n", $1, name, $3, $4);
  }
}
END { }' $1 | sort | more > FOC.xdt
unix2dos FOC.xdt
