BEGIN {
  FS = ",";
  maxmem = 1;
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
    basecall = _call[memberid];
    other = _others[memberid];
    name = _name[memberid];
    if (basecall ~/^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,3}$/ && basecall !~ /^DE/)
    { 
      if (basecalls[basecall] != "") 
      {
        printf("%s reappears\n", basecall) > "/dev/stderr";
      }
      basecalls[basecall] = basecall;
      basemems[basecall] = memberid;
      basenames[basecall] = name;
      delete othercalls[basecall];
      if (int(memberid) > int(maxmem)) maxmem = memberid;
      # printf("memberid > maxmem = %s memberid=%s, maxmem=%s\n", (memberid > maxmem) ? "true" : "false", memberid, maxmem) > "/dev/stderr";
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
            othercalls[basecall][othercall[i]] = otc;
            othermems[basecall][othercall[i]] = memberid;
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
    # printf("primary=%s(%s)", basecalls[bc], basemems[bc]) > "/dev/stderr";
    for (oc in othercalls[bc])
    {
      foundb = "";
      for (e in basecalls)
      {
        if (oc == e) foundb = e;
        for (oe in othercalls[e])
        {
          if (oc == oe) foundo = e;
        }
      }
      if (foundb == "")
      {
        printf("%s=%s\n", oc, basemems[bc]);
        # printf(" other=%s ", oc) > "/dev/stderr";
        ocount++
      }
      else if (foundb != "")
      {
        printf("Secondary call %s for %s already member #%s's primary call\n", oc, bc, basemems[foundb]) > "/dev/stderr";
      }
      else if (foundo != "")
      {
        printf("Secondary call %s for %s already member #%s's secondary call\n", oc, bc, basemems[foundo]) > "/dev/stderr";
      }
    }
    # printf("\n") > "/dev/stderr";
  }
  printf("%d primary calls\n", length(basecalls)) > "/dev/stderr";
  printf("%d secondary calls\n", ocount) > "/dev/stderr";

  printf("#00 DIG members prefill database\n");
  printf("#01 Based on official member roster at https://diplom-interessen-gruppe.info \n");
  printf("#03 Contains members up to #%d\n", maxmem);
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  printf("Highest member number is %d\n", maxmem) > "/dev/stderr";
}
