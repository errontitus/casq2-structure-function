#! /bin/zsh
#

########## NOTES ##########

#
# Useful tools:
#
# - phenix.secondary_structure_restraints model.pdb ignore_annotation_in_file=True
# - phenix.form_factor_query element=Br wavelength=0.8
# - phenix.find_tls_groups model.pdb
# - phenix.simple_ncs_from_pdb model.pdb
# - phenix.pdbtools model.pdb set_b_iso=25

#
# Important tasks:
#
# - Reset all B factors after MR.
# - Manually review residues before deposition. If you trimmed a side chain to Ala, the residue is still defined as whatever it was (not Ala), so a sequence comparison (done automatically by the PDB) won't pick up the missing atoms.

#
# Important tips and tricks:
#
# - Depending on resolution, during simulated annealing, additional reference restraints may be needed even beyond ss restraints (since the ss geometry restraints are flexible and allow atoms to pop out into bad density during SA).
# - Use reference restraints even in high-res structures for low-res disordered regions.
# - Refine with Amber if you can (but does not currently support broken chains)
# - Refine with AutoBuild if you can (but does not currently support alternate conformations)

#
# How to handle disordered regions:
#
# - The ideal:
#
# - Keep disordered regions until the end of refinement if they are not in negative density. As long as they are not in negative density, regions with little-to-no density can still contribute weakly (or are at least neutral) for phases. Keeping them also permits you to perform MD refinement. 
# - Refine with the disordered regions by setting their occupancy low and then permitting occupancy refinement. Use positive difference density, if any, to refine their positioning. 
# - Remove the disorded regions just before final refinement for deposition, but continue to refine using MD to keep good geometry and avoid clashes in semi-disordered regions that were good enough to retain but bad enough to need geometry restraints. NOTE: you can't actually do this right now, because MD does not work with a broken peptide chain.
#
# - The reality is that this does not matter very much and does not work too well yet:
#
# - You cannot use MD up through deposition, because it does not work with broken peptide chains. As soon as you remove a disordered region, you are stuck.
# - What you get from keeping disordered regions is very little, since the density is almost at the noise level.
# - Most of what you get from keeping disordered regions is more accurate total scattering, and you will lose this once you refine prior to deposition with those regions removed.


########## NOTES FOR THIS DATASET ##########

# - This dataset is not uniformly high-resolution, so we will use ss restraints for the poorly-resolved areas.


########## PREPARATION

cp ../xia2-dials/DataFiles/AUTOMATIC_DEFAULT_free.mtz Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz

cp ../phaser/Plate_16_C2_T2_P4322_xia2_dials_monomer_search.1.pdb Plate_16_C2_T2_P4322_xia2_dials_starting_model.pdb

# Apply free R flags. Not needed since done in xia2 pipeline.
# echo "Usage of freeRer: freeRer.com $mtzfile $priorFreeRmtzfile"
# echo "Use this command to generate freeR flags (only once!)."

# Reset all B, renumber residues, and remove one bad loop that we know we will rebuild manually (too difficult for Autobuild rebuild_in_place; probably would not be too difficult for Autobuild, but we do not use standard Autobuild for a model that is already high quality). 
phenix.pdbtools Plate_16_C2_T2_P4322_xia2_dials_starting_model.pdb set_b_iso=25 renumber_residues=True increment_resseq=19 remove="chain 'A' and ((resid 345 through 351))"


########## STARTING AUTOBUILD RUNS ##########

# With good model (> 50% seq identity) rebuild_in_place is recommended. 

# Since rebuild_in_place is not aggressive, bad regions that span multiple residues have to be fixed manually. 

# rebuild_in_place will not add residues, so this is not a way build missing regions.

# Using SA to remove model bias. We think this will cause a lot of movement in the regions with bad loops, but we think that's OK. 


########## RUN 1
cp Plate_16_C2_T2_P4322_xia2_dials_starting_model.pdb_modified.pdb 001_starting_model.pdb

phenix.autobuild data=Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz ../hCASQ2_after_TEV.fasta model=001_starting_model.pdb rebuild_in_place=True refine_eff_file=001_refinement_autobuild.params s_annealing=True nproc=5 run_command=sh background=True

