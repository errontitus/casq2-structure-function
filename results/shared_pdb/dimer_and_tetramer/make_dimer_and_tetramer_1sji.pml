alter (chain A), resv += 19
alter (chain B), resv += 19
sort
run ../../../bin/structure/pymol/supercell.py
supercell 2,1,2, 1sji, green
alter 1sji and (Chain B),chain='AA'
alter 1sji and (Chain A),chain='B'
alter 1sji and (Chain AA),chain='A'
alter m000_7 and (Chain B),chain='C'
alter m000_7 and (Chain A),chain='D'
sele tetramer_1sji, 1sji or m000_7
sele dimer_1sji, 1sji
save ./output/tetramer_1sji.pdb, tetramer_1sji
save ./output/dimer_1sji.pdb, dimer_1sji
remove hetatm
save ./output/tetramer_1sji_no_het.pdb, tetramer_1sji
save ./output/dimer_1sji_no_het.pdb, dimer_1sji
