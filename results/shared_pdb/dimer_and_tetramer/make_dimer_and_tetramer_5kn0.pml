run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
alter (chain B), resv += 19
alter (chain C), resv += 19
alter (chain D), resv += 19
sort
supercell 2,1,2, 5kn0, green
# show surface, 5kn0
alter m000_1 and chain B,chain='AA'
alter m000_1 and chain A,chain='B'
alter m000_1 and chain AA,chain='A'
alter m000_1 and chain C,chain='C'
alter m000_1 and chain D,chain='D'
sele tetramer_5kn0, m000_1
sele dimer_5kn0, m000_1 and (chain A or chain B)
hide everything, not tetramer_5crh
orient m000_1
save ./output/tetramer_5kn0.pdb, tetramer_5kn0
save ./output/dimer_5kn0.pdb, dimer_5kn0
remove hetatm
save ./output/tetramer_5kn0_no_het.pdb, tetramer_5kn0
save ./output/dimer_5kn0_no_het.pdb, dimer_5kn0