coot --pdb AutoBuild_run_1_/overall_best.pdb --auto AutoBuild_run_1_/overall_best_refine_map_coeffs.mtz
# Manually rebuilt N terminus 
# Manually added 348 loop as poly-Ala. 
# Added sulfate and set occupancy.
# Fixed C terminus
# Cl at K320.
# Fixed one or two bad side chains in diff map > 5 rmsd.
# Checked/deleted waters.


########## RUN 2
cp 001_overall_best_edited.pdb 002_starting_model.pdb

phenix.autobuild data=Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz ../hCASQ2_after_TEV.fasta model=002_starting_model.pdb rebuild_in_place=True refine_eff_file=002_refinement_autobuild.params s_annealing=True nproc=5 run_command=sh background=True

coot --pdb AutoBuild_run_2_/overall_best.pdb --auto AutoBuild_run_2_/overall_best_refine_map_coeffs.mtz
# Added some Na
# Added a water that we think is hydronium. It's > 5 sigma. Phenix won't keep it.
# Changed some bad side chains to Ala to let autobuild rebuild them.


########## RUN 3
phenix.find_tls_groups AutoBuild_run_2_/overall_best.pdb

# Output included in refinement params:
#
# refinement.refine.adp {
#   tls = "chain 'A' and (resid   24  through  233 )"
#   tls = "chain 'A' and (resid  234  through  258 )"
#   tls = "chain 'A' and (resid  259  through  370 )"
# }
cp 002_overall_best_edited.pdb 003_starting_model.pdb

phenix.autobuild data=Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz ../hCASQ2_after_TEV.fasta model=003_starting_model.pdb rebuild_in_place=True refine_eff_file=003_refinement_autobuild.params s_annealing=True nproc=5 run_command=sh background=True

# Best solution on cycle: 1    R/Rfree=0.21/0.26
# Yay!

coot --pdb AutoBuild_run_3_/overall_best.pdb --auto AutoBuild_run_3_/overall_best_refine_map_coeffs.mtz
# Added as many Cl as possible down to 4.5 sigma.
# Pruned bad side chains to Ala down to 4.5 sigma.
# Built Ala at 23
# Fixed the 338 loop - make it more alpha-helix like.
# Changed rotamer at W361
# delete_residue_range(0, "A", 58, 68)
# delete_residue_range(0, "A", 258, 267)


########## RUN 4

# I prefer to do this in Coot (above) so that we don't lose header info:
# phenix.pdbtools 003_overall_best_edited.pdb remove="chain A and (resseq 58:69 or resseq 257:267)"

cp 003_overall_best_edited.pdb 004_starting_model.pdb

# Recalculate TLS groups since we deleted part of the model.
phenix.find_tls_groups 004_starting_model.pdb

# Add place_ions=Cl as well as occupancy refinement of Cl.
phenix.autobuild data=Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz ../hCASQ2_after_TEV.fasta model=004_starting_model.pdb rebuild_in_place=True refine_eff_file=004_refinement_autobuild.params s_annealing=True nproc=5 run_command=sh background=True

# Best solution on cycle: 1    R/Rfree=0.22/0.26

coot --pdb AutoBuild_run_4_/overall_best.pdb --auto AutoBuild_run_4_/overall_best_refine_map_coeffs.mtz
# Placed as many Cl- as we can. # Assigning a lot of Cl- to D/E coordination based on low pH: https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0202134
# alternate conformation at C53, M211, M344
# A bit of rebuilding at residue 338. SS restraints seem to be to strict here, so will remove now (even though building it as a mini helix helps).
# Some backbone fixups at the ends of the deleted regions.


########## RUN 5

cp 004_overall_best_edited.pdb 005_starting_model.pdb

# Drop in to standard refinement.
phenix.refine Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 005_starting_model.pdb 005_refinement.params 

# Start R-work = 0.2417, R-free = 0.2706
# Final R-work = 0.2083, R-free = 0.2401

coot --pdb 005_refined_001.pdb --auto 005_refined_001.mtz
# Fixed most of our targets to qualify for deposition.
# In future we think with better autobuild (e.g. ability to keep alternate conformations through the autobuild process) we would get here sooner.
# Did not have enough density to build tail, so let's do another round.


########## RUN 6

cp 005_refined_001_edited.pdb 006_starting_model.pdb

