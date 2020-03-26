@shared_make_figure_filament_comparison.pml

create_thioredoxin_domains("ABCDEFGHIJKLMN", pdb_code, "filament", 0)
color_thioredoxin_domains(pdb_code, "filament")

set sphere_scale, 1.0, polymer
show spheres, filament_short and polymer
save_image_filament(filament + "_spheres")
