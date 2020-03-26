run ../../bin/structure/pymol/color_blind_friendly.py
run ../../bin/structure/pymol/casq2_base.py
@../../bin/structure/pymol/pub_graphics_base.pml

# load ../shared_pdb/dimer_and_tetramer/output/tetramer_deo_native_no_het.pdb
# load ../shared_pdb/apbs/output/tetramer_deo_native_no_het.pqr.dx, map

load ../shared_pdb/filament/output/tetramer_deo_native_no_het.pdb
load ../shared_pdb/apbs/output/tetramer_deo_native_no_het.pqr.dx, map

# as surface

load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_A.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_C.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_E.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_cavity_G.pdb 

load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_A.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_B.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_C.pdb 
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_D.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_E.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_F.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_G.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_dimer_tunnel_H.pdb

load ../shared_pdb/cavity/output/hollow_deo_native_tetramer_cavity_B.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_tetramer_cavity_D.pdb
load ../shared_pdb/cavity/output/hollow_deo_native_tetramer_cavity_F.pdb

cmd.set("cartoon_transparency", default_cartoon_transparency())

# apply_standard_colors_tetramer("tetramer_deo_native_no_het", 1)
# apply_standard_colors_filament("tetramer_deo_native_no_het", 1)

sele = "tetramer_deo_native_no_het"
theme_id = 1
cmd.color(chainA_color(theme_id), "chain C and elem C and " + sele)
cmd.color(chainB_color(theme_id), "chain D and elem C and " + sele)
cmd.color(chainC_color(theme_id), "chain E and elem C and " + sele)
cmd.color(chainD_color(theme_id), "chain F and elem C and " + sele)

apply_standard_colors_hetatm()

# sele tetramer_cavity, (hollow_deo_native_dimer_cavity_A or hollow_deo_native_dimer_cavity_C or hollow_deo_native_dimer_tunnel_A or hollow_deo_native_dimer_tunnel_B or hollow_deo_native_dimer_tunnel_C or hollow_deo_native_dimer_tunnel_D or hollow_deo_native_tetramer_cavity_B)
sele tetramer_cavity, (hollow_deo_native_dimer_cavity_C or hollow_deo_native_dimer_cavity_E or hollow_deo_native_dimer_tunnel_C or hollow_deo_native_dimer_tunnel_D or hollow_deo_native_dimer_tunnel_E or hollow_deo_native_dimer_tunnel_F or hollow_deo_native_tetramer_cavity_D)

# sele dimer_native, tetramer_deo_native_no_het and (chain A or chain B)
sele dimer_native, tetramer_deo_native_no_het and (chain C or chain D)

sele dimer_cavity, (hollow_deo_native_dimer_cavity_C or hollow_deo_native_dimer_tunnel_C or hollow_deo_native_dimer_tunnel_D)

# Convention is to color the solvent-accessible surface (i.e. one solvent radius above the protein) rather than the protein surface itself - because a solvent molecule or ion will sit on top of the protein surface, not in it. To do this, we would set surface_ramp_above_mode.
# In our case, we are using the hollow-traced surface as our surface, so we are already showing solvent.
# set surface_ramp_above_mode

turn y, 90
orient tetramer_deo_native_no_het

ramp_new elvl, map,[-30,0,30], [red, white, blue]

set surface_color, elvl, tetramer_cavity
