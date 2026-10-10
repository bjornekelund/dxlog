BEGIN {
  FS = ",";
  maxmem = 1;
}
{
  if ($3 ~ /^[0-9]+$/ && $2 ~ /J/)
  {
    m = int($3);
    _memid[m] = m;
    _call[m] = $4;
    _others[m] = $5;  
    _name[m] = $6;
  }
}
END {
  for (memberid in _memid)
  {
    basecall = _call[memberid];
    other = _others[memberid];
    name = _name[memberid];
    if (basecall ~/^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,3}$/ && basecall !~ /^DE/)
    { 
      if (basecalls[basecall] != "" && basemems[basecall] != memberid) 
      {
        printf("%s %s #%d is QRT and superseded by %s %s #%d\n", basenames[basecall], basecall, basemems[basecall], name, basecall, memberid, name) > "/dev/stderr";
      }
      basecalls[basecall] = basecall;
      basemems[basecall] = memberid;
      basenames[basecall] = name;
      delete othercalls[basecall];
      if (int(memberid) > int(maxmem)) maxmem = memberid;
      # printf("memberid > maxmem = %s memberid=%d, maxmem=%d\n", (memberid > maxmem) ? "true" : "false", memberid, maxmem) > "/dev/stderr";
      if (other != "")
      {
        count = split(toupper(other), othercall, " ")
        for (i = 1; i <= count; i++)
        {
          otc = othercall[i];
          if (otc == "S560R") otc = "S56OR";
          if (otc == "DL6ES(Y43)") otc = "DL6ES";
          if (otc == "VIA_DF4UM") otc = "DF4UM";
          if (otc ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,4}[A-Z]{1,3}$/ && otc !~ /^DE/)
          {
            if (othercalls[basecall][othercall[i]] != "") 
            {
              printf("Secondary call %s is superseded: \"%s\"\n", otc, $0) > "/dev/stderr";
            }
            else
            {
              othercalls[basecall][othercall[i]] = otc;
              othermems[basecall][othercall[i]] = memberid;
            }
            # printf("$4=\"%s\" $5=\"%s\" => call[%d]=\"%s\"\n", $4, $5, i, call[i]) > "/dev/stderr";
          }
          else if (otc !~ /SWL|\-|^DE|[0-9]$|^[A-Z]$|CALL|/)
          {
            printf("Ignored other call: \"%s\" in \"%s\"\n", otc, $0) > "/dev/stderr";
          }
        }
      }
    }
    else if (basecall !~ /SWL|\-|^DE|[0-9]$|CALL/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }

  }

  ocount = 0;
  for (bc in basecalls)
  {
    printf("%s=%s\n", basecalls[bc], basemems[bc]);
    for (oc in othercalls[bc])
    {
      foundb = "";
      for (e in basecalls)
      {
        if (oc == e) foundb = e;
      }
      if (foundb == "")
      {
        printf("%s=%s\n", oc, basemems[bc]);
        ocount++
      }
      else
      {
        printf("Secondary call %s for %s already member #%d's primary call\n", oc, bc, basemems[foundb]) > "/dev/stderr";
      }
    }
  }
  printf("%d primary calls\n", length(basecalls)) > "/dev/stderr";
  printf("%d secondary calls\n", ocount) > "/dev/stderr";

  printf("#00 DIG members prefill database\n");
  printf("#01 Based on official member roster at https://diplom-interessen-gruppe.info \n");
  printf("#03 Contains members up to #%d\n", maxmem);
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  printf("Highest member number is %d\n", maxmem) > "/dev/stderr";
}
