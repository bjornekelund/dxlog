BEGIN {
  FS=" "
}
{
  if ($1 ~ /^TRC#/ && $2 !~ /SWL/ && ($2 ~ /[A-Z]/ && $2 ~ /[0-9]/ && $2 !~ /-/)) {
    printf("%s=TRC\n", $2);
    if ($4 ~ /[A-Z]/ && $4 ~ /[0-9]/ && $5 == "")
      printf("%s=TRC\n", $4)
  }
  else if ($0 !~ /^#/ && $2 != "CB" && $2 != "-")
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 TRC members database\n");
  printf("#1 Data from official listing on trcdx.org\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}