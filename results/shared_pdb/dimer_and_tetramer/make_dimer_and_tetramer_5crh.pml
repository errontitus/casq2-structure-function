# Novel
run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
alter (chain B), resv += 19
sort
supercell 3,1,3, 5crh, green
# show surface, 5crh
# show surface, m000_2
alter m200_2 and chain B,chain='AA'
alter m200_2 and chain A,chain='B'
alter m200_2 and chain AA,chain='A'
alter m200_1 and chain A,chain='C'
alter m200_1 and chain B,chain='D'
sele tetramer_5crh, m200_1 or m200_2
sele dimer_5crh, m200_2
hide everything, not tetramer_5crh
orient m200_1
save ./output/tetramer_5crh.pdb, tetramer_5crh
save ./output/dimer_5crh.pdb, dimer_5crh
remove hetatm
save ./output/tetramer_5crh_no_het.pdb, tetramer_5crh
save ./output/dimer_5crh_no_het.pdb, dimer_5crh
