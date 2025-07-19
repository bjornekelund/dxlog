BEGIN {
  printf("#0 RCWC member database based on data from https://rcwc.ru/?do=members\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=" "
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~ /^[1-9][0-9]*$/) {
    printf("%s=CM%s\n", $1, $2);
  }
  else {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
