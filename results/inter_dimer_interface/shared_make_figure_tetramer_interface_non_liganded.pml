run ../../bin/structure/pymol/color_blind_friendly.py
run ../../bin/structure/pymol/casq2_base.py
run ../../bin/structure/pymol/interface_residues.py
@../../bin/structure/pymol/pub_graphics_base.pml

# So that Yb spheres shine through surfaces. Trying to make spheres really bright. Helps a bit, not a lot. Effect is observable only in ray-traced images.
set spec_reflect, 1
set spec_power, 100

# Used to eliminate shadows in buried areas.
# set two_sided_lighting, on
# set backface_cull, 0

cmd.load("../shared_pdb/filament/output/filament_deo_native.pdb", "filament") 
# "

cmd.set("cartoon_transparency", default_cartoon_transparency(), "filament")

sele tetramer_chains, (chain A or chain B or chain C or chain D)
remove polymer and not tetramer_chains
sele all_het, hetatm within 5 of tetramer_chains
remove hetatm and not all_het

load ../shared_pdb/cavity/output/hollow_deo_native_tetramer_cavity_B.pdb

# Get close to proper orientation. Different rotation than native filament.
rotate y, 90
orient tetramer 
zoom tetramer, -15

set sphere_scale, 1.0, polymer
set sphere_scale, 1.0, elem Yb

apply_standard_colors_tetramer("tetramer", 1)
apply_standard_colors_hetatm()

sele foreground, chain A or chain C 
sele background, chain B or chain D

theme_id = 1
cmd.set("surface_color",chainA_color(theme_id), "chain A and tetramer")
cmd.set("surface_color",chainB_color(theme_id), "chain B and tetramer")
cmd.set("surface_color",chainC_color(theme_id), "chain C and tetramer")
cmd.set("surface_color",chainD_color(theme_id), "chain D and tetramer")

# We may want to keep this and retain the same coloring from figure 1.
myInterfaceResiduesBC = interfaceResidues("tetramer", "(chain B)", "(chain C)", 0.75, "interface_tetramer_BC")
myInterfaceResiduesAD = interfaceResidues("tetramer", "(chain A)", "(chain D)", 0.75, "interface_tetramer_AD")
myInterfaceResiduesAC = interfaceResidues("tetramer", "(chain A)", "(chain C)", 0.75, "interface_tetramer_AC")
myInterfaceResiduesBD = interfaceResidues("tetramer", "(chain B)", "(chain D)", 0.75, "interface_tetramer_BD")

select all_interface_residues, interface_tetramer_BC or interface_tetramer_AD \
     or interface_tetramer_AC or interface_tetramer_BD

orient tetramer 
zoom tetramer, -20

hide everything 
