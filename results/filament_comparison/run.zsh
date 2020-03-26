#! /bin/zsh
#

mkdir -p output
rm output/*

pymol -cq make_figure_filament_comparison_spheres.pml -- filament_deo_native deo_native
pymol -cq make_figure_filament_comparison_spheres.pml -- filament_1a8y 1a8y
pymol -cq make_figure_filament_comparison_spheres.pml -- filament_1sji 1sji

pymol -cq make_figure_filament_comparison_globes.pml -- filament_deo_native deo_native
pymol -cq make_figure_filament_comparison_globes.pml -- filament_1a8y 1a8y
pymol -cq make_figure_filament_comparison_globes.pml -- filament_1sji 1sji

alias crop="python ../../bin/utils/crop_to_bounding_box.py"

crop ./output/filament_1a8y_spheres.png
crop ./output/filament_1a8y_thioredoxin_globes.png
crop ./output/filament_1sji_spheres.png
crop ./output/filament_1sji_thioredoxin_globes.png
crop ./output/filament_deo_native_spheres.png 
crop ./output/filament_deo_native_thioredoxin_globes.png