alter (chain A), resv += 19
sort
run ../../../bin/structure/pymol/supercell.py
supercell 2,1,2, 1a8y, green
hide everything
alter 1A8Y,chain='A'
alter m000_4,chain='B'
alter m000_2,chain='C'
alter m000_3,chain='D'
sele tetramer_1a8y, 1A8Y or m000_2 or m000_3 or m000_4
sele dimer_1a8y, 1A8Y or m000_4
save ./output/tetramer_1a8y.pdb, tetramer_1a8y
save ./output/dimer_1a8y.pdb, dimer_1a8y
remove hetatm
save ./output/tetramer_1a8y_no_het.pdb, tetramer_1a8y
save ./output/dimer_1a8y_no_het.pdb, dimer_1a8y
