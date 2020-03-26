@shared_make_figure_tetramer_interface_non_liganded.pml

apply_standard_colors_tetramer_spheres("tetramer", 1)

show cartoon, tetramer

# set sphere_scale, 1.0, tetramer_het_all
set sphere_scale, 0.8, all_interface_residues

# Needed in order to isolate domains
# create_thioredoxin_domains("ABCD", "deo_yb", "tetramer", 0)

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
# all_interface_residues
save_image_tetramer("tetramer_interface_overview_non_liganded")

rotate x, 90
save_image_tetramer("tetramer_interface_overview_non_liganded_90")

