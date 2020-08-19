@shared_make_figure_tetramer_interface_yb_closeup.pml

sele D351_E357, (resi 351 or resi 357) and (chain A or chain D) and tetramer_yb
sele D351_E357_native, (resi 351 or resi 357) and (chain A or chain D) and tetramer_native
sele interface_yb, elem Yb within 4.5 of D351_E357
sele interface_yb_A, elem Yb within 4.5 of (D351_E357 and Chain A)
sele interface_yb_D, elem Yb within 4.5 of (D351_E357 and Chain D)

hide everything
show cartoon, tetramer_yb
side_chain_helper("D351_E357")
show spheres, interface_yb

# All are bidentate
distance (tetramer_yb and (chain A) and i. 351 and n;OD1), (tetramer_yb and interface_yb_A)
distance (tetramer_yb and (chain A) and i. 351 and n;OD2), (tetramer_yb and interface_yb_A)

distance (tetramer_yb and (chain A) and i. 357 and n;OE1), (tetramer_yb and interface_yb_A)
distance (tetramer_yb and (chain A) and i. 357 and n;OE2), (tetramer_yb and interface_yb_A)

distance (tetramer_yb and (chain D) and i. 351 and n;OD1), (tetramer_yb and interface_yb_D)
distance (tetramer_yb and (chain D) and i. 351 and n;OD2), (tetramer_yb and interface_yb_D)

distance (tetramer_yb and (chain D) and i. 357 and n;OE1), (tetramer_yb and interface_yb_D)
distance (tetramer_yb and (chain D) and i. 357 and n;OE2), (tetramer_yb and interface_yb_D)

hide labels

select view_center, interface_yb
# rotate x, 180
# select to_show, (all) within 12.5 of view_center
# select to_hide, not to_show
# hide everything, to_hide

zoom view_center, 5
save_image_closeup("tetramer_interface_D351_E357_closeup_yb")

hide dashes

isomesh yb_mesh, yb_map, 1.5, tetramer_yb, carve=2.5
color blue, yb_mesh
show mesh, yb_mesh
save_image_closeup("tetramer_interface_D351_E357_closeup_yb_map")

hide everything, yb_mesh
isomesh yb_mesh_anom, yb_map_anom, 3, tetramer_yb, carve=3
color red, yb_mesh_anom
show mesh, yb_mesh_anom
save_image_closeup("tetramer_interface_D351_E357_closeup_yb_map_anom")

hide everything 
isomesh native_mesh, native_map, 1.5, D351_E357_native, carve=2
color blue, native_mesh
show mesh, native_mesh
show cartoon, tetramer_native
side_chain_helper("D351_E357_native")
save_image_closeup("tetramer_interface_D351_E357_closeup_native_map")
