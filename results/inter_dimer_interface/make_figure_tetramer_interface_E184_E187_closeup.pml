@shared_make_figure_tetramer_interface_yb_closeup.pml

# or resi 183, or resi 188
sele side_chains_only, (resi 50 or resi 180 or resi 184 or resi 187) and tetramer_yb
sele main_chains_only, (resi 47 or resi 49) and tetramer_yb

sele side_chains_only_native, (resi 50 or resi 180 or resi 184 or resi 187) and tetramer_native
sele main_chains_only_native, (resi 47 or resi 49) and tetramer_native

sele 184_yb, elem Yb within 3 of ((chain B and resi 184) or (chain C and resi 184))
sele 184_yb_B, 184_yb within 3 of (chain B and resi 184) 
sele 184_yb_C, 184_yb within 3 of (chain C and resi 184)

# sele side_chains_and_main_chains, resi 184 and tetramer

# sele K47_Y49_D50_K180_E183_E184_E187_native, (resi 47 or resi 49 or resi 50 or resi 180 or resi 183 resi 184 or resi 187) and tetramer_deo_native
# sele K47_Y49_D50_K180_E183_E184_E187_yb, (resi 47 or resi 49 or resi 50 or resi 180 or resi 183 resi 184 or resi 187) and tetramer_deo_yb

hide everything
show cartoon, tetramer_yb
side_chain_helper("side_chains_only")
# show sticks, side_chains_only and not (name c,n)
# show sticks, main_chains_only and (name c,n,o)
# show sticks, side_chains_and_main_chains

# other aspects of stapled helix: H188, K47 (but side chain not currently resolved, so not sure), P145, R121 (H bond or anion-quadrupole with H188)
# K47 could salt bridge with D120, but rotamer would have to move.
# E183 connects to D144 (need to change rotamers so that it's not apposining carbonyls) Bridges stapled helix to the 144/174 system.
# And Y179 to E183

# Intra-chain hydrogen bonds based on protonation of E183
# This is plausible based on Glu side chain pKa of 4.25. 187 OE2 would be protonated and H-bond with E183 OE1.
# 187 OE2 would bond with Yb/Ca on its other side.
# distance (tetramer_yb and (chain B) and i. 183 and n;OE1), (tetramer_yb and (chain B) and i. 187 and n;OE2)
# distance (tetramer_yb and (chain C) and i. 183 and n;OE1), (tetramer_yb and (chain C) and i. 187 and n;OE2)
# # This one on chain C only. Requires protonation of E183.
# distance (tetramer_yb and (chain C) and i. 183 and n;OE2), (tetramer_yb and (chain C) and i. 184 and n;OE2)

# On both sides, E184 is close to K180, but the lengths of the C-H-O bond vs the N-HO bonds are flipped. 
distance (tetramer_yb and (chain B) and i. 184 and n;OE2), (tetramer_yb and (chain B) and i. 180 and n;NZ)
# distance (tetramer_yb and (chain B) and i. 184 and n;OE2), (tetramer_yb and (chain B) and i. 180 and n;CE)
# On the other side, it's an intra-chain C-H-O bond. Distance very favorable.
# http://www.jbc.org/content/early/2012/10/09/jbc.R112.418574.full.pdf
distance (tetramer_yb and (chain C) and i. 184 and n;OE2), (tetramer_yb and (chain C) and i. 180 and n;NZ)
# distance (tetramer_yb and (chain C) and i. 184 and n;OE2), (tetramer_yb and (chain C) and i. 180 and n;CE)

# Inter-chain H bond: E184 to peptide O of K47
# distance (tetramer_yb and (chain C) and i. 184 and n;OE1), (tetramer_yb and (chain B) and i. 47 and n;O)
# distance (tetramer_yb and (chain B) and i. 184 and n;OE1), (tetramer_yb and (chain C) and i. 47 and n;O)

