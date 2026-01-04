BEGIN {
  FS="="
  first = 1;
  printf("^(", $1)
}
{
  if ($1 ~ /^\S\S\S$/) 
  {
    printf(first ? "%s" : "|%s", $1);
    first = 0;
  }
  else {
    printf("Problem \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf(")$\n");
}