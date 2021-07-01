awk '
BEGIN {
  FS="="
} 
{
  print $1 " " $1 " " $2
}' utfil.txt | sort | uniq > newscrub.txt
