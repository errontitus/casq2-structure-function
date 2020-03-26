alter (chain A), resv += 19
sort
select monomer, (chain A)
save ./output/monomer_1a8y.pdb, monomer
remove hetatm 
save ./output/monomer_1a8y_no_het.pdb, monomer

