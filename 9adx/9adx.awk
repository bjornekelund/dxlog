BEGIN {
  FS=","
  max = 0;
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~/^(BJ|BM|CK|DA|DE|DU|DJ|GS|IM|KA|KC|KR|KT|KZ|MA|NA|NG|OG|OS|PU|PZ|RI|SB|SK|SL|ST|SI|VK|VT|VU|VZ|ZD|ZG|ZU)$/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END { 
  printf("#0 9A DX database\n");
  printf("#1 Based on call history data maintained by VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}
