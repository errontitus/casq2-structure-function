#! /bin/zsh
#

mkdir -p output
rm output/*

# Make tetramer figures

# P4322
pymol -cq make_figure_tetramer_for_comparison.pml -- deo_native

# C2221 (canonical)
pymol -cq make_figure_tetramer_for_comparison.pml -- 1a8y
pymol -cq make_figure_tetramer_for_comparison.pml -- 3trp
pymol -cq make_figure_tetramer_for_comparison.pml -- 3trq
pymol -cq make_figure_tetramer_for_comparison.pml -- 3us3
pymol -cq make_figure_tetramer_for_comparison.pml -- 3v1w
pymol -cq make_figure_tetramer_for_comparison.pml -- 5crd
pymol -cq make_figure_tetramer_for_comparison.pml -- 5kn3

# I4
pymol -cq make_figure_tetramer_for_comparison.pml -- 1sji

# I4122
pymol -cq make_figure_tetramer_for_comparison.pml -- 2vaf

# P1
pymol -cq make_figure_tetramer_for_comparison.pml -- 3uom
# P1 but actually same interfaces as the C2221 (canonical) structures.
pymol -cq make_figure_tetramer_for_comparison.pml -- 5kn0

# P21212
pymol -cq make_figure_tetramer_for_comparison.pml -- 5cre

# P21
pymol -cq make_figure_tetramer_for_comparison.pml -- 5crg
pymol -cq make_figure_tetramer_for_comparison.pml -- 5crh

# C2221 (other)
pymol -cq make_figure_tetramer_for_comparison.pml -- 5kn1
pymol -cq make_figure_tetramer_for_comparison.pml -- 5kn2

#
alias crop="python ../../bin/utils/crop_to_bounding_box.py"

crop ./output/tetramer_deo_native_oriented.png

crop ./output/tetramer_1a8y_oriented.png
crop ./output/tetramer_3trp_oriented.png
crop ./output/tetramer_3trq_oriented.png
crop ./output/tetramer_3us3_oriented.png
crop ./output/tetramer_3v1w_oriented.png
crop ./output/tetramer_5crd_oriented.png
crop ./output/tetramer_5kn3_oriented.png

crop ./output/tetramer_1sji_oriented.png

crop ./output/tetramer_2vaf_oriented.png

crop ./output/tetramer_3uom_oriented.png
crop ./output/tetramer_5kn0_oriented.png

crop ./output/tetramer_5cre_oriented.png

crop ./output/tetramer_5crg_oriented.png
crop ./output/tetramer_5crh_oriented.png

crop ./output/tetramer_5kn1_oriented.png
crop ./output/tetramer_5kn2_oriented.png

python make_tables_inter_dimer_BSA.py


# pymol -cq make_figure_tetramer_interface_1a8y_N173.pml
# pymol -cq make_figure_tetramer_interface_1sji_S173.pml
# pymol -cq make_figure_tetramer_interface_2vaf_S173.pml

