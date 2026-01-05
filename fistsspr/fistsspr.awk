BEGIN {
  FS=","
  printf("#00 Database for FISTS Sprint\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/) 
  {
    member = 0;
    name = 0;
    loc = 0;
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($2 ~ /Misc/) member = 1;
    if ($3 ~ /Misc/) member = 2;
    if ($4 ~ /Misc/) member = 3;
    if ($5 ~ /Misc/) member = 4;
    if ($2 ~ /Name/) name = 1;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    if ($2 ~ /Exch1/) loc = 1;
    if ($3 ~ /Exch1/) loc = 2;
    if ($4 ~ /Exch1/) loc = 3;
    if ($5 ~ /Exch1/) loc = 4;
    printf("%s --> call=%d, member=%d, name=%d, loc=%d\n", $0, call, member, name, loc) > "/dev/stderr";
  }
  else if (call > 0 && $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/)
  {
    if ($call == "2E0AAO" && name > 0)
      printf("%s name=%d $name=%s\n", $call, name, $name) > "/dev/stderr";

    if (member > 0 && $member ~ /^[0-9]+$/) membernr[$call] = $member;
    if (name > 0 && $name ~ /^[A-Za-z]+$/) opname[$call] = toupper($name);
    if (loc > 0 && $loc ~ /^[A-Z]{2}$/) location[$call] = $loc;
    # if (loc > 0 && $loc !~ /^(|AB|BC|LB|MB|NB|NF|NT|NS|NU|ON|PE|QC|SK|YT)$/) location[$call] = $loc;

    if (callsign[$call] != "" && $call == "2E0AAO")
      printf("%s updated name=%s mem=%s loc=%s\n", $call, opname[$call], membernr[$call], location[$call]) > "/dev/stderr";

    callsign[$call] = $call;

# if (name > 0)
#     printf("callsign[%s]=%s opname[%s]=%s\n", $call, callsign[$call], $call, opname[$call]) > "/dev/stderr";

    # if (call ~ /^[0-9A-Z/]+$/ && mem ~ /^([0-9]{1,5}|)$/ && name ~ /^([A-Z]{2,})$/) 
    # {
    #   printf("%s=%s;%s\n", call, name, mem);
    # }
    # else if ($0 !~ /^(!|#|$)/) 
    # {
    #   printf("ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
  else if ($0 !~ /^(#|!|$)/ && $0 !~ /SWL/)
  {
      printf("ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
    for (cl in callsign)
    {
      if (membernr[cl] != "")
        printf("%s=%s;%s;%s\n", cl, opname[cl], membernr[cl], location[cl]);
    }
}
