BEGIN {
  printf("#00 RDA Contest prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com/\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $2 ~ /^[A-Z]{2}[0-9]{2}$/)
  {
    printf("%s=%s\n", $1, $2);
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
