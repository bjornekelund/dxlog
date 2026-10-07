BEGIN {
  printf("#00 FISTS Sprint prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  addlocs = 0;
  uplocs = 0;
  upnames = 0;
  call = 2;
  member = 1;
  name = 3;
}
{
  if (call > 0 && $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/)
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
    callsign[$call] = $call;
  }
  else if ($0 !~ /^(#|!|[A-Za-z]|$)/ && $0 !~ /SWL/)
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
