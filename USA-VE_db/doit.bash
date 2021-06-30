gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 NA state/province prefill database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", date);
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $2 != "" && $3 != "") {
    printf("%s=%s\n", $1, $3);
  }
}
END { }' CQ160CW.txt | sort | more > USA-VE_db.txt
unix2dos USA-VE_db.txt
