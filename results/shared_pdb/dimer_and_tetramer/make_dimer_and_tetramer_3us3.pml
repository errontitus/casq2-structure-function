# Identical to 1a8y
run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
sort
supercell 2,1,2, 3us3, green
#show surface, 3us3
alter 3us3,chain='A'
alter m000_4,chain='B'
alter m000_2,chain='C'
alter m000_3,chain='D'
sele tetramer_3us3, 3us3 or m000_2 or m000_3 or m000_4
sele dimer_3us3, 3us3 or m000_4
save ./output/tetramer_3us3.pdb, tetramer_3us3
save ./output/dimer_3us3.pdb, dimer_3us3
remove hetatm
save ./output/tetramer_3us3_no_het.pdb, tetramer_3us3
save ./output/dimer_3us3_no_het.pdb, dimer_3us3
