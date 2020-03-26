#! /bin/zsh
#

mkdir -p output
rm ./output/*

pymol -cq make_figure_electrostatics_dimer.pml
pymol -cq make_figure_electrostatics_dimer_axial.pml
pymol -cq make_figure_electrostatics_tetramer.pml
pymol -cq make_figure_electrostatics_D144_E174_closeup.pml

pymol -cq make_figure_dimer_cavity_axial.pml 

# pymol -cq make_figure_dimer_cavity.pml 
# pymol -cq make_figure_tetramer_cavity.pml 

alias crop_bb="python ../../bin/utils/crop_to_bounding_box.py"
alias crop="python ../../bin/utils/crop.py"
# Refresh the alias
source ~/.zshrc

crop_bb ./output/dimer_cavity_axial.png

crop_bb ./output/tetramer_cavity_D144_E174_closeup.png
cp ./output/tetramer_cavity_D144_E174_closeup_cropped.png ./output/tetramer_cavity_D144_E174_closeup_no_ramp.png
# left, top, right, bottom
crop ./output/tetramer_cavity_D144_E174_closeup_no_ramp.png 200 0 1000 620


crop_bb ./output/dimer_cavity_apbs_axial.png
cp ./output/dimer_cavity_apbs_axial_cropped.png ./output/dimer_cavity_apbs_axial_no_ramp.png
# left, top, right, bottom
crop ./output/dimer_cavity_apbs_axial_no_ramp.png 0 0 844 710


crop_bb ./output/dimer_cavity_apbs_side.png
cp ./output/dimer_cavity_apbs_side_cropped.png ./output/dimer_cavity_apbs_side_no_ramp.png
# left, top, right, bottom
crop ./output/dimer_cavity_apbs_side_no_ramp.png 0 0 966 760


crop_bb ./output/tetramer_cavity_apbs_side.png
cp ./output/tetramer_cavity_apbs_side_cropped.png ./output/tetramer_cavity_apbs_side_no_ramp.png
# left, top, right, bottom
crop ./output/tetramer_cavity_apbs_side_no_ramp.png 0 0 988 560

# Do this separately, since it takes longer.
pymol -cq make_figure_filament_cavity_with_surface_and_yb_cutaway.pml

crop_bb ./output/filament_cavity_and_yb_blend_cutaway.png