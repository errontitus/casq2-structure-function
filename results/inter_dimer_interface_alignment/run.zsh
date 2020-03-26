#! /bin/zsh
#

mkdir -p output
rm output/*

# Interface residue mapping and alignment
pymol -cq make_interface_residue_lists.pml -- deo_native casq2
pymol -cq make_interface_residue_lists.pml -- 1a8y casq1
pymol -cq make_interface_residue_lists.pml -- 1sji casq2
pymol -cq make_interface_residue_lists.pml -- 2vaf casq2

pymol -cq make_interface_residue_lists.pml -- 3trp casq1
pymol -cq make_interface_residue_lists.pml -- 3trq casq1
pymol -cq make_interface_residue_lists.pml -- 3uom casq1
pymol -cq make_interface_residue_lists.pml -- 3us3 casq1
pymol -cq make_interface_residue_lists.pml -- 3v1w casq1

pymol -cq make_interface_residue_lists.pml -- 5crd casq1
# Point mutants
pymol -cq make_interface_residue_lists.pml -- 5cre casq1
pymol -cq make_interface_residue_lists.pml -- 5crg casq1
pymol -cq make_interface_residue_lists.pml -- 5crh casq1

pymol -cq make_interface_residue_lists.pml -- 5kn0 casq1
pymol -cq make_interface_residue_lists.pml -- 5kn1 casq1
pymol -cq make_interface_residue_lists.pml -- 5kn2 casq1
pymol -cq make_interface_residue_lists.pml -- 5kn3 casq1

#
# 1sji - casq2 canine
# 2vaf - casq2 homo 
#
# 1a8y - casq1 rabbit 
# 3trp - casq1 rabbit 
# 3trq - casq1 rabbit 
# 3us3 - casq1 rabbit 
#
# 3uom - casq1 human 
# 3v1w - casq1 rabbit 
#
# 5crd - casq1 human
# 5cre - casq1 human D210G
# 5crg - casq1 human D210G
# 5crh - casq1 human M53T
#
# 5kn0 - casq1 bovine
# 5kn1 - casq1 bovine
# 5kn2 - casq1 bovine
# 5kn3 - casq1 bovine
python make_interface_comparison_fasta.py 

clustalo -i ./output/pdb_interface_comparison_dimer.fasta -o ./output/pdb_interface_comparison_dimer_aligned.fasta --auto --force -v --output-order=input-order

clustalo -i ./output/pdb_interface_comparison_tetramer.fasta -o ./output/pdb_interface_comparison_tetramer_aligned.fasta --auto --force -v --output-order=input-order

python make_interface_residue_lists_texshade.py

# python make_interface_residue_lists_texshade_dimer.py