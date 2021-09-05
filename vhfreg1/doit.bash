#bin/bash
cd $(dirname $0)
FILE1=`ls VHFREG1* | tail -1 2> /dev/null`
FILE2=`ls vhf_uhf_db* | tail -1 2> /dev/null`
echo Using older file \"$FILE1\" and younger file \"$FILE2\"
./grid6.bash $FILE1 $FILE2
./grid4.bash
exit
