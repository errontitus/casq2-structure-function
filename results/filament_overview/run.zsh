#! /bin/zsh
#

mkdir -p output
rm output/*

pymol -cq make_figure_overview_surface.pml
pymol -cq make_figure_overview_dimer.pml
pymol -cq make_figure_overview_tetramer.pml
pymol -cq make_figure_overview_protomers.pml
pymol -cq make_figure_overview_thioredoxins_all.pml
pymol -cq make_figure_overview_thioredoxins_inner_helix.pml
pymol -cq make_figure_overview_thioredoxins_outer_helix.pml

alias crop="python ../../bin/utils/crop_to_bounding_box.py"
# Refresh the alias
source ~/.zshrc

crop ./output/overview_surface.png
crop ./output/overview_dimer.png
crop ./output/overview_tetramer.png
crop ./output/overview_tetramer_oriented.png
crop ./output/overview_monomers.png

crop ./output/overview_surface_thioredoxins.png
crop ./output/overview_surface_thioredoxins_1.png ./output/overview_surface_thioredoxins.png
crop ./output/overview_surface_thioredoxins_23.png ./output/overview_surface_thioredoxins.png
crop ./output/overview_surface_thioredoxins_1_domain_colors.png ./output/overview_surface_thioredoxins.png
crop ./output/overview_surface_thioredoxins_23_domain_colors.png ./output/overview_surface_thioredoxins.png
