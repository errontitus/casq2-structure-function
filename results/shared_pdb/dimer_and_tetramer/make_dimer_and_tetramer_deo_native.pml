# Our structure
# Apparently, the trick for getting PyMOL to move an ensemble as such during alignment is to save the ensemble as a single PDB.
run ../../../bin/structure/pymol/supercell.py
supercell 1,1,1, 6OWV_native, green
hide everything
alter m000_5,chain='B'
alter m000_4,chain='C'
alter m000_6,chain='D'
sele inter_dimer_deo_native, m000_4 or m000_5
sele tetramer_deo_native, m000_3 or m000_4 or m000_5 or m000_6
sele dimer_deo_native, m000_3 or m000_5
save ./output/tetramer_deo_native.pdb, tetramer_deo_native
save ./output/dimer_deo_native.pdb, dimer_deo_native
remove hetatm
save ./output/tetramer_deo_native_no_het.pdb, tetramer_deo_native
save ./output/dimer_deo_native_no_het.pdb, dimer_deo_native
# remove chain A or chain D
# save ./output/inter_dimer_deo_native_no_het.pdb, inter_dimer_deo_native
