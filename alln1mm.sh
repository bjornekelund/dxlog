ALL="a1cwc acqp agb agcw agcwntcqp allasian alqp aoec160 aridx arqp arrl10 arrl160 arrldxcw arrldxssb arrlfd arrlrr arrlrtty arrlscr arrlsscw arrlssssb arrlvhf aschamp azqp bandebasse bccqp bcqp caqp commonwealth coqp cpqp cq160 cqmm cqvojvodina cqww cqwwr croatiandx cvadx cwt dig dok ea eacme eudxc euhfc eupsk fistsspr flqp foc frphf gagarin gaqp hacwg hadx hamspirit helvetia hiqp hsc iaqp iaru icwc-mst idqp ig-ry ilqp in7qpnede iota jarlwwrtty jidxc k1usn kcj kj ksqp kyqp labredx laqp lzdx maidmay mcdqp mdqp meqp miqp mnqp moqp msqp mtqp names naqp naval ncqp ndqp neqp nhqp njqp nmqp nrau nrrl-telefoni ntc nvqp nyqp ohqp ok-om okqp onqp pabeker pacc paqp pcc podxs polar-radioman qcqp r4c-cup r4w-champ radioylom raem rcc rcpw rcwc rdac rdxc ref rybnickie sacw scqp scwc sdqp spdx spdxrtty spotc ssa-mt stewperry tenten thirteencolonies tnqp tpqso trc txqp ua1dz ua2qp uba-dx-on-spring uft ukeicc ukeidx undxc uqrqc urcdxrtty urdxc vaqp vhfreg1 vidovdan vojvodina vtqp wapc waqp wfd wiqp wrt wtzc wvqp wwff wwpmc xertty yodx yota yu yudxc"
#ALL="a1cwc acqp agb agcw agcwntcqp allasian alqp aoec160 aridx arqp arrl10 arrl160 arrldxcw arrldxssb arrlfd arrlrr"

#!/bin/bash
DIR=`pwd`
for contest in $ALL; do
  echo -------- $contest
  ./n1mm.sh $contest 1
done
exit 0