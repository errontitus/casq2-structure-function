# Identical to 1a8y but with different origin
run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
sort
supercell 2,1,2, 5kn3, green
# show surface, 5kn3
alter m000_5,chain='A'
alter m000_8,chain='B'
alter m000_6,chain='C'
alter m000_7,chain='D'
sele tetramer_5kn3, m000_5 or m000_8 or m000_6 or m000_7
sele dimer_5kn3, m000_5 or m000_8
save ./output/tetramer_5kn3.pdb, tetramer_5kn3
save ./output/dimer_5kn3.pdb, dimer_5kn3
remove hetatm
save ./output/tetramer_5kn3_no_het.pdb, tetramer_5kn3
save ./output/dimer_5kn3_no_het.pdb, dimer_5kn3
