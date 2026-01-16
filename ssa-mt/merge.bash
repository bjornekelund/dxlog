awk '
BEGIN {
  FS = "=";
} 
{
  callist[$1]=$1
  gridlist[$1]=$2
} 
END {
  for (c in callist) 
    printf("%s %s %s\n", callist[c], callist[c], gridlist[c]);
}' _ejssagridqrzscrub.txt _ssacallbook.txt _ejssagridqrzscrub.txt _supercheckqrzscrub.txt _faktisktanvanda.txt | sort > MASTER3.txt

awk '
BEGIN {
  FS = " ";
} 
{
  gridlist[$1]=$3;
  callist[$1]=$2;
} 
END { 
  printf("#1\n");
  printf("#2 Pre-fill data base for SSA Monthly Contest\n");
  printf("#3 By SM7IUN with great help from SM5AJV and SM0HJZ\n");
  printf("#4 Last updated 2019-08-29\n");
  printf("#5\n");
  for (c in callist)
  {
    grid = (gridlist[c] == "?") ? gridlist[callist[c]] : gridlist[c];
    if (grid != "" && grid != "?" && 
        substr(callist[c],1,1) == "S" && (substr(grid,1,1) == "J" || substr(grid,1,1) == "K"))
      printf("%s=%s\n", c, grid);  
  }
}' MASTER3.txt SSA_special.txt | sort | uniq > _SSA_MT_db.txt
