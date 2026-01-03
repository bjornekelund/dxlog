BEGIN {
  FS=","
  printf("#00 LZ DX Contest database\n");
  printf("#01 Based on data collected and maintained by VE2FK and R9IR\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  call = 1;
  col = 3;
  if ( \
    $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $col ~ /^(BU|BL|VN|VT|VD|VR|GA|DO|KA|KD|LV|MN|PA|PK|PL|PD|RZ|RS|SS|SL|SM|SF|SO|SZ|TA|HA|SN|YA)$/) 
  {
    if (line[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
    }
    else
    {
      line[$call] = $0;
      printf("%s=%s\n", $call, $col);
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
