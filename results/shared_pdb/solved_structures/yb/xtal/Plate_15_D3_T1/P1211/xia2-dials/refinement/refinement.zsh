#! /bin/zsh
#

# Useful tools:
#
# phenix.secondary_structure_restraints model.pdb ignore_annotation_in_file=True
# phenix.form_factor_query element=Br wavelength=0.8
# phenix.find_tls_groups model.pdb
# phenix.simple_ncs_from_pdb model.pdb
# phenix.pdbtools model.pdb set_b_iso=25

cp ../xia2-dials/DataFiles/AUTOMATIC_DEFAULT_free.mtz Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz

cp ../phaser/Plate_15_D3_T1_P1211_xia2_dials_monomer_search.1.pdb Plate_15_D3_T1_P1211_xia2_dials_starting_model.pdb

# For refinement of anomalous scatterers
phenix.form_factor_query element=Yb wavelength=1.38571 |& tee form_factor_query.log
# fp:  -19.7615
# fdp: 10.5444
#
# Note: refinement of anomalous scattering factors is not intended to help model-building or R/Rfree. It just flattens the anomalous map so that you can do a better job of placing additional anomalous scatterers (which may then help the model...)

## Since the Yb dataset is low-res, the plan here is to use reference restraints. If we wanted ss restraints instead, we could run something like this. NOTE: if this fails, rerun the phenix setup script.
# phenix.secondary_structure_restraints Plate_15_D3_T1_P1211_xia2_dials_starting_model.pdb ignore_annotation_in_file=True > all_ss_restraints.log
# cp all_ss_restraints.log all_ss_restraints.params
## Need to edit this file to remove everything above the pdb_interpretation line.

# Reset all B. Normally I do this after MR, but this is just a derivative structure. I don't think I want to do this in a structure where there isn't enough information to refine individual B. Keep the better information from the other structure.
# phenix.pdbtools Plate_15_D3_T1_P1211_xia2_dials_starting_model.pdb set_b_iso=25

# FreeR. Not needed since DIALS assigned flags.
# echo "Usage of freeRer: freeRer.com $mtzfile $priorFreeRmtzfile"
# echo "Use this command to generate freeR flags (only once!)."


####### NOTES FOR THIS DATASET 

# Model from native structure should already be good. No use for Autobuild, no use for simulated annealing.
# Since model is good, apply TLS right out of the gate.
# Use reference model restraints.
# May also need geometry weights in form of SS restraints or wxc target

# From https://www.phenix-online.org/documentation/faqs/refine.html#targets-and-restraints


####### What can I do to make my low-resolution structure better?

# In general, if NCS is present in your structure, you should always use NCS restraints at low resolution; it is worth trying both the Cartesian (global) and torsion restraints to see which works best for your model. This alone usually helps with the geometry and overfitting, although it is rarely sufficient by itself. There are also several different types of restraint specifically designed to help with low-resolution refinement (consult the full phenix.refine manual page for details on each):

### In this structure, NCS did not help. I think the different chains truly are different. They certainly are different in regard to location of Yb.

# Reference model: this restraints the torsion angles to a high-resolution model, using a potential that gently releases angles which are genuinely different (allowing both local deformations or domain movements). This is usually the best option, and typically improves both R-free, overfitting, and validation statistics. However, it depends on the availability of a suitable reference model.

### Tight reference restraints to the starting model seem to have helped.

# Secondary structure restraints: these are simply harmonic distance restraints between hydrogen-bonding atoms in protein helices and sheets, and nucleic acid base pairs. Annotation can be either automatic or manual. The primary limitation is currently the need for outlier filtering, which removes spurious bonds but also some genuine ones. It has a small effect on validation statistics, and typically none on R-free, but it does keep secondary structures stable.

### Reference restraints are stronger than secondary structure restraints and make more sense here.


####### Finding Yb Peaks

# Problem with phenix.find_peaks_holes: params are not processed correctly.
# Bug is in /Applications/phenix-1.15.2-3472/modules/cctbx_project/mmtbx/find_peaks.py
# edit min_model_peak_dist=1 (instead of 1.8)
# We'll just work around this by using find_peaks_holes

