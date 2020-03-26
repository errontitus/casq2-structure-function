# Novel
run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
alter (chain B), resv += 19
alter (chain C), resv += 19
sort
supercell 2,1,2, 5kn1, green
# show surface, 5kn1
alter m000_6 and chain C,chain='D'
alter m000_6 and chain B,chain='C'
alter m000_6 and chain A,chain='B'
remove hetatm
sele tetramer_5kn1, (m000_6 or (m000_8 and (chain A))) 
sele dimer_5kn1, (m000_8 and chain A) or (m000_6 and chain B)
hide everything, not tetramer_5kn1
orient tetramer_5kn1
save ./output/tetramer_5kn1.pdb, tetramer_5kn1
save ./output/dimer_5kn1.pdb, dimer_5kn1
remove hetatm
save ./output/tetramer_5kn1_no_het.pdb, tetramer_5kn1
save ./output/dimer_5kn1_no_het.pdb, dimer_5kn1
