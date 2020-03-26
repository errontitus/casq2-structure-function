#! /bin/zsh
#

mkdir -p output

rm output/*

# Not super-useful as a figure, but can be used to quickly eyeball the range for the spectrum for a B factor color heatmap, which is easier to interpret in some ways.
# python ../../bin/structure/bfactor_plot/bfactor_plot.py ../../results/shared_pdb/monomer/output/monomer_deo_native_no_het.pdb
# python ../../bin/structure/bfactor_plot/bfactor_plot.py ../../results/shared_pdb/monomer/output/monomer_1sji_no_het.pdb

phenix.mtz2map ../shared_pdb/solved_structures/native/6OWV_native_refined_map_coefficients.mtz output.directory=./output

phenix.mtz2map ../shared_pdb/solved_structures/yb/6OWW_yb_refined_map_coefficients.mtz output.directory=./output

# PyMOL pairwise distances
# pymol -cq pairwise_distances_1sji.pml
# pymol -cq pairwise_distances_deo_native.pml

pymol -cq make_figure_dimer_interface_overview.pml
pymol -cq make_figure_dimer_interface_E143_closeup.pml 
pymol -cq make_figure_dimer_interface_D310_closeup.pml 

pymol -cq make_figure_dimer_interface_comparison_1sji_bsa.pml 
pymol -cq make_figure_dimer_interface_comparison_1sji_rmsd.pml 
# pymol -cq make_figure_dimer_interface_comparison_1sji_B_factor.pml 

# pymol -cq make_figure_dimer_interface_comparison_other_rmsd.pml 
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- deo_yb_CE
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- deo_yb_FD
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- deo_yb_HB
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 1a8y
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 1sji
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 2vaf
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 3trp
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 3trq
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 3uom
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 3us3
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 3v1w
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 5crd
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 5cre
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 5crg
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 5crh
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 5kn0
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 5kn1
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 5kn2
pymol -cq make_figure_dimer_interface_comparison_any_overlay.pml -- 5kn3

pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- deo_native
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 1a8y
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 1sji
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 2vaf
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 3trp
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 3trq
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 3uom
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 3us3
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 3v1w
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 5crd
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 5cre
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 5crg
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 5crh
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 5kn0
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 5kn1
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 5kn2
pymol -cq make_figure_dimer_interface_comparison_any_B_factor.pml -- 5kn3

# Does not help us compare, because rotations of oriented dimers are subtly different in each case.
# pymol -cq make_figure_dimer_interface_comparison_any_bb.pml -- deo_native

# https://pymolwiki.org/index.php/Angle_between_domains
pymol -cq make_figure_dimer_interface_comparison_1sji_angles.pml > ./output/dimer_interface_comparison_angles.log

# PISA analysis, should give results similar to the pairwise distances script.
pisa dimer_deo_native_no_het -analyse ../shared_pdb/dimer_and_tetramer/output/dimer_deo_native_no_het.pdb
pisa dimer_1sji_no_het -analyse ../shared_pdb/dimer_and_tetramer/output/dimer_1sji_no_het.pdb
pisa dimer_1a8y_no_het -analyse ../shared_pdb/dimer_and_tetramer/output/dimer_1a8y_no_het.pdb

pisa dimer_deo_native_no_het -list interfaces > ./output/pisa_interfaces_dimer_deo_native_no_het.log
pisa dimer_1sji_no_het -list interfaces > ./output/pisa_interfaces_dimer_1sji_no_het.log
pisa dimer_1a8y_no_het -list interfaces > ./output/pisa_interfaces_dimer_1a8y_no_het.log

alias crop="python ../../bin/utils/crop_to_bounding_box.py"
# Refresh the alias
source ~/.zshrc

crop ./output/dimer_interface_overview.png

crop ./output/dimer_interface_E143_closeup_yb_map_anom.png
crop ./output/dimer_interface_E143_closeup_yb_map.png
crop ./output/dimer_interface_E143_closeup_native_map.png
crop ./output/dimer_interface_E143_closeup_yb.png

crop ./output/dimer_interface_D310_closeup_yb_map_anom.png
crop ./output/dimer_interface_D310_closeup_yb_map.png
crop ./output/dimer_interface_D310_closeup_native_map.png
crop ./output/dimer_interface_D310_closeup_yb.png

crop ./output/dimer_1sji_bsa.png
crop ./output/dimer_deo_native_bsa.png
# crop ./output/dimer_chain_A_1sji_B_factor.png
# crop ./output/dimer_chain_A_deo_native_B_factor.png
crop ./output/dimer_interface_overlay_1sji_rmsd.png

crop ./output/dimer_interface_overlay_deo_yb_CE.png
crop ./output/dimer_interface_overlay_deo_yb_FD.png
crop ./output/dimer_interface_overlay_deo_yb_HB.png

crop ./output/dimer_interface_overlay_1a8y.png
crop ./output/dimer_interface_overlay_1sji.png
crop ./output/dimer_interface_overlay_2vaf.png
crop ./output/dimer_interface_overlay_3trp.png
crop ./output/dimer_interface_overlay_3trq.png
crop ./output/dimer_interface_overlay_3uom.png
crop ./output/dimer_interface_overlay_3us3.png
crop ./output/dimer_interface_overlay_3v1w.png
crop ./output/dimer_interface_overlay_5crd.png
crop ./output/dimer_interface_overlay_5cre.png
crop ./output/dimer_interface_overlay_5crg.png
crop ./output/dimer_interface_overlay_5crh.png
crop ./output/dimer_interface_overlay_5kn0.png
crop ./output/dimer_interface_overlay_5kn1.png
crop ./output/dimer_interface_overlay_5kn2.png
crop ./output/dimer_interface_overlay_5kn3.png

crop ./output/deo_native_B_factor.png
crop ./output/1a8y_B_factor.png
crop ./output/1sji_B_factor.png
crop ./output/2vaf_B_factor.png
crop ./output/3trp_B_factor.png
crop ./output/3trq_B_factor.png
crop ./output/3uom_B_factor.png
crop ./output/3us3_B_factor.png
crop ./output/3v1w_B_factor.png
crop ./output/5crd_B_factor.png
crop ./output/5cre_B_factor.png
crop ./output/5crg_B_factor.png
crop ./output/5crh_B_factor.png
crop ./output/5kn0_B_factor.png
crop ./output/5kn1_B_factor.png
crop ./output/5kn2_B_factor.png
crop ./output/5kn3_B_factor.png