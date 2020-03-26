run ../../../bin/structure/pymol/supercell.py
supercell 1,2,2, 6OWW_yb, green

# Not using this dimer.
# Keep SO4 for the dimer.
# sele dimer_deo_yb, m000_5
# save ./output/dimer_deo_yb.pdb, dimer_deo_yb

remove hetatm and not elem Yb

sele filament_tmp, (m001_2 and (chain H or chain C or chain E or chain B or chain A)) or (m001_1 and (chain F or chain D or chain G)) or (m000_2 and ((chain H or chain C or chain E or chain B or chain A))) or (m000_1 and (chain F))

remove polymer and not filament_tmp

# Make polymer chain IDs sequential
# m001_2 H C E B A
alter m001_2 and chain A, chain='Q'
alter m001_2 and chain B, chain='R'
#
alter m001_2 and chain H, chain='A'
alter m001_2 and chain C, chain='B'
alter m001_2 and chain E, chain='C'
alter m001_2 and chain R, chain='D'
alter m001_2 and chain Q, chain='E'

# m001_1 F D G
alter m001_1 and chain G, chain='Z'
alter m001_1 and chain F, chain='F'
alter m001_1 and chain D, chain='G'
alter m001_1 and chain Z, chain='H'

# m000_2 H C E B A
alter m000_2 and chain H, chain='I'
alter m000_2 and chain C, chain='J'
alter m000_2 and chain E, chain='K'
alter m000_2 and chain B, chain='L'
alter m000_2 and chain A, chain='M'

# m000_1 F
alter m000_1 and chain F, chain='N'

sele filament_deo_yb, (chain A or chain B or chain C or chain D or chain E or chain F or chain G or chain H or chain I or chain J or chain K or chain L or chain M or chain N)

sele filament_het_all, elem yb within 5 of (filament_deo_yb)

save ./output/filament_deo_yb.pdb, filament_deo_yb or filament_het_all





