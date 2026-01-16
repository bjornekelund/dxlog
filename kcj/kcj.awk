BEGIN {
  printf("#00 KCJ Contest prefill database\n");
  printf("#01 Based on data maintained by VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $col ~ /^(AC|AM|AT|CB|EH|FI|FO|FS|GF|GM|HD|HG|HS|HY|IB|IK|IR|IS|IT|KA|KC|KG|KK|KM|KN|KR|KT|ME|MG|MT|MZ|NI|NM|NN|NR|NS|OG|OH|OM|ON|OS|OT|OY|RM|SB|SC|SG|SI|SN|SO|ST|SY|TC|TG|TK|TS|TT|TY|WK|YG|YM|YN)$/)
  {
    if (calls[$call] != "")
    {
      if (exch[$call] != $col)
      {
        printf("Conflict for call %s: %s and %s\n", $call, $col, exch[$call]) > "/dev/stderr";
      }    
    }
    else
    {
      printf("%s=%s\n", toupper($1), toupper($col));
      calls[$1] = $1;
      exch[$1] = $col;
    }
  }
  else if ($0 !~ /^(#|!|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}