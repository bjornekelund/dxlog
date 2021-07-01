gawk '
BEGIN {
  FS=","
  printf("#TITLE BERU Stations\n");
}
{
#  printf("$1=\"%s\", $2=\"%s\"\n", $1, $3) > "/dev/stderr";
  if (substr($1,1,1) ~ /[0-9,A-Z]/) {
    if ($3 == "HQ")
      printf("%s %s %s %s\n", $1, $3, $2, $4);
    else {
      n = toupper($2);
      if ((n == "RJL" || n == "DXG" || n == "MCC" || length(n) < 3) && n != "ED")
        name = toupper($2);
      else
        name = toupper(substr($2, 1, 1)) tolower(substr($2, 2))
      if ($2 != "" || $3 != "" || $4 != "")
        printf("%s %s %s %s\n", $1, name, $3, $4);
    }
  }
}
END {
}' < $1 | sed 's/  / /g' | sort | more > BERU.xdt
echo "BERU.xdt created"
unix2dos BERU.xdt
exit
