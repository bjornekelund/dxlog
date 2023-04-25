BEGIN {
  FS=","
}
{
  if (lines[$1] == "" || $0 ~ /^!|^#)/) {
    printf("%s\n", $0, $col);
    lines[$1] = $0;
  }
  else {
    printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
  }
}
