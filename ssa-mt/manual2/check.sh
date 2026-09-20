FILE1=SSA_MT_db.txt
FILE2=ssa_mt.se5e.txt

dos2unix -q $FILE1 $FILE2


cat $FILE1 $FILE2 | awk '
BEGIN {
  FS = "=";
}
{
  call = $1;
  grid = $2;
  if (callist[call] != "" && gridlist[call] != grid)
  {
    printf("Correction: %s = %s\n", call, grid) >> "/dev/stderr";
  }
  callist[call]=call;
  gridlist[call]=grid;
}
END {
}'

