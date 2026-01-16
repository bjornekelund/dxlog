awk '
BEGIN {
  FS = " ";
} 
{
  gridlist[$1]=$3;
  callist[$1]=$2;
} 
END { 
  for (c in callist)
  { 
    grid = (gridlist[c] == "?") ? gridlist[callist[c]] : gridlist[c];
    if (grid == "" && substr(callist[c],1,1) == "S")
      printf("%s\n", callist[c]);  
#    printf("Call=%s Grid=%s\n", c, grid); 
  }
}' SSA_master.txt SSA_special.txt | sort | more