# Prefered to use phenix.find_peaks_holes instead of this.
# peakmax MAPIN 003_refined_001_anom.ccp4 XYZOUT 003_peakmax.pdb << END-peakmax
# THRESHOLD RMS 3.5
# END-peakmax


########## RUN 1
cp Plate_15_D3_T1_P1211_xia2_dials_starting_model.pdb 001_starting_model.pdb

phenix.refine Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 001_starting_model.pdb 001_refinement.params 

# Start R-work = 0.3619, R-free = 0.3516
# Final R-work = 0.3259, R-free = 0.3452

coot --pdb 001_refined_001.pdb --auto 001_refined_001.mtz

phenix.mtz2map 001_refined_001.mtz

# The cutoff of 3.8 is chosen because it results in sites that are 1) mostly acidic coordinated, and 2) have difference density and 2Fo-Fc density. We've also confirmed that placing at 3.5 does not discover anything else of interest.
# Note: had to hack the mmtx find_peaks file to get min_model_peak_dist=1 to work.
phenix.find_peaks_holes input.pdb.file_name=001_refined_001.pdb input.xray_data.file_name=Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz input.xray_data.r_free_flags.label=FreeR_flag anom_map_cutoff=3.8 map_cutoff=100 
wavelength=1.38571 min_model_peak_dist=1 output_file_prefix=001_ | tee 001_peaks_holes.log
mv peaks_holes.pdb 001_peaks_holes.pdb
mv peaks_holes_maps.mtz 001_peaks_holes_maps.mtz

cp 001_refined_001.pdb 001_refined_001_edited.pdb
sed -i '' -e '$ d' 001_refined_001_edited.pdb # Removes the END line.
# echo "TER" >> anom_model_001_edited.pdb
cat 001_peaks_holes.pdb | awk '$1=="ATOM" && $5=="C"{print "HETATM" substr($0,7,6) "  YB" " " " YB Y" substr($0,23,54) "Yb"}' > 001_yb_peaks.txt
echo "END" >> 001_yb_peaks.txt
cat 001_refined_001_edited.pdb 001_yb_peaks.txt > 001_refined_001_edited_yb.pdb

# Nothing to place. Areas where Yb appears to be missing, it is actually present as a symmetry mate (turn on symmetry mates to see)
coot --pdb 001_refined_001_edited_yb.pdb --auto 001_refined_001.mtz


########## RUN 2
# No actual edits. Just allowed Coot to save the file to clean up format.
cp 001_refined_001_edited_yb_edited.pdb 002_starting_model.pdb

phenix.refine Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 002_starting_model.pdb 002_refinement.params

# Actually happier result than our previous run. So either placing FEWER Yb helped, or eliminating group_adp from the from run helped.
# Start R-work = 0.4021, R-free = 0.4112
# Final R-work = 0.3049, R-free = 0.3295

phenix.mtz2map 002_refined_001.mtz

# Are there more Yb to place?
phenix.find_peaks_holes input.pdb.file_name=002_refined_001.pdb input.xray_data.file_name=Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz input.xray_data.r_free_flags.label=FreeR_flag anom_map_cutoff=3.8 map_cutoff=100 
wavelength=1.38571 min_model_peak_dist=1 output_file_prefix=002_ | tee 002_peaks_holes.log
mv peaks_holes.pdb 002_peaks_holes.pdb
mv peaks_holes_maps.mtz 002_peaks_holes_maps.mtz

# Go through the list and manually place just the ones at acidic residues:
# peak=    3.951 closest distance to pdb=" CD  PRO A 224 " =    1.016
# peak=    4.382 closest distance to pdb=" OD1 ASP A 310 " =    2.713 *
# peak=    3.938 closest distance to pdb=" OD1 ASP A 340 " =    5.201
# peak=    3.973 closest distance to pdb=" CA  VAL B 203 " =    1.475
# peak=    4.217 closest distance to pdb=" NH2 ARG B 246 " =    4.370
# peak=    4.103 closest distance to pdb=" OD1 ASP B 294 " =    2.073
# peak=    4.016 closest distance to pdb=" OD2 ASP B 350 " =    2.286 *
# peak=    4.001 closest distance to pdb=" CB  PHE C  70 " =    2.235
# peak=    4.056 closest distance to pdb=" CB  THR D 321 " =    1.920
# peak=    4.013 closest distance to pdb=" OD1 ASP E 351 " =    2.346 *
# peak=    4.822 closest distance to pdb=" CA  GLN G  44 " =    1.518
# peak=    3.965 closest distance to pdb=" CB  PHE G 129 " =    1.027
# peak=    4.296 closest distance to pdb=" CB  GLN G 156 " =    2.763
# peak=    4.123 closest distance to pdb=" CB  ILE H  75 " =    2.017
# peak=    4.143 closest distance to pdb=" O   GLY H 107 " =    3.530
# peak=    4.146 closest distance to pdb=" O   GLU H 256 " =    4.092

