run ../../bin/structure/pymol/color_blind_friendly.py
run ../../bin/structure/pymol/casq2_base.py
@../../bin/structure/pymol/pub_graphics_base.pml

# So that Yb spheres shine through surfaces. Trying to make spheres really bright. Helps a bit, not a lot. Effect is observable only in ray-traced images.
# set spec_reflect, 1
# set spec_power, 100

# Used to eliminate shadows in buried areas.
set two_sided_lighting, on
set backface_cull, 0

cmd.load("../shared_pdb/filament/output/filament_deo_yb.pdb", "filament") 
# "

apply_standard_colors_filament("filament", 1)
# apply_standard_colors_filament_surfaces("filament", 1)
apply_standard_colors_hetatm()

create_thioredoxin_domains("ABCDEFGHIJKLMN", "deo_yb", "filament", 0)

# chain A or chain B or 
sele filament_short, (chain C or chain D or chain E or chain F or chain G or chain H or chain I or chain J or chain K or chain L)

# load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_cavity_A.pdb 
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_cavity_C.pdb 
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_cavity_E.pdb 
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_cavity_G.pdb 
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_cavity_I.pdb 
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_cavity_K.pdb 
# load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_cavity_M.pdb 

#load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_A.pdb 
#load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_B.pdb 
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_C.pdb 
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_D.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_E.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_F.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_G.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_H.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_I.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_J.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_K.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_L.pdb
# load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_M.pdb
# load ../shared_pdb/cavity/output/hollow_deo_yb_dimer_tunnel_N.pdb

load ../shared_pdb/cavity/output/hollow_deo_yb_tetramer_cavity_B.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_tetramer_cavity_D.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_tetramer_cavity_F.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_tetramer_cavity_H.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_tetramer_cavity_J.pdb
load ../shared_pdb/cavity/output/hollow_deo_yb_tetramer_cavity_L.pdb

sele cavity_outside, (hollow_deo_yb_tetramer_cavity_B or hollow_deo_yb_tetramer_cavity_L) within 5 of filament_short

sele cavity_inside, hollow* and not cavity_outside

sele cavity, cavity_inside or cavity_outside

# sele tetramer_cavity, (hollow_deo_yb_dimer_cavity_E or hollow_deo_yb_dimer_cavity_G or hollow_deo_yb_dimer_tunnel_E or hollow_deo_yb_dimer_tunnel_F or hollow_deo_yb_dimer_tunnel_G or hollow_deo_yb_dimer_tunnel_H or hollow_deo_yb_tetramer_cavity_F)

# sele dimer_cavity, (hollow_deo_yb_dimer_cavity_E or hollow_deo_yb_dimer_tunnel_E or hollow_deo_yb_dimer_tunnel_F)

apply_standard_color_cavity("cavity")

sele monomer, chain F
sele dimer_chains, chain E or chain F
sele tetramer_chains, chain E or chain F or chain G or chain H

hide everything 
