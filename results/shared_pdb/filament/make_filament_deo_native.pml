run ../../../bin/structure/pymol/supercell.py
supercell 1,1,2, 6OWV_native, green

remove hetatm

alter m000_6, chain='A'
alter m000_5, chain='C'
alter m000_8, chain='E'
alter m000_7, chain='G'
alter m001_6, chain='I'
alter m001_5, chain='K'
alter m001_8, chain='M'

alter m000_4, chain='B'
alter m000_3, chain='D'
alter m000_2, chain='F'
alter m001_1, chain='H'
alter m001_4, chain='J'
alter m001_3, chain='L'
# Looks better if we include an extra unit.
alter m001_2, chain='N'

sele filament_deo_native, (m000_2 or m000_3 or m000_4 or m000_5 or m000_6 or m000_7 or m000_8 or m001_1 or m001_2 or m001_3 or m001_4 or m001_5 or m001_6 or m001_1 or m001_8)
save ./output/filament_deo_native.pdb, filament_deo_native
remove hetatm
save ./output/filament_deo_native_no_het.pdb, filament_deo_native
remove chain I or chain J or chain K or chain L or chain M or chain N 
save ./output/octamer_deo_native_no_het.pdb, filament_deo_native
remove chain A or chain H
#save ./output/hexamer_deo_native_no_het.pdb, filament_deo_native
remove chain B or chain G
save ./output/tetramer_deo_native_no_het.pdb, filament_deo_native

#remove chain C or chain F
#save ./output/inter_dimer_deo_native_no_het.pdb, filament_deo_native
