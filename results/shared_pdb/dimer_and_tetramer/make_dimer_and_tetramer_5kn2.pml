# Identical to 5kn1
run ../../../bin/structure/pymol/supercell.py
alter (chain A), resv += 19
alter (chain B), resv += 19
alter (chain C), resv += 19
sort
supercell 2,1,2, 5kn2, green
# show surface, 5kn2
alter m000_6 and chain C,chain='D'
alter m000_6 and chain B,chain='C'
alter m000_6 and chain A,chain='B'
remove hetatm
sele tetramer_5kn2, (m000_6 or (m000_8 and (chain A))) 
sele dimer_5kn2, (m000_8 and chain A) or (m000_6 and chain B)
hide everything, not tetramer_5kn2
orient tetramer_5kn2
save ./output/tetramer_5kn2.pdb, tetramer_5kn2
save ./output/dimer_5kn2.pdb, dimer_5kn2
remove hetatm
save ./output/tetramer_5kn2_no_het.pdb, tetramer_5kn2
save ./output/dimer_5kn2_no_het.pdb, dimer_5kn2
