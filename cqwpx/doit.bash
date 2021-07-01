dos2unix locations.txt
gawk '
BEGIN {
  FS=" ";
  printf("%s", "^(");
}
{
  if ($1 ~ /^[A-Z]/)
    printf("%s|", toupper($1));
  else
    printf("Error: %s\n", $0) > "/dev/stderr";
}
END {
  printf("%s\n", ")$");
}' < locations.txt > result.txt
unix2dos result.txt
