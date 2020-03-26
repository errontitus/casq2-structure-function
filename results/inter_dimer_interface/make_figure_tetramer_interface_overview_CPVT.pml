@shared_make_figure_tetramer_interface_non_liganded.pml

apply_standard_colors_tetramer_spheres("tetramer", 1)

show cartoon, tetramer

# set sphere_scale, 1.0, tetramer_het_all
set sphere_scale, 1.2, polymer 

orient tetramer 
zoom tetramer, -15

hide everything 
apply_standard_colors_tetramer_spheres("tetramer", 1)
apply_standard_colors_tetramer("tetramer", 1)
show cartoon, tetramer 
# One side
show spheres, tetramer and ((chain B and resi 173) or (chain C and resi 87) or (chain D and (resi 325 or resi 319)))
# Other side
show spheres, tetramer and ((chain C and resi 173) or (chain B and resi 87) or (chain A and (resi 325 or resi 319)))

# One side
show spheres, tetramer and ((chain B and resi 50) or (chain C and (resi 180 or resi 184 or resi 187)))
# Other side
show spheres, tetramer and ((chain C and resi 50) or (chain B and (resi 180 or resi 184 or resi 187)))

save_image_tetramer("tetramer_interface_overview_CPVT")

rotate x, 90
save_image_tetramer("tetramer_interface_overview_CPVT_90")
rotate x, -90