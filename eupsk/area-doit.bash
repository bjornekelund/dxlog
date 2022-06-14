dos2unix -q euareas.csv

gawk '
BEGIN {
  FS=";";
  printf("[MULTIPLIERS START]\n");
}
{
  if ($1 ~ /^[A-Z]/)
    printf("%s=%s\n", toupper($1), $2);
  else if ($1 != "")
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  printf("[MULTIPLIERS END]\n");
}' < euareas.csv | sort > a-result.txt

unix2dos -q a-result.txt

exit
