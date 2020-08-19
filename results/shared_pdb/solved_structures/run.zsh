#! /bin/zsh
#

# Native

native_path=./native/xtal/Plate_16_C2_T2/P4322/xia2-dials/refinement

# cp $native_path/D_9101001285_val-report-full_P1.pdf ./native/D_9101001285_val-report-full_P1.pdf

cp $native_path/013_refined_for_deposition_001.pdb ./native/6OWV_native_for_deposition.pdb
cp $native_path/013_refined_for_deposition_001.mtz ./native/6OWV_native_refined_map_coefficients.mtz

cp $native_path/013_refined_for_deposition_001.cif ./native/6OWV_native_for_deposition.cif
cp $native_path/013_refined_for_deposition_001.reflections.cif ./native/6OWV_native_refined_reflections_for_deposition.cif

cp $native_path/Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz ./native/6OWV_native_Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_free.mtz

cp $native_path/../xia2-dials/DataFiles/AUTOMATIC_DEFAULT_scaled_unmerged.mtz ./native/6OWV_native_Plate_16_C2_T2_P4322_xia2_dials_AUTOMATIC_DEFAULT_scaled_unmerged.mtz

# This is what is used for generating all our figures, the deposited PDB.
cp ./native/deposition_validation/D_1000241312_model-annotate_P1.pdb ./native/6OWV_native.pdb


# Yb

yb_path=./yb/xtal/Plate_15_D3_T1/P1211/xia2-dials/refinement

cp $yb_path/008_refined_for_deposition_001.pdb ./yb/6OWW_yb_for_deposition.pdb
cp $yb_path/008_refined_for_deposition_001.mtz ./yb/6OWW_yb_refined_map_coefficients.mtz

cp $yb_path/008_refined_for_deposition_001.cif ./yb/6OWW_yb_for_deposition.cif
cp $yb_path/008_refined_for_deposition_001.reflections.cif ./yb/6OWW_yb_refined_reflections_for_deposition.cif

cp $yb_path/Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz ./yb/6OWW_yb_Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_free.mtz

cp $yb_path/../xia2-dials/DataFiles/AUTOMATIC_DEFAULT_scaled_unmerged.mtz ./yb/6OWW_yb_Plate_15_D3_T1_P1211_xia2_dials_AUTOMATIC_DEFAULT_scaled_unmerged.mtz

# This is what is used for generating all our figures, the deposited PDB.
cp ./yb/deposition_validation/D_1000241405_model-annotate_P1.pdb ./yb/6OWW_yb.pdb
