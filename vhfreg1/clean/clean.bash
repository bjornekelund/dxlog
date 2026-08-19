#!/bin/bash
BASEFILES="VHFREG1-20230428.txt VHFREG1-20240910.txt"
LOCAL=LOCAL.txt

INFILE=VHFREG1_NEW.txt

OUTFILE=VHFREG1-001.txt
OUTFILE4=VHFREG1_4-001.txt

dos2unix -q $BASEFILES $INFILE $LOCAL

echo Creating 6-position grid database by parsing $FILE1

# Create 6-position grid file

cat $BASEFILES $INFILE $LOCAL | gawk '
BEGIN {
  printf("!!Order!!,Call,Loc1,UserText,\n");
  printf("# VHF/UHF 6-position grid data base\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  ignored = 0;
}
{
  call = toupper($1);
  callok = call ~ /^[0-9]?[A-Z]+[0-9]+[A-Z]+$/;
  name = toupper($2);
  grid1 = toupper($3);
  grid1ok = grid1 ~ /^[A-R]{2}[0-9]{2}[A-X]{2}$/
  grid2 = toupper($4);
  grid2ok = grid2 ~ /^[A-R]{2}[0-9]{2}[A-X]{2}$/
  if (callok == 0)
  {
#    printf("Bad call in: \"%s\"\n", $0) > "/dev/stderr";
    ignored++;
  }
  else if (grid1ok == 0)
  {
#    if (grid1 != "") printf("Bad grid in: \"%s\"\n", $0) > "/dev/stderr";
    ignored++;
  }
  else if (grid2ok && grid1 != grid2)
  {
#    printf("Disagreeing grids for %s: %s and %s\n", $1, grid1, grid2) > "/dev/stderr";
    ignored++;
  }
  else
  {
    calls[call] = call;
    names[call] = name;
    grids[call] = grid1;
  }
}
END {
  printf("%d calls ignored in file\n", ignored) > "/dev/stderr";
  for (c in calls)
  {
    printf("%s,%s,%s,\n", c, grids[c], names[c]);
  }
}' > $OUTFILE

echo Created $OUTFILE with `cat $OUTFILE | wc -l` calls

echo ----
# Derive 4-position grid file

echo Creating 4-position grid database by parsing $FILE

cat $BASEFILES $INFILE $LOCAL | gawk '
BEGIN {
  printf("!!Order!!,Call,Loc1,UserText,\n");
  printf("# VHF/UHF 4-position grid data base\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  ignored = 0;
}
{
  call = toupper($1);
  callok = call ~ /^[0-9]?[A-Z]+[0-9]+[A-Z]+$/
  name = toupper($2);
  grid1 = toupper($3);
  grid1ok = grid1 ~ /^[A-R]{2}[0-9]{2}/
  grid2 = toupper($4);
  grid2ok = grid2 ~ /^[A-R]{2}[0-9]{2}/
  if (callok == 0)
  {
#    printf("Bad call in: \"%s\"\n", $0) > "/dev/stderr";
    ignored++;
  }
  else if (grid1ok == 0)
  {
#    if (grid1 != "") printf("Bad grid in: \"%s\"\n", $0) > "/dev/stderr";
    ignored++;
  }
  else if (grid2ok && grid1 != grid2)
  {
#    printf("Disagreeing grids for %s: %s and %s\n", $1, grid1, grid2) > "/dev/stderr";
    ignored++;
  }
  else
  {
    calls[call] = call;
    names[call] = name;
    grids[call] = substr(grid1, 0, 4);
  }
}
END {
  printf("%d calls ignored in file\n", ignored) > "/dev/stderr";
  for (c in calls)
  {
    printf("%s,%s,%s,\n", c, grids[c], names[c]);
  }
}' > $OUTFILE4


unix2dos -q $OUTFILE $OUTFILE4

echo Created $OUTFILE4 with `cat $OUTFILE4 | wc -l` calls

exit
