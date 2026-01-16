BEGIN {
  printf("#00 Marconi Club ARI Loano members database\n");
  printf("#01 Based on data from http://www.ariloano.it/marconiclub\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ";";
  max = 0;
}
{
  # if ($1 ~ /^MC[1-9][0-9]*$/ && $2 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,3}(\/[A-Z0-9]+)?$/)
  if ($1 ~ /^MC[1-9][0-9]*$/ && $2 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,3}$/)
  {
    member = $1;
    gsub(/^MC/, "", member);
    max = member > max ? member : max;

    printf("%s=%s\n", $2, $1);
  }
  else if ($0 !~ /num/ && $0 != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#02 Contains members up to #%d\n", max);
  printf("Highest member number is %d\n", max) > "/dev/stderr";
}
