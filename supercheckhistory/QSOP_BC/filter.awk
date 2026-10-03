BEGIN {
  printf("#00 British Columbia QSO Party prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com/\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) state = 2;
    if ($4 ~ /Exch1/) state = 3;
    if ($5 ~ /Exch1/) state = 4;
  # printf\("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ( \
    (IsUScall($call) && \
      $state ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    (IsVEcall($call) && ($state ~ /^(AB|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT)$/ ||\
      $state ~ /^(ASL|BNS|BUC|CHP|CKS|CLC|CML|COA|CPC|CPG|DEL|ESQ|FPK|KEL|KSC|KTN|LTF|MMA|NAL|NBM|NPR|NVC|OSK|PMC|PMM|PPN|RCM|RES|SBV|SGI|SSW|SUC|SUN|SWR|VAC|VAE|VAG|VAK|VAQ|VIC|VLM|VSB|WVS)$/)) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableVE13($call, $state))
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call))
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
