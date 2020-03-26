run ../../bin/structure/pymol/color_blind_friendly.py
run ../../bin/structure/pymol/casq2_base.py
@../../bin/structure/pymol/pub_graphics_base.pml

# Used to eliminate shadows in buried areas.
set two_sided_lighting, on
set backface_cull, 0

cmd.load("../shared_pdb/filament/output/filament_deo_native.pdb", "filament") 
# "

remove hetatm 

apply_standard_colors_filament("filament", 1)
apply_standard_colors_filament_surfaces("filament", 1)
# apply_standard_colors_hetatm()

create_thioredoxin_domains("ABCDEFGHIJKLMN", "deo_native", "filament", 0)

sele filament_short, (chain A or chain B or chain C or chain D or chain E or chain F or chain G or chain H or chain I or chain J)

load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_A.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_C.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_E.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_G.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_I.pdb 
# load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_K.pdb 
# load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_M.pdb 

load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_A.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_B.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_C.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_D.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_E.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_F.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_G.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_H.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_I.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_J.pdb
# load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_K.pdb
# load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_L.pdb
# load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_M.pdb
# load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_N.pdb

load ../shared_pdb/cavity/output/hollow_deo_native_tetramer_cavity_B.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_tetramer_cavity_D.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_tetramer_cavity_F.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_tetramer_cavity_H.pdb
# load ../shared_pdb/cavity/output/hollow_deo_native_tetramer_cavity_J.pdb
# load ../shared_pdb/cavity/output/hollow_deo_native_tetramer_cavity_L.pdb

sele cavity, hollow*

sele tetramer_cavity, (hollow_deo_native_dimer_cavity_E or hollow_deo_native_dimer_cavity_G or hollow_deo_native_dimer_tunnel_E or hollow_deo_native_dimer_tunnel_F or hollow_deo_native_dimer_tunnel_G or hollow_deo_native_dimer_tunnel_H or hollow_deo_native_tetramer_cavity_F)

sele dimer_cavity, (hollow_deo_native_dimer_cavity_E or hollow_deo_native_dimer_tunnel_E or hollow_deo_native_dimer_tunnel_F)

apply_standard_color_cavity("cavity")

sele monomer, chain F
sele dimer_chains, chain E or chain F
sele tetramer_chains, chain E or chain F or chain G or chain H

# Get close to proper orientation. 
rotate y, 90

orient filament_short and polymer
zoom_complete("filament_short")

select dimer_yb_contacts, (resi 136 or resi 140 or resi 143 or resi 147 or resi 275 or resi 277 or resi 278 or resi 280 or resi 309 or resi 310) and dimer_chains

hide everything