@shared_make_figure_electrostatics.pml

sele D144_E174_native, (resi 144 or resi 174) and (chain E or chain D) and tetramer_deo_native_no_het

# sele interface_yb, elem Yb within 3.5 of D144_E174
# sele interface_yb_B, elem Yb within 3.5 of (D144_E174 and Chain B)
# sele interface_yb_C, elem Yb within 3.5 of (D144_E174 and Chain C)

hide everything
show cartoon, tetramer_deo_native_no_het
side_chain_helper("D144_E174")
show surface, tetramer_cavity 

zoom D144_E174_native, 3

# Weird that there is no way (that I know of) to hide the color bar.
# cmd.delete("elvl")

save_image_tetramer("tetramer_cavity_D144_E174_closeup")

