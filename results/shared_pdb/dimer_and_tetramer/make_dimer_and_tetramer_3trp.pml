# Identical to 1a8y
alter (chain A), resv += 19
sort
run ../../../bin/structure/pymol/supercell.py
supercell 2,1,2, 3trp, green
#show surface, 3trp
#show surface, m000_2
#show surface, m000_3
#show surface, m000_4
alter 3trp,chain='A'
alter m000_4,chain='B'
alter m000_2,chain='C'
alter m000_3,chain='D'
sele tetramer_3trp, 3trp or m000_2 or m000_3 or m000_4
sele dimer_3trp, 3trp or m000_4
save ./output/tetramer_3trp.pdb, tetramer_3trp
save ./output/dimer_3trp.pdb, dimer_3trp
remove hetatm
save ./output/tetramer_3trp_no_het.pdb, tetramer_3trp
save ./output/dimer_3trp_no_het.pdb, dimer_3trp
