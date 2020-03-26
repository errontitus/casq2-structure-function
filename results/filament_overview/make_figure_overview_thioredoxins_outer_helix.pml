@shared_make_figure_overview_thioredoxins.pml

hide everything
# Get rid of the inner helix so that we can create a closed surface of the outer helix (more visually appealing)
extract obj_inner_helix, inner_helix
zoom_complete("filament_short")
show surface, outer_helix
save_image_filament("overview_surface_thioredoxins_1")
color_thioredoxin_domains("deo_native", "filament")
save_image_filament("overview_surface_thioredoxins_1_domain_colors")