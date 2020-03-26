#! /bin/zsh
#

mkdir -p output
rm output/*

pdb_native=../solved_structures/native/6OWV_native.pdb
pymol -cq $pdb_native make_filament_deo_native.pml

pdb_yb=../solved_structures/yb/6OWW_yb.pdb
pymol -cq $pdb_yb make_filament_deo_yb.pml

pymol -cq ../../../data/structure_other/1sji.ent make_filament_1sji.pml
pymol -cq ../../../data/structure_other/1a8y.ent make_filament_1a8y.pml
