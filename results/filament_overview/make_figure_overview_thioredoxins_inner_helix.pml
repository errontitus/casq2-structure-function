@shared_make_figure_overview_thioredoxins.pml

hide everything
# Get rid of the outer helix so that we can create a closed surface of the inner helix (more visually appealing)
extract obj_outer_helix, outer_helix
zoom_complete("filament_short")
# One strand of the helix consists of domains II and II from chains A and A'. Designating this inner_helix_strand. The other strand consists of the same domains from chains B and B', which we will show as a surface.
select inner_helix_strand, filament_short and polymer and (A3 or A2 or C3 or C2 or E3 or E2 or G3 or G2 or I3 or I2 or K3 or K2 or M3 or M2)
show cartoon, inner_helix_strand
# cmd.set("surface_color", "deepteal", "inner_helix_strand and *2")
# cmd.set("surface_color", "cb_red", "inner_helix_strand and *3")
color_thioredoxin_domains("deo_native", "filament")
# Darken one strand.
cmd,set("color", domain_color(2), "inner_helix_strand and *2")
cmd,set("color", domain_color(3), "inner_helix_strand and *3")
show surface, inner_helix and not inner_helix_strand
cmd.set("transparency", default_surface_transparency())
save_image_filament("overview_surface_thioredoxins_23_domain_colors")


