BEGIN {
  FS=","
  printf("#00 Database for FISTS Sprint\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  addlocs = 0;
  uplocs = 0;
  upnames = 0;
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
    if (member > 0 && $member ~ /^[0-9]+$/ && $member != membernr[$call]) 
    {
      if (membernr[$call] != "")
      {
        printf("Updated member no of %s from %s to %s\n", $call, membernr[$call], $member) > "/dev/stderr";
      }
      membernr[$call] = $member;
    }

    if (name > 0 && $name ~ /^[A-Za-z]+$/ && toupper($name) != opname[$call] && toupper($name) !~ /CLUB/) 
    {
      if (membernr[$call] != "")
      {
        if (opname[$call] != "")
        {
          upnames++;
        }
        # printf("Updated name of %s from %s to %s\n", $call, opname[$call], toupper($name)) > "/dev/stderr";
      }
      opname[$call] = toupper($name);
    }

    if (loc > 0 && $loc ~ /^[A-Z]{2}$/ && $loc != location[$call]) 
    {
      if (location[$call] != "")
      {
        # printf("Updated location of %s from %s to %s\n", $call, location[$call], $loc) > "/dev/stderr";
        uplocs++;
      }
      else
      {
        addlocs++;
      }
      location[$call] = $loc;
    }
    # if (loc > 0 && $loc !~ /^(|AB|BC|LB|MB|NB|NF|NT|NS|NU|ON|PE|QC|SK|YT)$/) location[$call] = $loc;

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
    printf("Added %d locations and updated %d of them\n", addlocs, uplocs) > "/dev/stderr";
    printf("Updates %d names\n", upnames) > "/dev/stderr";
    for (cl in callsign)
    {
      if (membernr[cl] != "")
        printf("%s=%s;%s;%s\n", cl, opname[cl], membernr[cl], location[cl]);
    }
}
