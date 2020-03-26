# Novel
run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
alter (chain B), resv += 19
alter (chain C), resv += 19
alter (chain D), resv += 19
sort
supercell 3,1,3, 5crg, green
# show surface, m2001
alter m200_1 and chain B,chain='AA'
alter m200_1 and chain A,chain='B'
alter m200_1 and chain AA,chain='A'
#alter m200_1 and chain D,chain='CC'
#alter m200_1 and chain C,chain='D'
#alter m200_1 and chain CC,chain='C'
sele tetramer_5crg, m200_1
sele dimer_5crg, m200_1 and (chain A or chain B)
save ./output/tetramer_5crg.pdb, tetramer_5crg
save ./output/dimer_5crg.pdb, dimer_5crg
remove hetatm
save ./output/tetramer_5crg_no_het.pdb, tetramer_5crg
save ./output/dimer_5crg_no_het.pdb, dimer_5crg
