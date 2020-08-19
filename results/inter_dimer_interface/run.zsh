#! /bin/zsh
#

mkdir -p output

rm output/*

phenix.mtz2map ../shared_pdb/solved_structures/native/6OWV_native_refined_map_coefficients.mtz output.directory=./output

phenix.mtz2map ../shared_pdb/solved_structures/yb/6OWW_yb_refined_map_coefficients.mtz output.directory=./output

pymol -cq make_figure_tetramer_interface_overview_yb.pml
pymol -cq make_figure_tetramer_interface_D348_D350_closeup.pml
pymol -cq make_figure_tetramer_interface_D351_E357_closeup.pml
pymol -cq make_figure_tetramer_interface_E184_E187_closeup.pml
pymol -cq make_figure_tetramer_interface_D144_E174_closeup.pml

pymol -cq make_figure_tetramer_interface_overview_CPVT.pml
pymol -cq make_figure_tetramer_interface_S173_closeup.pml
pymol -cq make_figure_tetramer_interface_K180_closeup.pml

alias crop="python ../../bin/utils/crop_to_bounding_box.py"
# Refresh the alias
source ~/.zshrc

crop ./output/tetramer_interface_overview_yb.png

crop ./output/tetramer_interface_D348_D350_closeup_yb.png
crop ./output/tetramer_interface_D348_D350_closeup_native_map.png
crop ./output/tetramer_interface_D348_D350_closeup_yb_map.png
crop ./output/tetramer_interface_D348_D350_closeup_yb_map_anom.png

crop ./output/tetramer_interface_D351_E357_closeup_yb.png
crop ./output/tetramer_interface_D351_E357_closeup_native_map.png
crop ./output/tetramer_interface_D351_E357_closeup_yb_map.png
crop ./output/tetramer_interface_D351_E357_closeup_yb_map_anom.png

crop ./output/tetramer_interface_E184_E187_closeup_yb.png
crop ./output/tetramer_interface_E184_E187_closeup_native_map.png
crop ./output/tetramer_interface_E184_E187_closeup_yb_map.png
crop ./output/tetramer_interface_E184_E187_closeup_yb_map_anom.png

crop ./output/tetramer_interface_D144_E174_closeup_yb.png
crop ./output/tetramer_interface_D144_E174_closeup_native_map.png
crop ./output/tetramer_interface_D144_E174_closeup_yb_map.png
crop ./output/tetramer_interface_D144_E174_closeup_yb_map_anom.png

crop ./output/tetramer_interface_overview_CPVT.png
crop ./output/tetramer_interface_overview_CPVT_90.png

crop ./output/tetramer_interface_S173_closeup.png
crop ./output/tetramer_interface_S173_closeup_native_map.png

crop ./output/tetramer_interface_K180_closeup_yb.png

