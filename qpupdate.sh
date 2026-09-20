#!/bin/bash

QPFILES="acqp alqp arqp azqp bcqp caqp coqp cpqp flqp gaqp hiqp iaqp idqp ilqp ksqp kyqp laqp mdqp meqp miqp mnqp moqp msqp mtqp naqp ncqp ndqp neqp nhqp njqp nmqp nvqp nyqp ohqp okqp onqp paqp qcqp scqp sdqp tnqp txqp vaqp vtqp waqp wiqp wvqp"

for contest in $QPFILES; do
  echo -------- $contest
  cd $contest
  pwd
  ./doit.sh
  cd ..
done

exit

