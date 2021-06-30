#!/bin/bash
cd $(dirname $0)
dos2unix $1
./names-n1mmtodxlog-xdt.bash $1
exit
