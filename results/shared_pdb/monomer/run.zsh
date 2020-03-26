#! /bin/zsh
#

mkdir -p output
rm ./output/*

pymol -cq ../../../data/structure_other/1a8y.ent make_monomer_1A8Y.pml

pymol -cq ../../../data/structure_other/1sji.ent make_monomer_1sji.pml

pymol -cq ../../../data/structure_other/2vaf.ent make_monomer_2vaf.pml

pymol -cq ../solved_structures/native/6OWV_native.pdb make_monomer_deo_native.pml

# Ways to run DSSP in the future:
# http://www.cmbi.ru.nl/xssp/api/
# Example: http://www.cmbi.ru.nl/xssp/api/examples
#
# In the meantime, I used the web interface to get DSSP results for 6OWV.
# http://www.cmbi.ru.nl/xssp/output/pdb_file/dssp/5b9e1c3c-a821-4c08-878b-2253d6ea5858