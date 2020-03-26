# Identical to 1a8y
alter (chain A), resv += 19
sort
run ../../../bin/structure/pymol/supercell.py
supercell 2,1,2, 3trq, green
#show surface, 3trq
#show surface, m000_2
#show surface, m000_3
#show surface, m000_4
alter 3trq,chain='A'
alter m000_4,chain='B'
alter m000_2,chain='C'
alter m000_3,chain='D'
sele tetramer_3trq, 3trq or m000_2 or m000_3 or m000_4
sele dimer_3trq, 3trq or m000_4
save ./output/tetramer_3trq.pdb, tetramer_3trq
save ./output/dimer_3trq.pdb, dimer_3trq
remove hetatm
save ./output/tetramer_3trq_no_het.pdb, tetramer_3trq
save ./output/dimer_3trq_no_het.pdb, dimer_3trq