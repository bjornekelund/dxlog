BEGIN {
  printf("#0 !!Order!!,Call,Prec,Sect,State,CK,UserText,\n");
  printf("#0 ARRL Sweepstakes database\n");
  printf("#1 Based on data collected and maintained by AD5Q\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
BEGIN {
  FS=" "
  callcol = 1;
  preccol = 2;
  checkcol = 4;
  sectcol = 5;
}
{
    printf("%s,%s,%s,%s\n", $callcol, $preccol, $checkcol, $sectcol);
}


#!!Order!!,Call,Sect,State,CK,UserText, 
# 
# Current contest: SSCW and SSSSB
# Helping file, LOG what you copy
# Last Edit,2024-10-25
# MAR are now NB or NS, NT is TER
# Send any corrections direct to ve2fk@arrl.net
# SSCW
# SSSSB
