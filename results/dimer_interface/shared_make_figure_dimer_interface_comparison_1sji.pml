@shared_make_figure_dimer_interface_comparison.pml
load ../shared_pdb/dimer_and_tetramer/output/dimer_1sji.pdb 
remove hetatm

super (dimer_1sji and ((chain A) or (chain B))), (dimer_deo_native and ((chain A) or (chain B)))

apply_standard_colors_dimer("dimer_1sji", 1)
apply_standard_colors_hetatm()

orient dimer_deo_native
zoom dimer_deo_native
rotate y, 45

