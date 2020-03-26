@shared_make_figure_filament_comparison.pml

create_thioredoxin_domains("ABCDEFGHIJ", pdb_code, "filament", 1)
color_thioredoxin_globes()
show spheres, ps*
save_image_filament(filament + "_thioredoxin_globes")
