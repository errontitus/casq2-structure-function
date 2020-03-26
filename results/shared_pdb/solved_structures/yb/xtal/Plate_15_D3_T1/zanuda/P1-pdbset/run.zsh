#! /bin/zsh
#
# Drop to P1 with pdbset
#
# Conception by James Holton

xyzin_other="../../P43212/xds-staraniso/refinement/refine001/anom_model_001.pdb"
mtz_P1="../../P1/xds-staraniso/refinement/Plate_15_D3_T1_P1_xds_aniso_merged_free.mtz"

pdbset xyzin $xyzin_other xyzout P1_for_zanuda.pdb << EOF
symgen P43212
SPACE 1
chain symmetry 2 A D
chain symmetry 2 B E
chain symmetry 2 C F
chain symmetry 3 A G
chain symmetry 3 B H
chain symmetry 3 C I
chain symmetry 4 A J
chain symmetry 4 B K
chain symmetry 4 C L
chain symmetry 5 A M
chain symmetry 5 B N
chain symmetry 5 C O
chain symmetry 6 A P
chain symmetry 6 B Q
chain symmetry 6 C R
chain symmetry 7 A S
chain symmetry 7 B T
chain symmetry 7 C U
chain symmetry 8 A V
chain symmetry 8 B W
chain symmetry 8 C X
EOF

# Code below would move flags over. Not working well for me...
#
########### Expand free R flags to P1
#
# mtzin_other="../P43212/xds-staraniso/refinement/Plate_15_D3_T1_P43212_xds_aniso_merged_free.mtz"
# mtz_P1="../../P1/xds-staraniso/staraniso_UYs_fO4CkBR2ZGPk/Plate_15_D3_T1_P1_xds-aniso-merged.mtz"

# # now we need to get the free-R flags into P1 as well, use cad for this
# cad hklin1 $mtzin_other hklout freeflags.mtz << EOF
# labin file 1 E1=FreeR_flag
# EOF

# # now that free flags are separate, expand to full cell
# cad hklin1 freeflags.mtz hklout freeflags_expanded.mtz << EOF
# labin file 1 all
# outlim space 1
# EOF

# # and THEN change the space group in the header
# cad hklin1 freeflags.mtz hklout freeflags_P1.mtz << EOF
# labin file 1 all
# symm 1
# EOF

# # Now we have free-R flags in P1

# # NOW we run pointless in case we need to reindex
# pointless xyzin P1_for_zanuda.pdb hklin $mtz_P1 hklout P1_for_zanuda_reindexed_unfree.mtz << EOF | tee pointless.log
# tolerance 1
# EOF
# # reindexed.mtz is now a version of truncated.mtz that is compatible with the pdb file

# # combine with the Free-R flags
# cad hklin1 P1_for_zanuda_reindexed_unfree.mtz hklin2 freeflags_P1.mtz hklout P1_for_zanuda_reindexed_free.mtz << EOF
# labin file 1 all
# labin file 2 all
# EOF

########### 


# NOW we run pointless in case we need to reindex
pointless xyzin P1_for_zanuda.pdb hklin $mtz_P1 hklout P1_for_zanuda_reindexed_free.mtz << EOF | tee pointless.log
tolerance 1
EOF
# reindexed.mtz is now a version of truncated.mtz that is compatible with the pdb file

zanuda xyzin P1_for_zanuda.pdb hklin P1_for_zanuda_reindexed_free.mtz | tee zanuda.log

