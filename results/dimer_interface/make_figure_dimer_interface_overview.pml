@shared_make_figure_dimer_interface_yb_overview.pml

# rotate y, 45
# translate the copy of the ligands away from the camera
# translate [0,0,-3], yb_copy
# cmd.set("surface_color", chainB_color(1), "chain B")
# # show surface, chain B
# disable yb_copy

# orient dimer
show cartoon, dimer_yb

extract obj_chain_A, chain A and dimer_yb
extract obj_chain_B, chain B and dimer_yb

zoom obj_chain_A or obj_chain_B

save_image_dimer("dimer_interface_overview")
