@shared_make_figure_tetramer_interface_yb_closeup.pml

sele D144_E174, (resi 144 or resi 174) and (chain C or chain B) and tetramer_yb
sele D144_E174_native, (resi 144 or resi 174) and (chain C or chain B) and tetramer_native
sele interface_yb, elem Yb within 4 of D144_E174
sele interface_yb_B, elem Yb within 4 of (D144_E174 and Chain B)
sele interface_yb_C, elem Yb within 4 of (D144_E174 and Chain C)

hide everything
show cartoon, tetramer_yb
side_chain_helper("D144_E174")
show spheres, interface_yb

# distance (tetramer_yb and (chain C) and i. 144 and n;OD1), (tetramer_yb and interface_yb_B)
distance (tetramer_yb and (chain C) and i. 144 and n;OD2), (tetramer_yb and interface_yb_B)

distance (tetramer_yb and (chain B) and i. 174 and n;OE1), (tetramer_yb and interface_yb_B)
distance (tetramer_yb and (chain B) and i. 174 and n;OE2), (tetramer_yb and interface_yb_B)

# distance (tetramer_yb and (chain B) and i. 144 and n;OD1), (tetramer_yb and interface_yb_C)
distance (tetramer_yb and (chain B) and i. 144 and n;OD2), (tetramer_yb and interface_yb_C)

distance (tetramer_yb and (chain C) and i. 174 and n;OE1), (tetramer_yb and interface_yb_C)
distance (tetramer_yb and (chain C) and i. 174 and n;OE2), (tetramer_yb and interface_yb_C)

turn x, 80
hide labels

select view_center, interface_yb
# rotate x, 180
# select to_show, (all) within 12.5 of view_center
# select to_hide, not to_show
# hide everything, to_hide

# Unusual situation where we want to override the usual square viewport.
x = 1200
y = 1200
cmd.viewport(x, y)
zoom view_center, 5
save_image_closeup("tetramer_interface_D144_E174_closeup_yb",x,y)

hide dashes

isomesh yb_mesh, yb_map, 1.5, tetramer_yb, carve=2.5
color blue, yb_mesh
show mesh, yb_mesh
save_image_closeup("tetramer_interface_D144_E174_closeup_yb_map",x,y)

hide everything, yb_mesh
isomesh yb_mesh_anom, yb_map_anom, 3, tetramer_yb, carve=3
color red, yb_mesh_anom
show mesh, yb_mesh_anom
save_image_closeup("tetramer_interface_D144_E174_closeup_yb_map_anom",x,y)

hide everything 
isomesh native_mesh, native_map, 1.5, D144_E174_native, carve=2
color blue, native_mesh
show mesh, native_mesh
show cartoon, tetramer_native
side_chain_helper("D144_E174_native")
save_image_closeup("tetramer_interface_D144_E174_closeup_native_map",x,y)
