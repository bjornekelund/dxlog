BEGIN {
  printf("#00 Minnesota QSO Party prefill database\n");
  FS = ",";
  longest = "";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    state = FindColumn("State|Exch1");
    name = FindColumn("Name");
    # printf("%s --> call=%d state=%d name=%d\n", $0, call, state, name) > "/dev/stderr";
  }
  else if (IsUScall($call) || IsVEcall($call))
  {   
    if ( \
      ((IsUScall($call) && \
        ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IA|IN|KS|KY|LA|ME|MD|MA|MI|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|)$/ || \
        $state ~ /^(AIT|ANO|BEC|BEL|BEN|BIG|BLU|BRO|CAS|CHP|CHS|CLA|CLE|COO|COT|CRL|CRO|CRV|DAK|DOD|DOU|FAI|FIL|FRE|GOO|GRA|HEN|HOU|HUB|ISA|ITA|JAC|KIT|KNB|KND|KOO|LAC|LAK|LES|LIN|LKW|LYO|MAH|MCL|MEE|MIL|MOR|MOW|MRS|MRT|MUR|NIC|NOB|NOR|OLM|OTT|PEN|PIN|PIP|POL|POP|RAM|RDL|RDW|REN|RIC|ROC|ROS|SCO|SHE|SIB|STE|STL|STR|STV|SWI|TOD|TRA|WAB|WAD|WAT|WIL|WIN|WRI|WSC|WSH|YEL)(\/(AIT|ANO|BEC|BEL|BEN|BIG|BLU|BRO|CAS|CHP|CHS|CLA|CLE|COO|COT|CRL|CRO|CRV|DAK|DOD|DOU|FAI|FIL|FRE|GOO|GRA|HEN|HOU|HUB|ISA|ITA|JAC|KIT|KNB|KND|KOO|LAC|LAK|LES|LIN|LKW|LYO|MAH|MCL|MEE|MIL|MOR|MOW|MRS|MRT|MUR|NIC|NOB|NOR|OLM|OTT|PEN|PIN|PIP|POL|POP|RAM|RDL|RDW|REN|RIC|ROC|ROS|SCO|SHE|SIB|STE|STL|STR|STV|SWI|TOD|TRA|WAB|WAD|WAT|WIL|WIN|WRI|WSC|WSH|YEL))?$/)) || \
        (IsVEcall($call) && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|)$/)) && \
      $name ~ /^([A-Z][A-Za-z]+|)$/)
    {
      if (NotPredictableVE13($call, $state))
      {
        calls[$call] = $call;
        if (names[$call] == "") names[$call] = toupper($name);
        if (states[$call] == "") states[$call] = $state;
        longest = length($name) > length(longest) ? toupper($name) : longest;
      }
    }
  }
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call) && $state != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (c in calls)
  {
      printf("%s=%s;%s\n", c, names[c], states[c]);
  }
  printf("Collected %d calls\n", length(calls)) > "/dev/stderr";
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#04 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}
