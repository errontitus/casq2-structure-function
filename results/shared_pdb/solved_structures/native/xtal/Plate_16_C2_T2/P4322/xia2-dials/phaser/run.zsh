#! /bin/zsh
#

pymol -cq make_monomer_search_model.pml

# Note: the composition defines the total amount of protein and nucleic acid that you have in the asymmetric unit, not the fraction of the asymmetric unit that you are searching for.

phaser << EOF
TITLE MR
MODE MR_AUTO
HKLIN ../xia2-dials/DataFiles/AUTOMATIC_DEFAULT_free.mtz
HKLOUT on
LABIN I = IMEAN SIGI = SIGIMEAN
ENSEMBLE monomer_search_model PDB monomer_search_model.pdb RMS 1
COMPOSITION PROTEIN SEQ ../hCASQ2_after_TEV.fasta NUMBER 1
SEARCH ENSEMBLE monomer_search_model NUMBER 1
SGALTERNATIVE SELECT HAND
TOPFiles 10
ROOT Plate_16_C2_T2_P4322_xia2_dials_monomer_search
EOF 

# Look at the solution.
coot --pdb Plate_16_C2_T2_P4322_xia2_dials_monomer_search.1.pdb --auto Plate_16_C2_T2_P4322_xia2_dials_monomer_search.1.mtz