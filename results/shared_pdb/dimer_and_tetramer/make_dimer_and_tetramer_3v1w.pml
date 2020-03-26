# Identical to 1a8y
run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
sort
supercell 2,1,2, 3v1w, green
show surface, 3v1w
alter 3v1w,chain='A'
alter m000_4,chain='B'
alter m000_2,chain='C'
alter m000_3,chain='D'
sele tetramer_3v1w, 3v1w or m000_2 or m000_3 or m000_4
sele dimer_3v1w, 3v1w or m000_4
save ./output/tetramer_3v1w.pdb, tetramer_3v1w
save ./output/dimer_3v1w.pdb, dimer_3v1w
remove hetatm
save ./output/tetramer_3v1w_no_het.pdb, tetramer_3v1w
save ./output/dimer_3v1w_no_het.pdb, dimer_3v1w
