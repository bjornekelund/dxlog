BEGIN {
  FS=";"
}
{
  if ($1 ~ /^MC[1-9][0-9]*$/ && $2 ~ /^[A-Z0-9/]+/) {
    printf("%s=%s\n", $2, $1);
  }
  else if ($0 !~/^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
END {
  printf("#0 MARCONI CLUB ARI LOANO members database\n");
  printf("#1 Based on data from http://www.ariloano.it/marconiclub\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}