gawk '
BEGIN {
  FS=","
  maxlen = 0;
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $2 != "") {
    if (length($2) > maxlen) {
      maxlen = length($2);
      printf("Longest so far (%d): %s\n", maxlen, $0);
    }
  }
}
END { 
}' $1
exit
