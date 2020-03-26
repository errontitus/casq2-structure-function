@shared_make_figure_tetramer_interface_yb.pml

set ray_shadows, 1

hide everything 

extract tetramer_cavity_wall, (tetramer within 7 of hollow_deo_yb_tetramer_cavity_B) and polymer and not (resi 47 or resi 48)
# 

orient tetramer 
zoom tetramer 

set surface_carve_selection, tetramer_cavity_wall
set surface_carve_cutoff, 3

show surface, tetramer_cavity_wall
show cartoon, tetramer

cmd.select("C_2", thioredoxin_domain_selection("deo_yb", 2, "chain C and polymer"))

hide surface, C_2
hide surface, ((chain A and resi 348) or (chain D and resi 350))
hide cartoon, C_2

cmd.set("cartoon_transparency", default_cartoon_transparency())

show spheres, tetramer_het_all 

# Nice way to trace shadows, shows that this is a cavity.
util.ray_shadows("heavy")
set two_sided_lighting=1
set backface_cull=0

save_image_tetramer("tetramer_interface_overview_yb")


