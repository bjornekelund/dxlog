BEGIN {
  printf("#00 AGCW-NTC Friendship QSO Party prefill database\n");
  printf("#01 Based on online membership data\n");
  printf("#05 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  maxname ="";
  maxntc = 0;
  maxagcw = 0;
  call = 1;
  name = 2;
  agcw = 3;
  ntc = 4;
}
{
  callok = $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/;
  nameok = $name ~ /^([A-Za-z]{2,10}|)$/ && $name !~ /[Cc][Ll][Uu][Bb]/;
  memok = $agcw ~ /^AGCW[1-9][0-9]{0,3}$|^$/ && $ntc ~ /^NTC[1-9][0-9]{0,3}$|^$/;

  if (callok && memok)
  {
    if (nameok)
    {
      rname = toupper($name);
    }
    else
    {
      # printf("AGCWNTCQP: Problem name ignored: \"%s\"\n", $0) > "/dev/stderr";
      rname = "";
    }

    calls[$call] = $call;
    names[$call] = rname;

    if ($agcw != "")
    {
      # printf("AGCWNTCQP: AGCW found: \"%s\"\n", $0) > "/dev/stderr";

      nagcw = $agcw;
      gsub(/[^0-9]/, "", nagcw);
      if (int(nagcw) > maxagcw)
      {       
        maxagcw = int(nagcw);
      }

      if (firsts[$call] == "")
      {
        firsts[$call] = $agcw;
        seconds[$call] = $ntc;
      }
      else
      {
        if (firsts[$call] ~ /^NTC/)
        {
          seconds[$call] = firsts[$call];
          firsts[$call] = $agcw;
        }
        else
        {
          if (firsts[$call] != $agcw)
          {
            printf("AGCWNTCQP: Conflict agcw: previous %s new %s \"%s\"\n", $0, firsts[$call], $agcw) > "/dev/stderr";
          }
        }
      }
    }

    if ($ntc != "")
    {
      # printf("QP: NTC found: \"%s\"\n", $0) > "/dev/stderr";

      nntc = $ntc;
      gsub(/[^0-9]/, "", nntc);
      if (int(nntc) > maxntc)
      {       
        maxntc = int(nntc);
      }

      # printf("QP: \"%s\" -> nntc=%d\n", $0, nntc + 0) > "/dev/stderr";

      if (firsts[$call] == "")
      {
        firsts[$call] = $ntc;
        seconds[$call] = "";
      }
      else
      {
        if (firsts[$call] ~ /^AGCW/)
        {
          if (seconds[$call] != "" && seconds[$call] != $ntc)
          {
            printf("AGCWNTCQP: Conflict ntc: \"%s\"\n", $0) > "/dev/stderr";
          }
          else
          {
            seconds[$call] = $ntc;
          }
        }
      }
    }
    
    if (length($name) > length(maxname) && nameok)
    {
      maxcall = $call;
      maxname = rname;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    if (nameok)
      printf("AGCWNTCQP: Problem entry: \"%s\"\n", $0) > "/dev/stderr";
      # printf("") > "/dev/stderr";
    else
      printf("AGCWNTCQP: Problem name:  \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (c in calls)
  {
    if (firsts[c] != "")
    {
      printf("%s=%s;%s;%s\n", calls[c], names[c], firsts[c], seconds[c]);
    }
  }
  printf("---------------------\n") > "/dev/stderr";
  printf("Contains members up to AGCW #%d and NTC #%d\n", maxagcw, maxntc) > "/dev/stderr";
  printf("#02 Contains members up to AGCW #%d and NTC #%d\n", maxagcw, maxntc);
  printf("%s has the longest name: \"%s\" with %d characters\n", maxcall, maxname, length(maxname)) > "/dev/stderr";
  printf("#03 %s has the longest name: \"%s\" with %d characters\n", maxcall, maxname, length(maxname));
}