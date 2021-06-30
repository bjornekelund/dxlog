#bin/bash
dos2unix $1
gawk '
BEGIN {
  FS=",";
  prevcall = "";
}
{
  call = $1;
  if (call ~ /^[0-9,A-Z\/]+$/) {
    if (call == prevcall) 
      printf("Dupe: \"%s\"\n", $0) > "/dev/stderr"
    else if ($3 != "" && $4 == "")
      printf("%s=%s\n", $1, $3);
    else if ($4 != "")
      printf("%s=%s\n", $1, $4);
    else
      printf("Info missing: \"%s\"\n", $0) > "/dev/stderr"
  }
  else
    printf("Ignore: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
  printf("#0 ARRL DX database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > ARRL_DX_db.txt

echo "ARRL_DX_db.txt created"
unix2dos ARRL_DX_db.txt
exit