# Drop in to standard refinement.
#
# Realized at this point that 253-256 is a definitely an alpha helix and should be built like that. It's actually intact in model 001. It should have been preserved from the beginning. That means this goes into the restraints:
      #  helix {
      #    serial_number = "9"
      #    helix_identifier = "9"
      #    selection = chain 'A' and resid 253 through 256
      #  }
phenix.refine Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 006_starting_model.pdb 006_refinement.params 

# Start R-work = 0.3086, R-free = 0.3238
# Final R-work = 0.2039, R-free = 0.2424

coot --pdb 006_refined_001.pdb --auto 006_refined_001.mtz
# Getting closer but had to do more C terminus fixups.


########## RUN 7

cp 006_refined_001_edited.pdb 007_starting_model.pdb

# Since the neg diff density is so bad, trying occupancy refinement in the N terminus.
phenix.refine Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 007_starting_model.pdb 007_refinement.params 

# Start R-work = 0.2362, R-free = 0.2637
# Final R-work = 0.2035, R-free = 0.2433

coot --pdb 007_refined_001.pdb --auto 007_refined_001.mtz
# Getting closer but had to do more C terminus fixups.


########## RUN 8

cp 007_refined_001_edited.pdb 008_starting_model.pdb

phenix.refine Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 008_starting_model.pdb 008_refinement.params 

# Start R-work = 0.2140, R-free = 0.2483
# Final R-work = 0.2042, R-free = 0.2447

coot --pdb 008_refined_001.pdb --auto 008_refined_001.mtz
# Getting closer but had to do more C terminus fixups.


########## RUN 9

cp 008_refined_001_edited.pdb 009_starting_model.pdb

phenix.refine Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 009_starting_model.pdb 009_refinement.params 

# Start R-work = 0.2322, R-free = 0.2691
# Final R-work = 0.2033, R-free = 0.2446

# Getting ready for deposition, so let's do a careful check of all side chains. The sequence comparison that we get from the PDB is not enough. We need to make sure we didn't prune or accidentally delete any atoms that we wanted to leave in place.
coot --pdb 009_refined_001.pdb --auto 009_refined_001.mtz
# Done on this round:
# E174 side chain restored. We are up front in the manuscript about the fact that we don't have good density for it. Overall it's less confusing to include it.
# Flipped some side chains:
# 140, 143, 144, 147, 275, 278, 280
# Could build 258 but elected not. It's still in poor density.
# Fixed up some other side chains that had been left Ala by autobuild (in addition to 174, others included 338, 370, 371).

########## RUN 10

cp 009_refined_001_edited.pdb 010_starting_model.pdb

phenix.refine Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 010_starting_model.pdb 010_refinement.params 

coot --pdb 010_refined_001.pdb --auto 010_refined_001.mtz
# Placed a couple chlorides

########## RUN 11

cp 010_refined_001_edited.pdb 011_starting_model.pdb

phenix.refine Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 011_starting_model.pdb 011_refinement.params 

coot --pdb 011_refined_001.pdb --auto 011_refined_001.mtz
# Removed Cl and Na that I didn't think belonged. Ready for final touchups.

########## DEPOSITION

# Strategy
#
# - Must include 2 cycles of refinement.
# - Cycle 1: normal refinement plus:
#   -nonbonded_weight=1000 
#   -switch_rotamers=fix_outliers
#   -min_model_peak_dist = 2.2 (matches PDB criteria for avoiding water clashes)
#
# - Open model and fix remaining rotamer problems:
#   -Rotamers
#   -Review metals manually or with check my metal
#
# - Cycle 2: refine with 
#   -water filtering only
#   -ADP only, to avoid undoing fixes.
#
# - Checklist
#   - have been using ordered_solvent and contining to do so
#   - ordered_solvent min distance set to 2.0
#   - Already have gone through chlorides and metals and deleted bad ones.
#   - No more use of automated place_ions - filtering waters and metals, not adding
#
# - Not needed since we ditched real space refinement
#   - Restrain Y282, since real space refinement wrecks it.
#   - Restrain the C terminal tail, since real space refinement wrecks it.
cp 011_refined_001_edited.pdb 012_starting_model.pdb

# Lots of clashes and outliers.
phenix.clashscore 012_starting_model.pdb outliers_only=True
phenix.rotalyze 012_starting_model.pdb outliers_only=True
phenix.ramalyze 012_starting_model.pdb outliers_only=True

