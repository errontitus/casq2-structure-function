run ../../bin/structure/pymol/color_blind_friendly.py
run ../../bin/structure/pymol/casq2_base.py
run ../../bin/structure/pymol/interface_residues.py
@../../bin/structure/pymol/pub_graphics_base.pml
@../../bin/structure/pymol/pub_graphics_ligands_and_bonds.pml

# So that Yb spheres shine through surfaces. Trying to make spheres really bright. Helps a bit, not a lot. Effect is observable only in ray-traced images.
set spec_reflect, 1
set spec_power, 100

# Used to eliminate shadows in buried areas.
# set two_sided_lighting, on
# set backface_cull, 0

# Our new way of loading the structure more amenable to showing maps:
load ./output/6OWV_native_refined_map_coefficients_2mFo-DFc.ccp4, native_map
load ../shared_pdb/solved_structures/native/6OWV_native.pdb, tetramer_deo_native
symexp N, tetramer_deo_native, tetramer_deo_native, 3
# You clicked /N07000000//A/ALA`204/CA
alter N01000000, chain='B'
alter N06000000, chain='C'
alter tetramer_deo_native, chain='D'
# We need an object
extract tetramer_native, N07000000 or N01000000 or N06000000 or tetramer_deo_native
remove tetramer_deo_native
remove N*

load ./output/6OWW_yb_refined_map_coefficients_2mFo-DFc.ccp4, yb_map
load ./output/6OWW_yb_refined_map_coefficients_anom.ccp4, yb_map_anom
load ../shared_pdb/solved_structures/yb/6OWW_yb.pdb, tetramer_yb
remove tetramer_yb and not (chain H or chain C or chain E or chain B or chain Y)
alter (tetramer_yb and (chain B)),chain='Z'
alter (tetramer_yb and (chain H)),chain='A'
alter (tetramer_yb and (chain C)),chain='B'
alter (tetramer_yb and (chain E)),chain='C'
alter (tetramer_yb and (chain Z)),chain='D'
select_tetramer_yb("tetramer_het_all", "tetramer_yb and (chain B or chain C)", "tetramer_yb and (chain A or chain D)")
sele remove_yb, elem Yb and not tetramer_het_all
remove remove_yb

sele tetramer_yb_polymer, tetramer_yb and polymer and (chain A or chain B or chain C or chain D) 
sele tetramer_native_polymer, tetramer_native and polymer and (chain A or chain B or chain C or chain D) 

align tetramer_native & (chain B or chain C), tetramer_yb & (chain B or chain C)

######################

# Get close to proper orientation. Different rotation than native filament.
turn y, 90
turn x, 90

orient tetramer_yb 
zoom tetramer_yb, -15

apply_standard_colors_tetramer("tetramer_yb", 1)
apply_standard_colors_tetramer("tetramer_native", 1)
apply_standard_colors_hetatm()

sele tetramer_chains, chain A or chain B or chain C or chain D

select_tetramer_yb_thio23_only("tetramer_het_thio23", "tetramer_yb and (chain B or chain C)", "tetramer_yb and (chain A or chain D)")
select_tetramer_yb_residues_thio23_only("tetramer_het_residues_thio23", "tetramer_yb and (chain B or chain C)", "tetramer_yb and (chain A or chain D)")

select_tetramer_yb_residues("tetramer_het_residues_all", "tetramer_yb and (chain B or chain C)", "tetramer_yb and (chain A or chain D)")

set sphere_scale, 0.5, polymer
set sphere_scale, 0.4, elem Yb

#
matrix_copy tetramer_native, native_map

hide everything
