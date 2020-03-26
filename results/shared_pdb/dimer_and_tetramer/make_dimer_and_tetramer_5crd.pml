# Identical to 1a8y but with different origin
run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
sort
supercell 2,1,2, 5crd, green
# show surface, m000_5
# show surface, m000_8
# show surface, m000_6
# show surface, m000_7
alter m000_5,chain='A'
alter m000_8,chain='B'
alter m000_6,chain='C'
alter m000_7,chain='D'
sele tetramer_5crd, m000_5 or m000_8 or m000_6 or m000_7
sele dimer_5crd, m000_5 or m000_8
save ./output/tetramer_5crd.pdb, tetramer_5crd
save ./output/dimer_5crd.pdb, dimer_5crd
remove hetatm
save ./output/tetramer_5crd_no_het.pdb, tetramer_5crd
save ./output/dimer_5crd_no_het.pdb, dimer_5crd