# Also place sulfates (go through in all chains)
coot --pdb 002_refined_001.pdb --auto 002_refined_001.mtz


########## RUN 3

cp 002_refined_001_edited.pdb 003_starting_model.pdb

phenix.refine Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 003_starting_model.pdb 003_refinement.params 

# Start R-work = 0.3240, R-free = 0.3469
# Final R-work = 0.3009, R-free = 0.3330

phenix.mtz2map 003_refined_001.mtz

# Are there more Yb to place?
phenix.find_peaks_holes input.pdb.file_name=003_refined_001.pdb input.xray_data.file_name=Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz input.xray_data.r_free_flags.label=FreeR_flag anom_map_cutoff=3.8 map_cutoff=100 
wavelength=1.38571 min_model_peak_dist=1 output_file_prefix=003_ | tee 003_peaks_holes.log
mv peaks_holes.pdb 003_peaks_holes.pdb
mv peaks_holes_maps.mtz 003_peaks_holes_maps.mtz

# peak=    4.039 closest distance to pdb=" CD  LYS A 180 " =    1.848
# peak=    4.031 closest distance to pdb=" CD  PRO A 224 " =    1.025
# peak=    4.003 closest distance to pdb=" OD1 ASP A 340 " =    4.942
# peak=    4.133 closest distance to pdb=" OD2 ASP A 364 " =    2.205
# peak=    3.947 closest distance to pdb=" CD2 PHE B 195 " =    1.062
# peak=    3.932 closest distance to pdb=" CA  VAL B 203 " =    1.398
# peak=    4.152 closest distance to pdb=" NH2 ARG B 246 " =    4.277
# peak=    3.951 closest distance to pdb=" CB  PHE C  70 " =    2.231
# peak=    4.341 closest distance to pdb=" CB  THR D 321 " =    1.978
# peak=    3.884 closest distance to pdb=" OD1 ASP E 351 " =    2.184 *
# peak=    4.605 closest distance to pdb=" CA  GLN G  44 " =    1.511
# peak=    4.241 closest distance to pdb=" CB  ILE H  75 " =    1.958
# peak=    4.134 closest distance to pdb=" OE1 GLU H 174 " =    2.118
# peak=    4.191 closest distance to pdb=" O   GLU H 256 " =    4.069
# peak=    3.985 closest distance to pdb=" OD1 ASP H 351 " =    1.734 *

# * indicates Yb placed. Sites where nothing was placed - no main map density.

# Placed a few additional Yb discovered through diff map peaks.
# Probably these escaped previous placement because the anom peak center is too close to the model.
coot --pdb 003_refined_001.pdb --auto 003_refined_001.mtz


########## RUN 4

cp 003_refined_001_edited.pdb 004_starting_model.pdb

phenix.refine Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 004_starting_model.pdb 004_refinement.params 

# Start R-work = 0.3086, R-free = 0.3400
# Final R-work = 0.2932, R-free = 0.3345

phenix.mtz2map 004_refined_001.mtz

# Are there more Yb to place?
phenix.find_peaks_holes input.pdb.file_name=004_refined_001.pdb input.xray_data.file_name=Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz input.xray_data.r_free_flags.label=FreeR_flag anom_map_cutoff=3.8 map_cutoff=100 
wavelength=1.38571 min_model_peak_dist=1 output_file_prefix=004_ | tee 004_peaks_holes.log
mv peaks_holes.pdb 004_peaks_holes.pdb
mv peaks_holes_maps.mtz 004_peaks_holes_maps.mtz

