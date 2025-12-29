BEGIN {
  FS=","
  printf("#0 KCJ contest database\n");
  printf("#1 Data collected and maintained by VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $2 ~ /^(AC|AM|AT|CB|EH|FI|FO|FS|GF|GM|HD|HG|HS|HY|IB|IK|IR|IS|IT|KA|KC|KG|KK|KM|KN|KR|KT|ME|MG|MT|MZ|NI|NM|NN|NR|NS|OG|OH|OM|ON|OS|OT|OY|RM|SB|SC|SG|SI|SN|SO|ST|SY|TC|TG|TK|TS|TT|TY|WK|YG|YM|YN)$/) 
  {
    if (call[$1] != "") {
      if (exch[$1] != $2) 
      {
        printf("Conflict for call %s: %s and %s\n", $1, $2, exch[$1]) > "/dev/stderr";
      }     
    }
    else
    {
      printf("%s=%s\n", toupper($1), toupper($2));
      call[$1] = $1;
      exch[$1] = $2;
    }
  }
  else if ($0 !~ /^(#|!|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}