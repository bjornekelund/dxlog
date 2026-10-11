BEGIN {
  FS = ",";
  maxmem = 1;
  PROCINFO["sorted_in"] = "@ind_num_desc";
}
{
  if ($3 ~ /^[0-9]{4}$/ && $2 ~ /J/)
  {
    _memid[$3] = $3;
    _call[$3] = $4;
    _others[$3] = $5;  
    _name[$3] = $6;
  }
}
END {
  for (memberid in _memid)
  {
    primarycall = _call[memberid];
    other = _others[memberid];
    name = _name[memberid];
    if (primarycall ~/^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,3}$/ && primarycall !~ /^DE/)
    { 
      if (primarycalls[primarycall] != "") 
      {
        printf("%s reappears\n", primarycall) > "/dev/stderr";
      }
      primarycalls[primarycall] = primarycall;
      primarynumbers[primarycall] = memberid;
      delete secondarycalls[primarycall];
      if (int(memberid) > int(maxmem)) maxmem = memberid;
      if (other != "")
      {
        count = split(toupper(other), seccalls, " ")
        for (i = 1; i <= count; i++)
        {
          secc = seccalls[i];
          if (secc == "S560R") secc = "S56OR";
          if (secc == "DL6ES(Y43)") secc = "DL6ES";
          if (secc == "VIA_DF4UM") secc = "DF4UM";
          if (secc ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,4}[A-Z]{1,3}$/ && secc !~ /^DE/)
          {
            secondarycalls[primarycall][secc] = secc;
          }
          else if (secc !~ /SWL|\-|^DE|[0-9]$|^[A-Z]$|CALL|/)
          {
            printf("Ignored other call: \"%s\" in \"%s\"\n", secc, $0) > "/dev/stderr";
          }
        }
      }
    }
    else if (primarycall !~ /SWL|\-|^DE|[0-9]$|CALL/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  seccount = 0;
  for (pc in primarycalls)
  {
    printf("%s=%s\n", primarycalls[pc], primarynumbers[pc]);
    # printf("primary=%s(%s)", primarycalls[pc], primarynumbers[pc]) > "/dev/stderr";
    for (sc in secondarycalls[pc])
    {
      foundb = "";
      for (e in primarycalls)
      {
        if (sc == primarycalls[e]) foundb = e;
        for (oe in secondarycalls[e])
        {
          if (sc == secondarycalls[e][oe]) foundo = e;
        }
      }
      if (foundb == "")
      {
        printf("%s=%s\n", sc, primarynumbers[pc]);
        # printf(" other=%s ", sc) > "/dev/stderr";
        seccount++
      }
      else if (foundb != "")
      {
        printf("Secondary call %s for %s already member #%s's primary call\n", sc, pc, primarynumbers[foundb]) > "/dev/stderr";
      }
      else if (foundo != "")
      {
        printf("Secondary call %s for %s already member #%s's secondary call\n", sc, pc, primarynumbers[foundo]) > "/dev/stderr";
      }
    }
    # printf("\n") > "/dev/stderr";
  }
  printf("%d primary calls\n", length(primarycalls)) > "/dev/stderr";
  printf("%d secondary calls\n", seccount) > "/dev/stderr";

  printf("#00 DIG members prefill database\n");
  printf("#01 Based on official member roster at https://diplom-interessen-gruppe.info \n");
  printf("#03 Contains members up to #%d\n", maxmem);
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  printf("Highest member number is %d\n", maxmem) > "/dev/stderr";
}
