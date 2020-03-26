run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
alter (chain B), resv += 19
alter (chain C), resv += 19
alter (chain D), resv += 19
alter (chain E), resv += 19
alter (chain F), resv += 19
sort
supercell 2,1,2, 3uom, green
# show surface, 3uom
alter 3uom and chain A,chain='A'
alter 3uom and chain B,chain='B'
alter 3uom and chain C,chain='C'
alter 3uom and chain D,chain='D'
sele tetramer_3uom, 3uom and ((chain A) or (chain B) or (chain C) or (chain D))
sele dimer_3uom, 3uom and ((chain A) or (chain B))
save ./output/tetramer_3uom.pdb, tetramer_3uom
save ./output/dimer_3uom.pdb, dimer_3uom
remove hetatm
save ./output/tetramer_3uom_no_het.pdb, tetramer_3uom
save ./output/dimer_3uom_no_het.pdb, dimer_3uom