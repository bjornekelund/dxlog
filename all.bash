#!/bin/bash

ALL="13colonies 9adx a1cwc acqp agb agcw agcwntcqp allasian alqp arqp arrl10 arrl160 arrldx arrlfd arrlrr arrlrtty arrlscr arrlss arrlvhf azqp bandebasse bcqp caqp commonwealth coqp cpqp cq160 cqmm cqww cqwwr cvadx cwt dig dok ea eacme eudxc euhfc eupsk fistsspr flqp foc frphf gagarin gaqp hacwg hadx hamspirit helvetia hiqp hsc iaqp iaru icwc-mst idqp ig-ry ilqp in7qpnede iota jarts jidxc k1usn kcj kj ksqp kyqp labredx laqp lzdx maidmay mcdqp mdqp meqp miqp mnqp moqp msqp mtqp names naqp naval ncqp ndqp neqp nhqp njqp nmqp nrau nrrl-telefoni ntc nvqp nyqp ohqp okqp onqp pabeker pacc paqp pcc podxs polar-radioman pota qcqp r4c-cup r4w-champ raem rcc rcpw rcwc rdac rdxc ref rybnickie sacw scqp sdqp spdx spdxrtty stewperry tenten tesla tnqp tpqso trc txqp ua1dz uba-dx-on-spring ukeicc ukeidx undxc urcdxrtty urdxc vaqp vtqp waqp wfd wiqp wrt wvqp wwff wwpmc yodx yu yudxc"

for contest in $ALL; do
  if [ -s "$contest/doit.bash" ]; then
    echo --- $contest ---
    cd $contest
    pwd
    ./doit.bash
    cd ..
  else
    echo $contest/doit.bash does not exist
  fi
done

exit
