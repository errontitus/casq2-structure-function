@shared_make_figure_dimer_interface_comparison.pml
run ../../bin/structure/pymol/color_b.py

# Get the other pdb.
pdb = get_arg1()
path = "../shared_pdb/dimer_and_tetramer/output/dimer_" + pdb + "." + "pdb"
print path
cmd.load(path, "dimer_other")

remove hetatm

# Align on chain A to show everything in the same orientation.
# This is a bit arbitrary for structures with multiple chains in the AU...
super (dimer_other and chain A), (dimer_deo_native and chain A)

# Option 1:
# I had this notion that I would show a spectrum with B factor Z scores. 
# Aside from this code being hard-to-read, it has other problems. It assumes parameters of the distribution, for one.
# So I prefer a simple, non-parametric range-based approach (below below).
# python 
# def normalized_bfactor(bfactor, bfactor_mean, bfactor_sd):
#     return (bfactor-bfactor_mean)/bfactor_sd
# python end

# # Get all the B factors from the selection
# stored.bfactors = []
# iterate (dimer_other and chain A), stored.bfactors.append(b)
# print(stored.bfactors)

# # Get the mean and sd of the B factors.
# mean_bfactor, sd_bfactor = average_b("dimer_other and chain A")

# new_bfactors = map(lambda x,y,z : normalized_bfactor(x, y, z), stored.bfactors, mean_bfactor, sd_bfactor)

# alter (dimer_other and chain A), b=new_bfactors.pop(0)

# Option 2: color_b
# This puts every structure on its own relative scale, so does not help with comparisons.
# Example of color_b usage:
# color_b (c. a | c. b),mode=ramp,gradient=bwr,nbins=30,sat=.5, value=1.
#   to color chains A and B with the Blue-White-Red gradient in 30 colors of equal
#   numbers of atoms in each color.

# color_b (dimer_other and chain A), mode=hist,gradient=bwr,nbins=30,sat=.5, value=1

# Option 3: use the same absolute scale for all the structures.
spectrum b, blue_white_magenta, minimum=1, maximum=200

hide everything
orient dimer_deo_native
zoom dimer_deo_native and chain A, 4
show cartoon, dimer_other and chain A

cartoon putty
set cartoon_flat_sheets, 0
unset cartoon_smooth_loops
save_image_dimer(pdb + "_B_factor")

