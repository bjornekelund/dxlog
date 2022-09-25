gawk '
BEGIN {
  FS=","
  maxlen = 0;
#  printf("\nChecking for longest name...\n");
}
{
  if ($1 ~ /^[0-9A-Z]/ && $2 != "") {
    if (length($2) > maxlen) {
      maxlen = length($2);
      maxname = $2;
    }
  }
}
END {
  printf("Longest name is \"%s\" (%d)\n", maxname, maxlen);
}' $1
exit
