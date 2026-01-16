BEGIN {
  FS = " ";
  state = "";
  first = 1;
  printf("^(", $1)
}
{
  if ($1 ~ /^(AZ|MT|OR|ID|NV|WY|UT|WA)$/)
  {
    state = $1;
  }
  else if ($1 ~ /^\S\S\S$/)
  {
    if (first)
      printf("%s",state $1);
    else
      printf("|%s",state $1);
    first = 0;
  }
  else
  {
    printf("Problem \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf(")$\n");
}