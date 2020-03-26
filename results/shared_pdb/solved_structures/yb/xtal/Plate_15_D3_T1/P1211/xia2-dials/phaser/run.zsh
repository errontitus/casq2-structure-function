#! /bin/zsh
#

cp ../../../../../../native/6OWV_native.pdb native_model_original.pdb

# Sclupt can be used to remove alternate conformations, but it won't work unless we provide alignment...
phenix.pdbtools native_model_original.pdb remove_alt_confs=True remove="not chain A"

cp native_model_original.pdb_modified.pdb native_model_for_search.pdb

# Note: the composition defines the total amount of protein and nucleic acid that you have in the asymmetric unit, not the fraction of the asymmetric unit that you are searching for.

# Previously tried searching for dimer as a dimer. Phaser is unhappy; solutions do not pack.
# Could change packing cutoff, but the first thing to do is to break apart the model and allow Phaser to search for separate chains.
phaser << EOF
TITLE MR
MODE MR_AUTO
HKLIN ../xia2-dials/DataFiles/AUTOMATIC_DEFAULT_free.mtz
HKLOUT on
LABIN I = IMEAN SIGI = SIGIMEAN
ENSEMBLE native_model_for_search PDB native_model_for_search.pdb RMS 1
COMPOSITION PROTEIN SEQ ../hCASQ2_after_TEV.fasta NUMBER 8
SEARCH ENSEMBLE native_model_for_search NUMBER 8
SGALTERNATIVE SELECT HAND
TOPFiles 10
ROOT Plate_15_D3_T1_P1211_xia2_dials_monomer_search
EOF 

coot --pdb Plate_15_D3_T1_P1211_xia2_dials_monomer_search.1.pdb --auto Plate_15_D3_T1_P1211_xia2_dials_monomer_search.1.mtz