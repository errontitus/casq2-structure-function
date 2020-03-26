sele dimer_1sji, 1sji
alter (chain A), resv += 19
sort
select monomer, (chain A)
save ./output/monomer_1sji.pdb, monomer
remove hetatm
save ./output/monomer_1sji_no_het.pdb, monomer

