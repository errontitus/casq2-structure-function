run ../../bin/structure/pymol/color_blind_friendly.py
run ../../bin/structure/pymol/casq2_base.py
@../../bin/structure/pymol/pub_graphics_base.pml

cmd.load("../shared_pdb/filament/output/filament_deo_native.pdb", "filament") 
# "

# Get close to desired orientation.
rotate y, 90

apply_standard_colors_filament("filament", 1)
apply_standard_colors_filament_surfaces("filament", 1)

sele filament_short, (chain A or chain B or chain C or chain D or chain E or chain F or chain G or chain H or chain I or chain J)

sele dimer, chain E or chain F 
sele tetramer, chain E or chain F or chain G or chain H

orient filament_short and polymer
zoom_complete("filament_short")

hide everything