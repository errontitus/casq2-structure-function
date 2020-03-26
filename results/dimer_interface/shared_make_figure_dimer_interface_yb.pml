run ../../bin/structure/pymol/color_blind_friendly.py
run ../../bin/structure/pymol/casq2_base.py
@../../bin/structure/pymol/pub_graphics_base.pml

set sphere_scale, 0.5, polymer
set sphere_scale, 1.0, elem Yb

# So that Yb spheres shine through surfaces. Trying to make spheres really bright. Helps a bit, not a lot. Effect is observable only in ray-traced images.
set spec_reflect, 1
set spec_power, 100

# Used to eliminate shadows in buried areas.
# set two_sided_lighting, on
# set backface_cull, 0

# Our new way of loading the structure more amenable to showing maps:
load ./output/6OWV_native_refined_map_coefficients_2mFo-DFc.ccp4, native_map
load ../shared_pdb/solved_structures/native/6OWV_native.pdb, dimer_deo_native
symexp N, dimer_deo_native, dimer_deo_native, 3
alter N05000000, chain='B'
remove N05000000 and resn SO4
# We need an object
extract dimer_native, N05000000 or N03000000
remove dimer_deo_native
remove N*

load ./output/6OWW_yb_refined_map_coefficients_2mFo-DFc.ccp4, yb_map
load ./output/6OWW_yb_refined_map_coefficients_anom.ccp4, yb_map_anom
load ../shared_pdb/solved_structures/yb/6OWW_yb.pdb, dimer_yb
remove dimer_yb and not (chain H or chain C or chain Y or chain I)
alter (dimer_yb and (chain H)),chain='A'
alter (dimer_yb and (chain C)),chain='B'
select_dimer_yb("dimer_het", "dimer_yb")
sele remove_yb, elem Yb and not dimer_het
remove remove_yb

sele dimer_yb_polymer, dimer_yb and polymer and (chain A or chain B) 
sele dimer_native_polymer, dimer_native and polymer and (chain A or chain B) 

align dimer_native & (chain A), dimer_yb & (chain A)
#align dimer_native and (chain A or chain B), dimer_yb and (chain A or chain B)

theme_id = 1
cmd.set("surface_color",chainA_color(theme_id), "chain A and dimer_yb")
cmd.set("surface_color",chainB_color(theme_id), "chain B and dimer_yb")

# 
apply_standard_colors_dimer("dimer_yb", 1)
apply_standard_colors_dimer("dimer_native", 1)
apply_standard_colors_hetatm()

#
matrix_copy dimer_native, native_map

