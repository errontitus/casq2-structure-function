# https://pymolwiki.org/index.php/PLoS
# For closeups of side chains, ligands, and non-bonded atoms at interfaces, active sites, etc.

set ray_trace_mode=0

set mesh_radius = 0.01 
set stick_radius = 0.22
set dash_radius, 0.1
set dash_color, black

# After this has been defined once, PyMOL seems to ignore new settings unless they are supplied with a selection. E.g. set sphere_Scale, 0.4, elem Yb
set sphere_scale, 0.4, hetatm

set ribbon_radius =0.1 

set gamma=1.5
util.ray_shadows('none')

# Change the lighting to ambient only.
set direct = 0.0

# Do not distort positions of atoms.
set cartoon_flat_sheets = 0

# Make cartoon features like helix ribbon length smaller to emphasize side chains.
set cartoon_oval_length, 0.8

# Again, do not distort positions of atoms. Turn off loop-smoothing. It's a pleasing cartoon effect for zoomed-out views.
set cartoon_smooth_loops = 0

# Turn off side chain helper because we want to manually control when to see backbone.
set cartoon_side_chain_helper, 0

# Not for closeups.
set cartoon_cylindrical_helices, 0

# I'm not a fan of fancy helices (the ridge on the edge of the rectangle/oval rendering). I like a slimmed-down oval. 
# cartoon oval
# set cartoon_oval_length, 0.8
# set cartoon_oval_width, 0.2

# Extremely simplified cartoon representation to keep the focus on atoms and avoid obscuring.

cmd.set("cartoon_transparency", 0.5)
