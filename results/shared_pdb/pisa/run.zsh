#! /bin/zsh
#

mkdir -p output
rm output/*

# To generate a config file. Edited by hand to modify output folder, no other changes.
# pisa -cfg-template > pisa.cfg

# PISA analysis of our structure.
pisa tetramer_deo_native -analyse ../dimer_and_tetramer/output/tetramer_deo_native_no_het.pdb ./pisa.cfg
pisa tetramer_1a8y -analyse ../dimer_and_tetramer/output/tetramer_1a8y_no_het.pdb ./pisa.cfg
pisa tetramer_1sji -analyse ../dimer_and_tetramer/output/tetramer_1sji_no_het.pdb ./pisa.cfg
pisa tetramer_2vaf -analyse ../dimer_and_tetramer/output/tetramer_2vaf_no_het.pdb ./pisa.cfg
pisa tetramer_3trp -analyse ../dimer_and_tetramer/output/tetramer_3trp_no_het.pdb ./pisa.cfg
pisa tetramer_3trq -analyse ../dimer_and_tetramer/output/tetramer_3trq_no_het.pdb ./pisa.cfg
pisa tetramer_3uom -analyse ../dimer_and_tetramer/output/tetramer_3uom_no_het.pdb ./pisa.cfg
pisa tetramer_3us3 -analyse ../dimer_and_tetramer/output/tetramer_3us3_no_het.pdb ./pisa.cfg
pisa tetramer_3v1w -analyse ../dimer_and_tetramer/output/tetramer_3v1w_no_het.pdb ./pisa.cfg
pisa tetramer_5crd -analyse ../dimer_and_tetramer/output/tetramer_5crd_no_het.pdb ./pisa.cfg
pisa tetramer_5cre -analyse ../dimer_and_tetramer/output/tetramer_5cre_no_het.pdb ./pisa.cfg
pisa tetramer_5crg -analyse ../dimer_and_tetramer/output/tetramer_5crg_no_het.pdb ./pisa.cfg
pisa tetramer_5crh -analyse ../dimer_and_tetramer/output/tetramer_5crh_no_het.pdb ./pisa.cfg
pisa tetramer_5kn0 -analyse ../dimer_and_tetramer/output/tetramer_5kn0_no_het.pdb ./pisa.cfg
pisa tetramer_5kn1 -analyse ../dimer_and_tetramer/output/tetramer_5kn1_no_het.pdb ./pisa.cfg
pisa tetramer_5kn2 -analyse ../dimer_and_tetramer/output/tetramer_5kn2_no_het.pdb ./pisa.cfg
pisa tetramer_5kn3 -analyse ../dimer_and_tetramer/output/tetramer_5kn3_no_het.pdb ./pisa.cfg

# Easy-readable output for numbers that will go in the manuscript.
pisa tetramer_deo_native -list interfaces ./pisa.cfg > ./output/tetramer_deo_native_no_het_pisa.txt
pisa tetramer_1sji -list interfaces ./pisa.cfg > ./output/tetramer_1sji_no_het_pisa.txt

pisa tetramer_deo_native -xml interfaces ./pisa.cfg > ./output/tetramer_deo_native_no_het_pisa.xml

pisa tetramer_1a8y -xml interfaces ./pisa.cfg > ./output/tetramer_1a8y_no_het_pisa.xml
pisa tetramer_1sji -xml interfaces ./pisa.cfg > ./output/tetramer_1sji_no_het_pisa.xml
pisa tetramer_2vaf -xml interfaces ./pisa.cfg > ./output/tetramer_2vaf_no_het_pisa.xml
pisa tetramer_3trp -xml interfaces ./pisa.cfg > ./output/tetramer_3trp_no_het_pisa.xml
pisa tetramer_3trq -xml interfaces ./pisa.cfg > ./output/tetramer_3trq_no_het_pisa.xml
pisa tetramer_3uom -xml interfaces ./pisa.cfg > ./output/tetramer_3uom_no_het_pisa.xml
pisa tetramer_3us3 -xml interfaces ./pisa.cfg > ./output/tetramer_3us3_no_het_pisa.xml
pisa tetramer_3v1w -xml interfaces ./pisa.cfg > ./output/tetramer_3v1w_no_het_pisa.xml
pisa tetramer_5crd -xml interfaces ./pisa.cfg > ./output/tetramer_5crd_no_het_pisa.xml
pisa tetramer_5cre -xml interfaces ./pisa.cfg > ./output/tetramer_5cre_no_het_pisa.xml
pisa tetramer_5crg -xml interfaces ./pisa.cfg > ./output/tetramer_5crg_no_het_pisa.xml
pisa tetramer_5crh -xml interfaces ./pisa.cfg > ./output/tetramer_5crh_no_het_pisa.xml
pisa tetramer_5kn0 -xml interfaces ./pisa.cfg > ./output/tetramer_5kn0_no_het_pisa.xml
pisa tetramer_5kn1 -xml interfaces ./pisa.cfg > ./output/tetramer_5kn1_no_het_pisa.xml
pisa tetramer_5kn2 -xml interfaces ./pisa.cfg > ./output/tetramer_5kn2_no_het_pisa.xml
pisa tetramer_5kn3 -xml interfaces ./pisa.cfg > ./output/tetramer_5kn3_no_het_pisa.xml
