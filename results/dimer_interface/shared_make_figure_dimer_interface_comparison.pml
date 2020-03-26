run ../../bin/structure/pymol/color_blind_friendly.py
run ../../bin/structure/pymol/casq2_base.py
@../../bin/structure/pymol/pub_graphics_base.pml
run ../../bin/structure/pymol/orientation.py
run ../../bin/structure/pymol/color_by_rmsd.py

load ../shared_pdb/dimer_and_tetramer/output/dimer_deo_native.pdb 

apply_standard_colors_dimer("dimer_deo_native", 1)
apply_standard_colors_hetatm()

orient dimer_deo_native
zoom dimer_deo_native
rotate y, 180

# rotate y, 45

