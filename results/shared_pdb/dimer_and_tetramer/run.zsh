#! /bin/zsh
#

mkdir -p output
rm output/*

# Our native structure. 
pymol -cq ../solved_structures/native/6OWV_native.pdb make_dimer_and_tetramer_deo_native.pml

#########################

# Make some mutants that can be used for electrostatics or simulations.
# Usage:   python mutate_model.py modelname respos resname chain > logfile
#
# Example: python mutate_model.py 1t29 1699 LEU A > 1t29.log
# cd output

# # 144Q
# python ../../../../bin/structure/modeller/mutate_model.py inter_dimer_deo_native_no_het.pdb 144 GLN B > inter_dimer_deo_native_no_het_B_D144Q.log

# python ../../../../bin/structure/modeller/mutate_model.py inter_dimer_deo_native_no_het.pdbGLN144.pdb 144 GLN C > inter_dimer_deo_native_no_het_B_D144Q_C_D144Q.log

# 144A
# python ../../../../bin/structure/modeller/mutate_model.py inter_dimer_deo_native_no_het.pdb 144 ALA B > inter_dimer_deo_native_no_het_B_D144A.log

# python ../../../../bin/structure/modeller/mutate_model.py inter_dimer_deo_native_no_het.pdbALA144.pdb 144 ALA C > inter_dimer_deo_native_no_het_B_D144A_C_D144A.log

# # 174A
# python ../../../../bin/structure/modeller/mutate_model.py inter_dimer_deo_native_no_het.pdb 174 ALA B > inter_dimer_deo_native_no_het_B_D174A.log

# python ../../../../bin/structure/modeller/mutate_model.py inter_dimer_deo_native_no_het.pdbALA174.pdb 174 ALA C > inter_dimer_deo_native_no_het_B_D174A_C_D174A.log

# cd ..

#########################

# The 1998 structure.
pymol -cq ../../../data/structure_other/1a8y.ent make_dimer_and_tetramer_1a8y.pml

# Make two others that are most relevant.
pymol -cq ../../../data/structure_other/1sji.ent make_dimer_and_tetramer_1sji.pml
pymol -cq ../../../data/structure_other/2vaf.ent make_dimer_and_tetramer_2vaf.pml

# Make all others (pretty fast, so OK to do here even if some of these will be used only in the supplement).
pymol -cq ../../../data/structure_other/3trp.ent make_dimer_and_tetramer_3trp.pml
pymol -cq ../../../data/structure_other/3trq.ent make_dimer_and_tetramer_3trq.pml
pymol -cq ../../../data/structure_other/3uom.ent make_dimer_and_tetramer_3uom.pml
pymol -cq ../../../data/structure_other/3us3.ent make_dimer_and_tetramer_3us3.pml
pymol -cq ../../../data/structure_other/3v1w.ent make_dimer_and_tetramer_3v1w.pml

pymol -cq ../../../data/structure_other/5crd.ent make_dimer_and_tetramer_5crd.pml
pymol -cq ../../../data/structure_other/5cre.ent make_dimer_and_tetramer_5cre.pml
pymol -cq ../../../data/structure_other/5crg.ent make_dimer_and_tetramer_5crg.pml
pymol -cq ../../../data/structure_other/5crh.ent make_dimer_and_tetramer_5crh.pml

pymol -cq ../../../data/structure_other/5kn0.ent make_dimer_and_tetramer_5kn0.pml
pymol -cq ../../../data/structure_other/5kn1.ent make_dimer_and_tetramer_5kn1.pml
pymol -cq ../../../data/structure_other/5kn2.ent make_dimer_and_tetramer_5kn2.pml
pymol -cq ../../../data/structure_other/5kn3.ent make_dimer_and_tetramer_5kn3.pml

