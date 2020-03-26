run ../../../bin/structure/pymol/supercell.py
supercell 1,1,3, 1sji, green
alter (m000_7 and (chain A)), chain='C'
alter (m000_7 and (chain B)), chain='D'
alter (m001_1 and (chain A)), chain='E'
alter (m001_1 and (chain B)), chain='F'
alter (m001_7 and (chain A)), chain='G'
alter (m001_7 and (chain B)), chain='H'
alter (m002_1 and (chain A)), chain='I'
alter (m002_1 and (chain B)), chain='J'
alter (m002_7 and (chain A)), chain='K'
alter (m002_7 and (chain B)), chain='L'
remove hetatm
sele filament_1sji, 1sji or m000_7 or m001_1 or m001_7 or m002_1 or m002_7
save ./output/filament_1sji.pdb, filament_1sji
