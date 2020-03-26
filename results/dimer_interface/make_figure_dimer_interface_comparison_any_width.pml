@shared_make_figure_dimer_interface_comparison.pml
run ../../bin/structure/pymol/Draw_Protein_Dimensions.py

# Get the other pdb.
pdb = get_arg1()
path = "../shared_pdb/dimer_and_tetramer/output/dimer_" + pdb + "." + "pdb"
print path
cmd.load(path, "dimer_other")

apply_standard_colors_dimer("dimer_other", 3)
remove hetatm

# Align 
super (dimer_other), (dimer_deo_native)

hide everything
show cartoon, dimer_other

distance (dimer_other and (chain A) and i. 177 and n;CA), (dimer_other and (chain B) and i. 177 and n;CA)

distance (dimer_deo_native and (chain A) and i. 177 and n;CA), (dimer_deo_native and (chain B) and i. 177 and n;CA)

# Can also draw dimensions, but it doesn't help, because the oriented views used for the bounding box are subtly different.
# draw_Protein_Dimensions("dimer_other")
# show cgo

orient dimer_other
zoom dimer_other, 5

set dash_radius, 0.05

# Result: 79 A (1sji) vs 73 A (ours)