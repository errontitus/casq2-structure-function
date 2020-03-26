@shared_make_figure_cavity_yb.pml

# What we need here is slicing: https://pymolwiki.org/index.php/Gallery

# Approaches that do not work:
# - Cartoon + cavity surface + Yb does not work. Too busy.
# Double transparency does not work when ray traced unless blended.
# Surface with open cavity could work.

# To show Yb, only cutaways work. 
# Cutaways look cleaner with surface.

# hide everything
cmd.set("surface_color",chainC_color(1), "filament_short")
show surface, cavity
extract new_filament, filament_short

hide everything
# On screen you can see a surface inside a surface. 
# To see this in a ray-traced image, you need to ask for some sort of blending.
# Weighted Blended Order-Independent Transparency: http://jcgt.org/published/0002/02/09/
# I.e. show a blend of everything and avoid making choices about what is hidden/obscured.
set transparency_mode, 3
# As low as possible.
set ray_transparency_oblique, 0.05
# As low as possible.
set ray_transparency_contrast, 1.0
# Play with these. Not sure what they do.
# set ray_transparency_contrast, 0.20
# set ray_transparency_oblique_power, 20

set sphere_scale, 0.8, elem Yb

cmd.set("transparency", 0.95, "new_filament")
cmd.set("transparency", 0.7, "cavity")

# Outside Yb
sele outside_yb, (elem Yb within 4.5 of new_filament) and not (dimer_het or tetramer_het_inside)
color green, outside_yb

show surface, new_filament 
show surface, cavity
show spheres, dimer_het or tetramer_het_inside
# show spheres, outside_yb 

save_image_filament("filament_cavity_and_yb_blend_cutaway")
