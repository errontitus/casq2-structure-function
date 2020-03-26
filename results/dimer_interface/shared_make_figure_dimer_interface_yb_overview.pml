@shared_make_figure_dimer_interface_yb.pml

set ray_shadows, 1
set surface_proximity, off

orient dimer_yb_polymer 
zoom dimer_yb_polymer, 4
#turn x, 180

hide everything
# # copy
# create yb_copy, dimer_het, zoom=0
# # color it cyan
# color cyan, yb_copy
# # translate it away from the camera
# # now "carve" the surface to only show 
# set surface_carve_selection, yb_copy
# set surface_carve_cutoff, 5

show cartoon, dimer_yb
cmd.set("cartoon_transparency", default_cartoon_transparency())

set sphere_scale, 0.7, elem Yb

show spheres, dimer_het

