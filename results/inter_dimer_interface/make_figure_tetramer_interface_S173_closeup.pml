@shared_make_figure_tetramer_interface_non_liganded_closeup.pml

# You clicked /tetramer_native_deo_yb//A/LYS`320/NZ
# You clicked /tetramer_native_deo_yb//B/GLN`82/O
# You clicked /tetramer_native_deo_yb//B/VAL`83/O
# You clicked /tetramer_native_deo_yb//B/GLU`85/OE1
distance (tetramer_native and (chain A) and i. 320 and n;NZ), (tetramer_native and (chain B) and i. 82 and n;O)
distance (tetramer_native and (chain A) and i. 320 and n;NZ), (tetramer_native and (chain B) and i. 83 and n;O)
distance (tetramer_native and (chain A) and i. 320 and n;NZ), (tetramer_native and (chain B) and i. 85 and n;OE1)
# Other direction
distance (tetramer_native and (chain D) and i. 320 and n;NZ), (tetramer_native and (chain C) and i. 82 and n;O)
distance (tetramer_native and (chain D) and i. 320 and n;NZ), (tetramer_native and (chain C) and i. 83 and n;O)
distance (tetramer_native and (chain D) and i. 320 and n;NZ), (tetramer_native and (chain C) and i. 85 and n;OE1)

# This provides the third protomer in the mix.
# You clicked /tetramer_native_deo_yb//A/GLU`319/OE1
# You clicked /tetramer_native_deo_yb//B/LYS`87/NZ 
distance (tetramer_native and (chain A) and i. 319 and n;OE1), (tetramer_native and (chain B) and i. 87 and n;NZ)
distance (tetramer_native and (chain D) and i. 319 and n;OE1), (tetramer_native and (chain C) and i. 87 and n;NZ)

# sele side_chains_only, (resi 87 or resi 172-173 or resi 175 or resi 325 or resi 319) and tetramer_native
sele side_chains_only, (resi 87 or resi 173 or resi 325 or resi 319 or resi 172) and tetramer_native
# sele main_chains_only, (resi 82-83) and tetramer_native
# sele side_chains_and_main_chains, (resi 319)

# Chain B to Chain D
# You clicked /tetramer_native//B/SER`173/OG
# You clicked /tetramer_native//D/ASP`325/OD2
#
# You clicked /tetramer_native//D/GLU`319/OE1
# You clicked /tetramer_native//B/LYS`172/NZ
distance (tetramer_native and (chain B) and i. 173 and n;OG), (tetramer_native and (chain D) and i. 325 and n;OD2)
distance (tetramer_native and (chain C) and i. 173 and n;OG), (tetramer_native and (chain A) and i. 325 and n;OD2)

distance (tetramer_native and (chain B) and i. 172 and n;NZ), (tetramer_native and (chain D) and i. 319 and n;OE1)
distance (tetramer_native and (chain B) and i. 172 and n;NZ), (tetramer_native and (chain D) and i. 319 and n;O)
distance (tetramer_native and (chain C) and i. 172 and n;NZ), (tetramer_native and (chain A) and i. 319 and n;OE1)

# Chain C to Chain D
# You clicked /tetramer_native//C/LYS`87/NZ
# You clicked /tetramer_native//D/ASP`325/OD2
#
# You clicked /tetramer_native//C/LYS`87/NZ
# You clicked /tetramer_native//D/GLU`319/OE1
distance (tetramer_native and (chain C) and i. 87 and n;NZ), (tetramer_native and (chain D) and i. 325 and n;OD2)
distance (tetramer_native and (chain B) and i. 87 and n;NZ), (tetramer_native and (chain A) and i. 325 and n;OD2)

distance (tetramer_native and (chain C) and i. 87 and n;NZ), (tetramer_native and (chain D) and i. 319 and n;OE1)
distance (tetramer_native and (chain B) and i. 87 and n;NZ), (tetramer_native and (chain A) and i. 319 and n;OE1)

# Chain B to Chain C
# You clicked /tetramer_native//B/ASP`175/CA
distance (tetramer_native and (chain B) and i. 175 and n;OD2), (tetramer_native and (chain C) and i. 87 and n;NZ)
distance (tetramer_native and (chain C) and i. 175 and n;OD2), (tetramer_native and (chain B) and i. 87 and n;NZ)

distance (tetramer_native and (chain B) and i. 175 and n;OD2), (tetramer_native and (chain B) and i. 173 and n;OG)
distance (tetramer_native and (chain C) and i. 175 and n;OD2), (tetramer_native and (chain C) and i. 173 and n;OG)

# Other B-C H bonds a bit further away from the 3-protomer interface
# You clicked /tetramer_native//B/SER`176/N
# You clicked /tetramer_native//C/HIS`86/O
#
# You clicked /tetramer_native//B/LYS`172/NZ
# You clicked /tetramer_native//C/HIS`86/O
#
# You clicked /tetramer_native//B/ASP`175/O
# You clicked /tetramer_native//C/ALA`88/N
#
# You clicked /tetramer_native//C/HIS`86/O
# You clicked /tetramer_native//B/GLU`177/N

# Chain B and Chain C to chloride
# You clicked /tetramer_native_deo_native//B/SER`176/CA
# You clicked /tetramer_native_deo_native//B/SER`173/OG
# You clicked /tetramer_native_deo_native//C/LYS`87/NZ
# You clicked /tetramer_native_deo_native/ION/C/CL`1/CL

# distance (tetramer_native and (chain B) and i. 176 and n;N), (tetramer_native and i. 1 and n;CL)
# distance (tetramer_native and (chain B) and i. 173 and n;OG), (tetramer_native and i. 1 and n;CL)
# distance (tetramer_native and (chain C) and i. 87 and n;NZ), (tetramer_native and i. 1 and n;CL)

hide labels
hide dashes

hide everything
remove hetatm and (resn HOH or resn SO4)
# keep water
# remove hetatm and (resn SO4)
show cartoon, tetramer_native
# show spheres, resn HOH
cmd.set("stick_transparency", default_stick_transparency(), "resi 172")
side_chain_helper("side_chains_only")

select view_center, (chain D and resi 325) or (chain C and resi 87)

zoom view_center, -1
#rotate x, 10
save_image_closeup("tetramer_interface_S173_closeup")

isomesh native_mesh, native_map, 1.5, side_chains_only, carve=2
color blue, native_mesh
show mesh, native_mesh
show cartoon, tetramer_native
side_chain_helper("side_chains_only")
save_image_closeup("tetramer_interface_S173_closeup_native_map")

bg_color white