# Inter-chain H bond: K180 to peptide O of K47 and/or Y49. 
# Distances are good in high res native structure. 
# First, chain B 
# distance (tetramer_yb and (chain B) and i. 180 and n;NZ), (tetramer_yb and (chain C) and i. 47 and n;O)
distance (tetramer_yb and (chain B) and i. 180 and n;NZ), (tetramer_yb and (chain C) and i. 49 and n;O)
# Chain C is different
distance (tetramer_yb and (chain C) and i. 180 and n;NZ), (tetramer_yb and (chain B) and i. 47 and n;O)
distance (tetramer_yb and (chain C) and i. 180 and n;NZ), (tetramer_yb and (chain B) and i. 49 and n;O)

# Inter-chain C-H-O bond?
# http://www.jbc.org/content/early/2012/10/09/jbc.R112.418574.full.pdf
# distance (tetramer_yb and (chain B) and i. 180 and n;CG), (tetramer_yb and (chain C) and i. 50 and n;OD1)
# distance (tetramer_yb and (chain C) and i. 180 and n;CG), (tetramer_yb and (chain B) and i. 50 and n;OD1)

distance (tetramer_yb and (chain C) and i. 180 and n;NZ), (tetramer_yb and (chain B) and i. 50 and n;OD1)

# distance (tetramer_yb and (chain C) and i. 121 and n;NH1), (tetramer_yb and (chain C) and i. 184 and n;O)
# distance (tetramer_yb and (chain C) and i. 121 and n;NH2), (tetramer_yb and (chain C) and i. 188 and n;ND1)

# It's hard to make claims about which interactions are most important. 
hide dashes

# E184 and E187 to Yb 
distance (tetramer_yb and (chain B) and i. 184 and n;OE1), (tetramer_yb and 184_yb_B)
distance (tetramer_yb and (chain B) and i. 184 and n;OE2), (tetramer_yb and 184_yb_B)
distance (tetramer_yb and (chain B) and i. 187 and n;OE1), (tetramer_yb and 184_yb_B)
distance (tetramer_yb and (chain B) and i. 187 and n;OE2), (tetramer_yb and 184_yb_B)
# Other side.
distance (tetramer_yb and (chain C) and i. 184 and n;OE1), (tetramer_yb and 184_yb_C)
distance (tetramer_yb and (chain C) and i. 184 and n;OE2), (tetramer_yb and 184_yb_C)
distance (tetramer_yb and (chain C) and i. 187 and n;OE1), (tetramer_yb and 184_yb_C)
distance (tetramer_yb and (chain C) and i. 187 and n;OE2), (tetramer_yb and 184_yb_C)

hide labels

show cartoon, tetramer_yb
show spheres, 184_yb

sele view_center, 184_yb
# Unusual situation where we want to override the usual square viewport.
x = 800
y = 1200
cmd.viewport(x, y)
zoom view_center, 8
hide cartoon, resi 42-48 and tetramer_yb
turn x, 80
hide labels 

save_image_closeup("tetramer_interface_E184_E187_closeup_yb", x, y)

hide dashes

isomesh yb_mesh, yb_map, 1.5, tetramer_yb, carve=2.5
color blue, yb_mesh
show mesh, yb_mesh
save_image_closeup("tetramer_interface_E184_E187_closeup_yb_map", x, y)

hide everything, yb_mesh
isomesh yb_mesh_anom, yb_map_anom, 5, tetramer_yb, carve=3
color red, yb_mesh_anom
show mesh, yb_mesh_anom
save_image_closeup("tetramer_interface_E184_E187_closeup_yb_map_anom", x, y)

hide everything 
isomesh native_mesh, native_map, 1.5, side_chains_only_native, carve=2
color blue, native_mesh
show mesh, native_mesh
show cartoon, tetramer_native
hide cartoon, resi 42-48 and tetramer_native
side_chain_helper("side_chains_only_native")
save_image_closeup("tetramer_interface_E184_E187_closeup_native_map", x, y)

bg_color white

# label (side_chains_only or main_chains_only) and n. CA, " %s:%s" % (resi, resn)
# set label_size, -1
# set dash_radius, 0.05