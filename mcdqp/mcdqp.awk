BEGIN {
  printf("#00 Marconi Club ARI Loano members database\n");
  printf("#01 Based on data from http://www.ariloano.it/marconiclub\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=";"
}
{
  if ($1 ~ /^MC[1-9][0-9]*$/ && $2 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/) 
  {
    printf("%s=%s\n", $2, $1);
  }
  else if ($0 !~ /num/ && $0 != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
