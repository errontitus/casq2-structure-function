#! /bin/zsh
#

mkdir -p output
rm ./output/*

# For Fig 1
python make_plots_CPVT_mutants.py

# Also for Fig 1
python make_plots_CPVT_mutants_K180R_Mg.py

# For Ext Data Fig 1
python make_plots_WT_EDTA.py

# For Fig 4
python make_plots_interface_mutants.py

# For Fig 6
python make_plots_interface_mutant_D325A.py
