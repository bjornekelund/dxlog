#!/bin/bash
dos2unix -q $1
./names-n1mmtodxlog-xdt.bash $1
exit
