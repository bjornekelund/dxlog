BEGIN {
  FS=" "
  printf("#0 AGB members database\n");
  printf("#1 Based on http://ev5agb.com/club/agb-list.txt\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9/]+$/ && $2 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/)
  {
    printf("%s=%s\n", $2, $1);
  }
  else if ($0 !~ /^N/ && $0 !~ /-[0-9]/ && $0 !~ /delet/ && $0 != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
