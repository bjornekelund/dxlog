BEGIN {
  FS=","
  printf("#0 LZ DX Contest database\n");
  printf("#1 Based on data collected and maintained by VE2FK and R9IR\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9A-Z]/ && $3 ~ /^(BU|BL|VN|VT|VD|VR|GA|DO|KA|KD|LV|MN|PA|PK|PL|PD|RZ|RS|SS|SL|SM|SF|SO|SZ|TA|HA|SN|YA)$/) {
    if (line[$1] != "")
      printf("Duplicate entry \"%s\" and \"%s\"\n", line[$1], $1) > "/dev/stderr";
    line[$1] = $0;
    call[$1] = $1;
    ex[$1] = $3;
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "")
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  for (cl in call)
    printf("%s=%s\n", cl, ex[cl]);
}