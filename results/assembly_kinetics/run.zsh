#! /bin/zsh
#

mkdir -p output
rm ./output/*

python make_plots_interface_mutants.py
python make_plots_interface_mutant_D325A.py
python make_plots_CPVT_mutants.py
python make_plots_CPVT_mutants_K180R_Mg.py
python make_plots_WT_EDTA.py