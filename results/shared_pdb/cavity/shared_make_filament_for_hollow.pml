# Now we place a bunch of markers that can be used to lay out grids in hollow, using cylinders.
#
# We use axis offset in hollow so that the probed region ends before the marker atom on the open side, thus avoiding an "indentation" in the probe region caused by the marker. See hollow constraint files.
pseudoatom tetramer_cavity_open_BC, selection=(polymer and ((resi 120 and chain B) or (resi 120 and chain C))), chain=B, hetatm=0, resi=371 
pseudoatom tetramer_cavity_close_BC, selection=(polymer and ((resi 348 and chain A) or (resi 348 and chain D))), chain=B, hetatm=0, resi=372 
pseudoatom tetramer_cavity_open_DE, selection=(polymer and ((resi 120 and chain D) or (resi 120 and chain E))), chain=D, hetatm=0, resi=371 
pseudoatom tetramer_cavity_close_DE, selection=(polymer and ((resi 348 and chain C) or (resi 348 and chain F))), chain=D, hetatm=0, resi=372 
pseudoatom tetramer_cavity_open_FG, selection=(polymer and ((resi 120 and chain F) or (resi 120 and chain G))), chain=F, hetatm=0, resi=371 
pseudoatom tetramer_cavity_close_FG, selection=(polymer and ((resi 348 and chain E) or (resi 348 and chain H))), chain=F, hetatm=0, resi=372 
pseudoatom tetramer_cavity_open_HI, selection=(polymer and ((resi 120 and chain H) or (resi 120 and chain I))), chain=H, hetatm=0, resi=371 
pseudoatom tetramer_cavity_close_HI, selection=(polymer and ((resi 348 and chain G) or (resi 348 and chain J))), chain=H, hetatm=0, resi=372 
pseudoatom tetramer_cavity_open_JK, selection=(polymer and ((resi 120 and chain J) or (resi 120 and chain K))), chain=J, hetatm=0, resi=371 
pseudoatom tetramer_cavity_close_JK, selection=(polymer and ((resi 348 and chain I) or (resi 348 and chain L))), chain=J, hetatm=0, resi=372 
pseudoatom tetramer_cavity_open_LM, selection=(polymer and ((resi 120 and chain L) or (resi 120 and chain M))), chain=L, hetatm=0, resi=371 
pseudoatom tetramer_cavity_close_LM, selection=(polymer and ((resi 348 and chain K) or (resi 348 and chain N))), chain=L, hetatm=0, resi=372 

# As with the inter-dimer cavity, the dimer cavity has an open end and a (more or less) closed end (not quite closed).
pseudoatom dimer_cavity_open_AB, selection=(polymer and ((resi 131 and chain A) or (resi 131 and chain B))), chain=A, hetatm=0, resi=371 
pseudoatom dimer_cavity_close_AB, selection=(polymer and ((resi 160 and chain A) or (resi 160 and chain B))), chain=A, hetatm=0, resi=372 
pseudoatom dimer_cavity_open_CD, selection=(polymer and ((resi 131 and chain C) or (resi 131 and chain D))), chain=C, hetatm=0, resi=371 
pseudoatom dimer_cavity_close_CD, selection=(polymer and ((resi 160 and chain C) or (resi 160 and chain D))), chain=C, hetatm=0, resi=372 
pseudoatom dimer_cavity_open_EF, selection=(polymer and ((resi 131 and chain E) or (resi 131 and chain F))), chain=E, hetatm=0, resi=371 
pseudoatom dimer_cavity_close_EF, selection=(polymer and ((resi 160 and chain E) or (resi 160 and chain F))), chain=E, hetatm=0, resi=372 
pseudoatom dimer_cavity_open_GH, selection=(polymer and ((resi 131 and chain G) or (resi 131 and chain H))), chain=G, hetatm=0, resi=371 
pseudoatom dimer_cavity_close_GH, selection=(polymer and ((resi 160 and chain G) or (resi 160 and chain H))), chain=G, hetatm=0, resi=372 
pseudoatom dimer_cavity_open_IJ, selection=(polymer and ((resi 131 and chain I) or (resi 131 and chain J))), chain=I, hetatm=0, resi=371 
pseudoatom dimer_cavity_close_IJ, selection=(polymer and ((resi 160 and chain I) or (resi 160 and chain J))), chain=I, hetatm=0, resi=372 
pseudoatom dimer_cavity_open_KL, selection=(polymer and ((resi 131 and chain K) or (resi 131 and chain L))), chain=K, hetatm=0, resi=371 
pseudoatom dimer_cavity_close_KL, selection=(polymer and ((resi 160 and chain K) or (resi 160 and chain L))), chain=K, hetatm=0, resi=372 
pseudoatom dimer_cavity_open_MN, selection=(polymer and ((resi 131 and chain M) or (resi 131 and chain N))), chain=M, hetatm=0, resi=371 
pseudoatom dimer_cavity_close_MN, selection=(polymer and ((resi 160 and chain M) or (resi 160 and chain N))), chain=M, hetatm=0, resi=372 

sele tetramer_cavity_markers, tetramer_cavity_open_BC or tetramer_cavity_close_BC or tetramer_cavity_open_DE or tetramer_cavity_close_DE or tetramer_cavity_open_FG or tetramer_cavity_close_FG or tetramer_cavity_open_HI or tetramer_cavity_close_HI or tetramer_cavity_open_JK or tetramer_cavity_close_JK or tetramer_cavity_open_LM or tetramer_cavity_close_LM

sele dimer_cavity_markers, dimer_cavity_open_AB or dimer_cavity_close_AB or dimer_cavity_open_CD or dimer_cavity_close_CD or dimer_cavity_open_EF or dimer_cavity_close_EF or dimer_cavity_open_GH or dimer_cavity_close_GH or dimer_cavity_open_IJ or dimer_cavity_close_IJ or dimer_cavity_open_KL or dimer_cavity_close_KL or dimer_cavity_open_MN or dimer_cavity_close_MN

# HETATM have already been removed, and pseudoatoms are stored as ATOM to make hollow happy.
sele filament_plus_pseudo_no_het, polymer or tetramer_cavity_markers or dimer_cavity_markers