# Refine with nonbonded_weight and fix_outliers
phenix.refine Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 012_starting_model.pdb 012_refinement.params refinement.pdb_interpretation.nonbonded_weight=1000

# Few clashes and outliers.
phenix.clashscore 012_refined_001.pdb outliers_only=True
phenix.rotalyze 012_refined_001.pdb outliers_only=True
phenix.ramalyze 012_refined_001.pdb outliers_only=True

# Try to fix, by refining to density and restraints, and then re-choosing standard rotamers in Coot. 
# residue:occupancy:score%:chi1:chi2:chi3:chi4:evaluation:rotamer
#  A  35  VAL:1.00:0.3:276.9::::OUTLIER:OUTLIER
#  A  45  VAL:1.00:0.3:317.8::::OUTLIER:OUTLIER
#  A  72  LEU:1.00:0.1:53.7:110.5:::OUTLIER:OUTLIER
#  A 101  LYS:1.00:0.2:39.2:168.1:218.5:311.7:OUTLIER:OUTLIER
#  A 291  VAL:1.00:0.2:320.3::::OUTLIER:OUTLIER
#  A 365  VAL:1.00:0.2:148.9::::OUTLIER:OUTLIER
# SUMMARY: 2.01% outliers (Goal: < 0.3%)
# residue:score%:phi:psi:evaluation:type
#  A 370  ILE:0.01:71.16:137.32:OUTLIER:Isoleucine or valine
#
# Particular attention to rotamers 365, 370, 371. Worst clashes coming from these.
#
coot --pdb 012_refined_001.pdb --auto 012_refined_001.mtz

# Even fewer clashes and outliers.
phenix.clashscore 012_refined_001_edited.pdb outliers_only=True
phenix.rotalyze 012_refined_001_edited.pdb outliers_only=True
phenix.ramalyze 012_refined_001_edited.pdb outliers_only=True

# PDB Validation server picks up a few more issues. Fix these, too:
# Residue(model/chain/number/name)	Atom	Residue(model/chain/number/name)	Atom	Distance between the atoms
# 1/A/164/TYR	O	1/S/25/HOH	O	1.89
# 1/A/218/GLU	N	1/S/33/HOH	O	2.16
# Symmetry Clashes
# The following atoms were found to be clashing with symmetry related atoms.
# Residue(model/chain/number/name)	Atom	Symmetry operator	Residue(model/chain/number/name)	Atom	Symmetry operator	Distance between the atoms
# 1/A/235/GLU	OE2	1_555	1/A/367/SER	O	5_555	2.06
coot --pdb 012_refined_001_edited.pdb --auto 012_refined_001.mtz

cp 012_refined_001_edited.pdb 013_starting_model.pdb

# Refine for deposition
phenix.refine Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 013_starting_model.pdb 013_refinement_deposition.params 

# Start R-work = 0.2274, R-free = 0.2583
# Final R-work = 0.2130, R-free = 0.2490

phenix.clashscore 013_refined_for_deposition_001.pdb outliers_only=True
phenix.rotalyze 013_refined_for_deposition_001.pdb outliers_only=True
phenix.ramalyze 013_refined_for_deposition_001.pdb outliers_only=True

coot --pdb 013_refined_for_deposition_001.pdb --auto 013_refined_for_deposition_001.mtz

# Yes, these cis peptides are very well supported by the map (nothing to do):
# %   GLN  A  190  PRO  A  191    -1.07  
# %   LYS  A  230  PRO  A  231    0.01

# We had good success with the following strategy:
#   No group ADP
#   Using Autobuild as long as possible
#   Place Cl- where possible - but only helps a little bit.
#   Filter waters at distance 2.2 to comply with PDB.
#   SS restraints for the low res regions. This was critical.
#
# Occupancy refinement of the N terminus was tried but was not helpful.
#
# What we could have done differently:
#   occupancy refinement of all metals from early in Autobuild.
#   253-256 now looks like an alpha helix and chould have been built like that from the beginning. That means this would go into the restraints:
#       helix {
#         serial_number = "9"
#         helix_identifier = "9"
#         selection = chain 'A' and resid 253 through 256
#       }