# Strange packing. Not a credible unit cell.
alter (chain A), resv -= 981
run ../../../bin/structure/pymol/supercell.py
supercell 2,1,2, 2vaf, green
# show surface, 2vaf
# show surface, m000_7
# show surface, m000_10
# show surface, m000_14
alter m000_10,chain='A'
alter m000_7,chain='B'
alter 2vaf,chain='C'
alter m000_14,chain='D'
sele tetramer_2vaf, 2vaf or m000_7 or m000_10 or m000_14
sele dimer_2vaf, m000_7 or m000_10
save ./output/tetramer_2vaf.pdb, tetramer_2vaf
save ./output/dimer_2vaf.pdb, dimer_2vaf
remove hetatm
save ./output/tetramer_2vaf_no_het.pdb, tetramer_2vaf
save ./output/dimer_2vaf_no_het.pdb, dimer_2vaf
