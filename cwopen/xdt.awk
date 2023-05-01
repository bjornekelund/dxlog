BEGIN {
  FS=","
  dupes = 0;
  col = 2;
}
{
  if ($0 ~ /!!Order!!/) {
    if ($2 ~ /UserText/) col = 1;
    if ($3 ~ /UserText/) col = 2;
    if ($4 ~ /UserText/) col = 3;
    if ($5 ~ /UserText/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    newtext = toupper($col);
    if ($1 ~ /^[0-9A-Z/]+$/ && newtext != "") {
      if (text[$1] != $col && text[$1] != newtext && text[$1] != "") {
#        printf("Replaced %s with %s for %s\n", text[$1], newtext, $1) > "/dev/stderr";
        dupes++;
      }
      text[$1] = newtext;
      calls[$1] = $1;
    }
    else if ($0 !~ /^(!|#|$)/ && newtext != "") {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  printf("#TITLE CWOps CW Open participants\n");
  for (call in calls)
    printf("%s %s\n", call, text[call]);
  printf("Overwrote %d duplicate entries.\n", dupes) > "/dev/stderr";
}
