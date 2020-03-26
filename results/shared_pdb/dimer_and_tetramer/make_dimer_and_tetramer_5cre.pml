# Novel
run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
sort
supercell 2, 2, 2, 5cre, green
# show surface, 5cre
# m100_3
# m100_4
# m001_2
# m111_1
alter m100_3,chain='A'
alter m100_4,chain='B'
alter m001_2,chain='C'
alter m111_1,chain='D'
sele tetramer_5cre, m100_3 or m100_4 or m001_2 or m111_1
sele dimer_5cre, m100_3 or m100_4
save ./output/tetramer_5cre.pdb, tetramer_5cre
save ./output/dimer_5cre.pdb, dimer_5cre
remove hetatm
save ./output/tetramer_5cre_no_het.pdb, tetramer_5cre
save ./output/dimer_5cre_no_het.pdb, dimer_5cre
