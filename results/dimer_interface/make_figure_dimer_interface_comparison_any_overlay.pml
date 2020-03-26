@shared_make_figure_dimer_interface_comparison.pml

# Get the other pdb.
pdb = get_arg1()
path = "../shared_pdb/dimer_and_tetramer/output/dimer_" + pdb + "." + "pdb"
print path
cmd.load(path, "dimer_other")

apply_standard_colors_dimer("dimer_other", 3)
remove hetatm

# Align on chain A and see how much rotation is applied to chain B.
super (dimer_other and ((chain A))), (dimer_deo_native and ((chain A)))

hide everything
show cartoon, dimer_other or dimer_deo_native
orient dimer_deo_native
zoom dimer_deo_native, 5

color yelloworange, dimer_other and chain A
color limon, dimer_other and chain B

save_image_dimer("dimer_interface_overlay_" + pdb)

