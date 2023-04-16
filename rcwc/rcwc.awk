BEGIN {
  FS=" "
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 != "") {
    printf("%s=CM%s\n", $1, $2);
  }
  else
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 RCWC member database based on data from http://rcwc.ru\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}