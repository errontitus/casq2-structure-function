@shared_make_figure_tetramer_interface_yb_closeup.pml

sele D348_D350, (resi 348 or resi 350) and (chain A or chain D) and tetramer_yb
sele D348_D350_native, (resi 348 or resi 350) and (chain A or chain D) and tetramer_native
sele interface_yb, elem Yb within 4.5 of D348_D350

show cartoon, tetramer_yb
side_chain_helper("D348_D350")
show spheres, interface_yb

# 348s can be bidentate, although sometimes aren't, depending on which structure we are refining.
distance (tetramer_yb and (chain A) and i. 348 and n;OD1), (tetramer_yb and (chain Y) and interface_yb)
distance (tetramer_yb and (chain A) and i. 348 and n;OD2), (tetramer_yb and (chain Y) and interface_yb)

distance (tetramer_yb and (chain D) and i. 348 and n;OD1), (tetramer_yb and (chain Y) and interface_yb)
# This one not so much in the yb structure.
# distance (tetramer_yb and (chain D) and i. 348 and n;OD2), (tetramer_yb and (chain Y) and i. 12)

distance (tetramer_yb and (chain A) and i. 350 and n;OD2), (tetramer_yb and (chain Y) and interface_yb)

distance (tetramer_yb and (chain D) and i. 350 and n;OD2), (tetramer_yb and (chain Y) and interface_yb)

hide labels

select view_center, interface_yb
# select to_show, (all) within 12.5 of view_center
# select to_hide, not to_show
# hide everything, to_hide

turn x, 90
zoom view_center, 6
save_image_closeup("tetramer_interface_D348_D350_closeup_yb")

hide dashes

isomesh yb_mesh, yb_map, 1.5, tetramer_yb, carve=2.5
color blue, yb_mesh
show mesh, yb_mesh
save_image_closeup("tetramer_interface_D348_D350_closeup_yb_map")

hide everything, yb_mesh
isomesh yb_mesh_anom, yb_map_anom, 3, tetramer_yb, carve=3
color red, yb_mesh_anom
show mesh, yb_mesh_anom
save_image_closeup("tetramer_interface_D348_D350_closeup_yb_map_anom")

hide everything 
isomesh native_mesh, native_map, 1.5, D348_D350_native, carve=2
color blue, native_mesh
show mesh, native_mesh
show cartoon, tetramer_native
side_chain_helper("D348_D350_native")
save_image_closeup("tetramer_interface_D348_D350_closeup_native_map")

bg_color white

# show labels 
