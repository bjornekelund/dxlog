BEGIN {
  FS=","
  printf("#0 Database for FISTS Sprint\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 == "!!Order!!") 
  {
    if ($2 ~ /Call/) callcol = 1; else
    if ($3 ~ /Call/) callcol = 2; else
    if ($4 ~ /Call/) callcol = 3; else
    if ($5 ~ /Call/) callcol = 4; else callcol = 0;

    if ($2 ~ /Misc/) memcol = 1; else
    if ($3 ~ /Misc/) memcol = 2; else
    if ($4 ~ /Misc/) memcol = 3; else
    if ($5 ~ /Misc/) memcol = 4; else memcol = 0;

    if ($2 ~ /Name/) namecol = 1; else
    if ($3 ~ /Name/) namecol = 2; else
    if ($4 ~ /Name/) namecol = 3; else
    if ($5 ~ /Name/) namecol = 4; else namecol = 0;

    if ($2 ~ /Exch1/) loccol = 1; else
    if ($3 ~ /Exch1/) loccol = 2; else
    if ($4 ~ /Exch1/) loccol = 3; else
    if ($5 ~ /Exch1/) loccol = 4; else loccol = 0;

    printf("%s --> call=%d, mem=%d, name=%d, loc=%d\n", $0, callcol, memcol, namecol, loccol) > "/dev/stderr";
  }
  else if ($0 !~ /^#/ && $callcol !~ /SWL/){
      # printf("%s mem=%d $mem=%s\n", $callcol, memcol, $memcol) > "/dev/stderr";

    if (memcol > 0 && $memcol != "") member[$callcol] = $memcol;
    if (namecol > 0 && $namecol != "" && $namecol ~ /^[A-Za-z]+$/) name[$callcol] = toupper($namecol);
    if (loccol > 0 && $loccol !~ /^(|AB|BC|LB|MB|NB|NF|NT|NS|NU|ON|PE|QC|SK|YT)$/) location[$callcol] = $loccol;

    # if (callsign[$callcol] != "")
    #   printf("%s updated name=%s mem=%s loc=%s\n", $callcol, name[$callcol], member[$callcol], location[$callcol]) > "/dev/stderr";

    callsign[$callcol] = $callcol;

# if (namecol > 0)
#     printf("callsign[%s]=%s name[%s]=%s\n", $callcol, callsign[$callcol], $callcol, name[$callcol]) > "/dev/stderr";


    # if (call ~ /^[0-9A-Z/]+$/ && mem ~ /^([0-9]{1,5}|)$/ && name ~ /^([A-Z]{2,})$/) {
    #   printf("%s=%s;%s\n", call, name, mem);
    # }
    # else if ($0 !~ /^(!|#|$)/) {
    #   printf("ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END{
    for (call in callsign)
    {
      if (member[call] != "")
        printf("%s=%s;%s;%s\n", call, name[call], member[call], location[call]);
    }
}
