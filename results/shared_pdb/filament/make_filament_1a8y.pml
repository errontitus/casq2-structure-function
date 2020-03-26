run ../../../bin/structure/pymol/supercell.py

supercell 2,1,3, 1a8y, green

alter m000_3, chain='A'
alter m000_2, chain='B'
alter m000_4, chain='C'
alter 1A8Y, chain='D'
alter m001_3, chain='E'
alter m001_2, chain='F'
alter m001_4, chain='G'
alter m001_1, chain='H'
alter m002_3, chain='I'
alter m002_2, chain='J'
alter m002_4, chain='K'
alter m002_1, chain='L'

remove hetatm
sele filament_1a8y, 1A8Y or m000_2 or m000_3 or m000_4 or m001_3 or m001_2 or m001_4 or m001_1 or m002_3 or m002_2 or m002_4 or m002_1
save ./output/filament_1a8y.pdb, filament_1a8y
