@shared_make_figure_electrostatics.pml

hide everything
show cartoon, tetramer_deo_native_no_het
show surface, tetramer_cavity

zoom tetramer_deo_native_no_het, -15

# Weird that there is no way (that I know of) to hide the color bar.
# cmd.delete("elvl")

save_image_tetramer("tetramer_cavity_apbs_side")