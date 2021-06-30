#!/bin/bash
cd $(dirname $0)
dos2unix $1
./iota-n1mmtodxlog-txt.bash $1
./iota-n1mmtodxlog-xdt.bash $1
#mv $1 used-file-$1
exit
