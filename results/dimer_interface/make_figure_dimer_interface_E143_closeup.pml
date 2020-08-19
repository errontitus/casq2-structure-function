@shared_make_figure_dimer_interface_yb_detail.pml

# Remove 136, 277, 309
# Yb is closest to 280 and 143 (4 A is quite safe)
sele dimer_yb_residues, \
    (resi 140 or resi 143 or resi 147 or resi 275 or resi 278 or resi 280) and dimer_yb_polymer

sele yb_143_A, elem yb within 4 of (polymer and chain A and resi 143)
sele yb_280_B, elem yb within 4 of (polymer and chain B and resi 280)

sele dimer_native_residues, \
    (resi 140 or resi 143 or resi 147 or resi 275 or resi 278 or resi 280) and dimer_native_polymer

hide everything

# Yb that appears only in a higher-multiplicity structure (P 43 212 solution that we rejected, because it is pseudosymmetric)
# A 136 OE1 and 2 
# A 140 OD2
# B 277 OG
# B 309 OD1
# distance (dimer and (chain A) and i. 136 and n;OE1), (dimer and i. 18)
# distance (dimer and (chain A) and i. 136 and n;OE2), (dimer and i. 18)
# distance (dimer and (chain A) and i. 140 and n;OD2), (dimer and i. 18)
# distance (dimer and (chain B) and i. 277 and n;OG), (dimer and i. 18)
# distance (dimer and (chain B) and i. 309 and n;OD1), (dimer and i. 18)

# yb 
# A 140 OD1
# A 143 OE2 and 1
# B 275 OE2 and 1
# B 278 OD2
distance (dimer_yb and (chain A) and i. 140 and n;OD1), (dimer_yb and yb_143_A)
distance (dimer_yb and (chain A) and i. 143 and n;OE1), (dimer_yb and yb_143_A)
distance (dimer_yb and (chain A) and i. 143 and n;OE2), (dimer_yb and yb_143_A)
distance (dimer_yb and (chain B) and i. 275 and n;OE1), (dimer_yb and yb_143_A)
distance (dimer_yb and (chain B) and i. 275 and n;OE2), (dimer_yb and yb_143_A)
# distance (dimer and (chain B) and i. 278 and n;OD2), (dimer and yb_143_A)

# Yb that appears only in a higher-multiplicity structure (P 43 212 solution that we rejected, because it is pseudosymmetric)
# A 143 OE2
# A 147 OE2
# B 278 OD2 
# distance (dimer and (chain A) and i. 143 and n;OE2), (dimer and i. 11)
# distance (dimer and (chain A) and i. 147 and n;OE2), (dimer and i. 11)
# distance (dimer and (chain B) and i. 278 and n;OD2), (dimer and i. 11)

# Yb
# A 147 OE2 and 1
# B 278 OD2 and 1
# B 280 OD1
distance (dimer_yb and (chain A) and i. 147 and n;OE1), (dimer_yb and yb_280_B)
distance (dimer_yb and (chain A) and i. 147 and n;OE2), (dimer_yb and yb_280_B)
distance (dimer_yb and (chain B) and i. 278 and n;OD1), (dimer_yb and yb_280_B)
distance (dimer_yb and (chain B) and i. 278 and n;OD2), (dimer_yb and yb_280_B)
distance (dimer_yb and (chain B) and i. 280 and n;OD2), (dimer_yb and yb_280_B)

hide labels
show cartoon, dimer_yb_polymer
side_chain_helper("dimer_yb_residues")
show spheres, (yb_143_A or yb_280_B)

select view_center, (yb_143_A or yb_280_B)

zoom view_center, 6.5
# rotate x, 90
# rotate x, 35
turn x, -20
turn y, 10

save_image_dimer("dimer_interface_E143_closeup_yb")

hide dashes

isomesh yb_mesh, yb_map, 1.5, dimer_yb, carve=2.5
color blue, yb_mesh
show mesh, yb_mesh
save_image_closeup("dimer_interface_E143_closeup_yb_map")

hide everything, yb_mesh
isomesh yb_mesh_anom, yb_map_anom, 3, dimer_yb, carve=3
color red, yb_mesh_anom
show mesh, yb_mesh_anom
save_image_closeup("dimer_interface_E143_closeup_yb_map_anom")

hide everything 
isomesh native_mesh, native_map, 1.5, dimer_native_residues, carve=2
color blue, native_mesh
show mesh, native_mesh
show cartoon, dimer_native 
#show sticks, dimer_native_residues
side_chain_helper("dimer_native_residues")
save_image_closeup("dimer_interface_E143_closeup_native_map")

bg_color white
# label D136_E140_E143_E147_E275_S277_D278_D280_D309 and n. CA, " %s:%s" % (resi, resn)
# set label_size, -1


