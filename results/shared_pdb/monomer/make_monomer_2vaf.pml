alter (chain A), resv -= 981
sort
select monomer, (chain A)
save ./output/monomer_2vaf.pdb, monomer
remove hetatm
save ./output/monomer_2vaf_no_het.pdb, monomer

