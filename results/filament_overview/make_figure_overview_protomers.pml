@shared_make_figure_overview.pml

orient filament_short and polymer
zoom_complete("filament_short")

hide everything 

apply_domain_colors(1, 1, "chain E", "deo_native")
apply_domain_colors(1, 2, "chain E", "deo_native")
apply_domain_colors(1, 3, "chain E", "deo_native")

apply_domain_colors(1, 1, "chain F", "deo_native")
apply_domain_colors(1, 2, "chain F", "deo_native")
apply_domain_colors(1, 3, "chain F", "deo_native")

cmd.translate([-30,0,0], "chain E")
cmd.translate([30,0,0], "chain F")
zoom (chain E or chain F) and polymer
show cartoon, chain E or Chain F
save_image_default("overview_monomers")
