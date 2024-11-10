BEGIN {
  FS="=";
}
{
  if (call[$1] != "" && $0 !~ /^#/) {
    printf("Duplicate entry     : \"%s\"\n", $0);
  }
  call[$1] = $1;
  if ($0 ~ /=$/) {
    printf("Problem exchange: \"%s\"\n", $0);
  }
  else {
    if ($1 ~ /^O[KLM]/) {
      if ($2 !~ /^(APA|APB|APC|APD|APE|APF|APG|APH|API|APJ|BAA|BAB|BAC|BAD|BAE|BAN|BAR|BBE|BBN|BBY|BKD|BKH|BKO|BMB|BME|BNY|BPB|BPV|BPZ|BRA|BRE|BST|BYT|CAD|CBU|CCK|CJH|CPE|CPI|CPR|CST|CTA|DCH|DDO|DET|DKL|DKU|DKV|DPJ|DPM|DPS|DRO|DSO|DST|DTA|ECH|ECL|EDE|EJA|ELI|ELO|ELT|EMO|ETE|EUL|FCR|FHB|FHK|FJI|FNA|FPA|FRK|FSE|FSV|FTR|FUO|GAL|GBL|GBM|GBR|GBV|GEL|GHO|GJI|GKR|GPR|GTR|GUH|GVY|GZL|GZN|GZS|HBR|HFM|HJE|HKA|HLO|HNJ|HOL|HOP|HOS|HPR|HSU|HUM|HVS|ILA|KEA|KEB|KEC|KED|KEO|KEZ|KNM|KOM|KRU|LEV|LMI|LUC|LVC|MAL|MAR|MED|MIC|MYJ|NAM|NIT|NMV|NZA|PAR|PBY|PEZ|PIE|POL|POP|PRE|PRI|PUC|REV|ROZ|RSO|RUZ|SAB|SAL|SEA|SEN|SKA|SLU|SNI|SNV|SOB|STR|SVI|TNC|TOP|TRE|TRN|TTE|TVR|VKR|VRT|ZAR|ZIH|ZIL|ZMO|ZVO)$/) {
        printf("Problem exchange: \"%s\"\n", $0);
      }
    } else if ($0 !~ /^(!|#|$)/) {
      printf("Problem: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {}