gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 DXLog.net FOC members data base.\n");
  printf("#1 Data contributed by Mats RM2D.\n");
  printf("#2 File last updated on %s.\n", date);
  max = 0;
  n3 = 0;
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $2 != "") {
    n3 = int($3);
    name = toupper(substr($2,1,1))tolower(substr($2,2));
    printf("%s=%s;%s\n", $1, name, $3);
#    printf("$3 string=%s, $3 number=%d, max=%d\n", $3, $3, max) > "/dev/stderr";
    max = (n3 > max) ? n3 : max;
  }
}
END {
  printf("#3 Contains members up to #%d\n", max);
}' $1 | sort | sed 's/^\#. /\# /g' > FOC_db.txt
unix2dos FOC_db.txt
