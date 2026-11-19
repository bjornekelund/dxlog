BEGIN {
  printf("#00 EPC members prefill database\n");
  printf("#01 Based on data from https://epc-mc.eu/download/epcdlde/epccall.txt\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  max = 0;
  call = 1;
  member = 2;
}
{
  gsub("\"", "", $0);
  if (IsValidCall($call) && $member ~ /^[0-9]+$/)
  {
    printf("%s=%s\n", $call, $member);
    max = $member > max ? $member : max;
  }
  else if ($call !~ /(-| )/ && $member ~ /[0-9]+$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#02 Contains members up to #%d\n", max);
  printf("Highest member number is %d\n", max) > "/dev/stderr";
}
