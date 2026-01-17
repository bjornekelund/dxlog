BEGIN {
  printf("#00 AGB members prefill database\n");
  printf("#01 Based on data from http://ev5agb.com/club/agb-list.txt\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = " ";
  max = 0;
}
{
  if ($1 ~ /^[0-9]+$/ && $2 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)*$/)
  {
    printf("%s=%s\n", $2, $1);
    max = $1 > max ? $1 : max;
  }
  else if ($0 !~ /^N/ && $0 !~ /-[0-9]/ && $0 !~ /delet/ && $0 != "" && $2 !~ /[0-9]$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#02 Contains members up to #%d\n", max);
  printf("Highest member number is %d\n", max) > "/dev/stderr";
}