# peak=    4.055 closest distance to pdb=" CD  LYS A 180 " =    1.892
# peak=    4.114 closest distance to pdb=" CD  PRO A 224 " =    1.156
# peak=    3.943 closest distance to pdb=" OD1 ASP A 340 " =    4.702
# peak=    4.353 closest distance to pdb=" OD2 ASP A 364 " =    2.127
# peak=    3.864 closest distance to pdb=" O   GLU B 111 " =    4.761
# peak=    4.201 closest distance to pdb=" CA  VAL B 203 " =    1.411
# peak=    4.027 closest distance to pdb=" OD1 ASP B 294 " =    1.837
# peak=    3.928 closest distance to pdb=" CB  ALA D 186 " =    1.531
# peak=    4.286 closest distance to pdb=" CB  THR D 321 " =    2.001
# peak=    4.605 closest distance to pdb=" CA  GLN G  44 " =    1.517
# peak=    3.817 closest distance to pdb=" OD1 ASP G 310 " =    2.134
# peak=    4.287 closest distance to pdb=" CB  ILE H  75 " =    2.021
# peak=    4.117 closest distance to pdb=" O   GLY H 107 " =    3.655
# peak=    4.559 closest distance to pdb=" OE1 GLU H 174 " =    2.233
# peak=    4.170 closest distance to pdb=" O   GLU H 256 " =    4.048

# * Nothing worth placing.
# The rest of the Yb here turn out to be occupancy/position variants of existing placements.
# It may help both the map and refinement to place them, but not much given the low resolution of the data. Also, given the low resolution, these "alternate conformations", while probably representing truth, are not able to be portrayed accurately. So we won't place more.
# If we did want to place more, the easiest way is to place them on chain Z and then use pdbtools to renumber and combine into chain Y.

# No diff map peaks that have obvious explanations.
# Wiggled a couple things without much conviction.
coot --pdb 004_refined_001.pdb --auto 004_refined_001.mtz


########## RUN 5

cp 004_refined_001_edited.pdb 005_starting_model.pdb

phenix.refine Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 005_starting_model.pdb 005_refinement.params 

# Still improving.
# Start R-work = 0.2945, R-free = 0.3381
# Final R-work = 0.2916, R-free = 0.3364


########## RUN 6

cp 005_refined_001.pdb 006_starting_model.pdb

phenix.refine Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 006_starting_model.pdb 006_refinement.params 

# Still improving.
# Start R-work = 0.2926, R-free = 0.3400
# Final R-work = 0.2894, R-free = 0.3381

# Probably not too many more rounds, so did a review of Yb and removed bad ones.
coot --pdb 006_refined_001.pdb --auto 006_refined_001.mtz


########## RUN 7

cp 006_refined_001_edited.pdb 007_starting_model.pdb

phenix.refine Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 007_starting_model.pdb 007_refinement.params 

# Start R-work = 0.2962, R-free = 0.3448
# Final R-work = 0.2946, R-free = 0.3391

# More fine-tuning Yb sites, mainly ensuring consistency from chain to chain (but only where density and anomolous signal supports). Includes Yb at all intra-dimer D310 sites.
# also fixed chain A Leu 72 rotamer angles (PDB validation server reported bond angle deviation)
coot --pdb 007_refined_001.pdb --auto 007_refined_001.mtz

########## RUN 8

cp 007_refined_001_edited.pdb 008_starting_model.pdb

# For this run, reduced wxc_scale even further to avoid over-fitting.
phenix.refine Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz 008_starting_model.pdb 008_refinement_deposition.params 

# Start R-work = 0.3033, R-free = 0.3468
# Final R-work = 0.2921, R-free = 0.3407

# Further improvement unlikely.

# Not helping
# - running more cycles
# - switching to ss restraints
# - Autobuild with weights
# - placing Yb below 3.8. Actually does help a bit, but too many bad sites. It's fitting to total scattering rather than map. I can't defend depositing something like that. Continue to like placing at 3.8. You can really see the difference in the peak list btw 3.5 and 3.8. At 3.8 most of the near residues are acidic. That's what we want.
# - TLS
# - group ADP
# - placing more Yb (tried placing many more in a separate trial run; did not help)
# Refining with ss restraints does not give us better results, even after many cycles, and we lose the good geometry of the side chains that is enforced by the reference model.

