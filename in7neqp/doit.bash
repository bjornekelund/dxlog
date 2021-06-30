#/bin/bash
dos2unix $1
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 INQP, DEQP, 7QP, and NEQP joint database.\n");
  printf("#1 Based on call history data by Claude VE2FK.\n");
  printf("#2 Created %s.\n", date);
  printf("#3\n");
}
{
  if ($1 ~ /^[0-9,A-Z,\/]+$/ && ($3 ~ /[A-Z]{2}/ || $3 ~/[A-Z]{5}/))
    printf("%s=%s\n", $1, $3);
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' $1 | sort | sed 's/^#[0-9]/#/g' > IN7NEQP_db.txt
unix2dos IN7NEQP_db.txt
