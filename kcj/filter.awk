BEGIN {
  printf("#00 KCJ Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) exch = 2;
    if ($4 ~ /Exch1/) exch = 3;
    if ($5 ~ /Exch1/) exch = 4;
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^([78][J-N]|J[A-S])[0-9]{1,4}[A-Z]{1,5}(\/(QRP|[0-9]))?$/ && \
    $exch ~ /^(AC|AM|AT|CB|EH|FI|FO|FS|GF|GM|HD|HG|HS|HY|IB|IK|IR|IS|IT|KA|KC|KG|KK|KM|KN|KR|KT|ME|MG|MT|MZ|NI|NM|NN|NR|NS|OG|OH|OM|ON|OS|OT|OY|RM|SB|SC|SG|SI|SN|SO|ST|SY|TC|TG|TK|TS|TT|TY|WK|YG|YM|YN)$/)
  {
    if (line[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", toupper($1), toupper($exch));
      line[$1] = $0;
    }
  }
  else if ($0 !~ /^(#|!|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}