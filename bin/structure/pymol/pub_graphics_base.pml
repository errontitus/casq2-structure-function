# Sheets settings
#
# 0=off, 1=on
# Fancy sheets simply turns on arrows at the end of the sheet, which is helpful.
set cartoon_fancy_sheets, 1
# Slim down sheets a bit to avoid obscuring other features.
# These settings control the dimensions of the rectangle 
# cross-section of the sheet arrow.
# default is 1.4
set cartoon_rect_length, 1.25
# default is 0.4
set cartoon_rect_width, 0.25
# Make the strands flat=1 or pass through CA positions=0
# Set to 0 when showing side chains from a strand
set cartoon_flat_sheets = 1.0


# Helices settings
#
# See https://pymolwiki.org/index.php/Cartoon_Helix_Settings.
# Change length and width of alpha-helix ribbons. Default length is 1.20
set cartoon_oval_length , 1.4
#
# default width is 0.25
set cartoon_oval_width , 0.2
#
cartoon automatic
#
# Override the above and use a simple cylinder representation.
set cartoon_cylindrical_helices, 0
#
#
# Fancy mode makes helices with ridge on the edges like molscript does, i.e. give the ribbon thickness.
# 1 is on.  0 is off. I find this unnecessary and unappealing.
# set cartoon_fancy_helices=0
# Appearance of cross-section of the helix (e.g. thickness, length, etc.).
# In fancy mode, the cross-section is like a dumbbell, whence these names.
#
# Make helices really big.
# default setting is 0.15
# set cartoon_dumbbell_radius, 0.4
#
# default setting is 1.6
# set cartoon_dumbbell_length, 2.5
#
# default setting is 0.1
# set cartoon_dumbbell_width, 0.5
#


# Loops settings
#
# default setting is 0.2
# set cartoon_loop_radius, 0.15
# default setting is 1, Integer 0-2
set cartoon_loop_cap, 2
#   Draw the loops smooth=1 or pass through CA positions=0
#   Set to 0 when showing side chains from a loop
set cartoon_smooth_loops = 0


# Nucleic acid helices
#
# We typically use fancy helices (dumbbell) for helices, but 
# tube is the default representation for nucleic acid helices.
set cartoon_tube_radius, 0.2


# Other cartoon settings
#
#   If you dont have secondary structure assignments
#   in the PDB header then get secondary structure assignments 
#   from dssp  http://swift.cmbi.kun.nl/gv/dssp/
#   Then convert assignments into a PDB header
#   http://dssp2pdb.bravais.net/
#   If you want to define secondary structure manually, 
#   Use the following syntax 'S'=strand 'H'=helix
#   alter B/753:758/, ss='S'

# Ribbon settings
#
set ribbon_radius = 0.2

# 0=off, 1=on
# cartoon_side_chain_helper is an easy way, in cartoon mode, to only show the side chain of a residue.
# For residues represented in cartoon (but not ribbon) form, if you show the residue also in stick or wireframe cartoon_side_chain_helper hides backbone atoms. Showing the sidechain in this method also distorts the cartoon shape so it joins with the sidechain, effectively overriding any cartoon_flat_cycles setting for that residue.
set cartoon_side_chain_helper, 1

# change size/shape of hydrogen bonds for measurements
# sets the dash color to red
# I don't like this at all, given that the oxygens are already red.
set dash_color, black
# sets dash_gap to 0.20
set dash_gap, 0.20

# make longer dashes
set dash_length, 0.3500
# sets dash_width to 4, range is 1 to 9, default=2.5
set dash_width, 4
# fat dashes
set dash_radius, 0.500
# square ends
set dash_round_ends, 0

set sphere_scale, 0.5

# stick_radius -adjust thickness of atomic bonds
set stick_radius = 0.2

# mesh_radius -to adjust thickness of electron density contours
set mesh_radius = 0.02

# Hide the default line representation of atomic bonds
hide lines



python

def side_chain_helper(sele):
    cmd.show("sticks", sele + " and not (name c,n)")
    return

python end


# Goals
# -----
#
#   1. Eliminate most shadows and boost brightness. 
#   2. Preserve shadows on interior surfaces of helices for contrast, but mostly eliminate them elsewhere (including eliminating them on buried surfaces).
#   3. Get rid of most art effects - shininess, specular reflection, etc. Just use matte surfaces. The art effects are great, just not for a figure.
#

# All Lighting Options
# --------------------
#
# ambient (float 0.0-1.0, default: 0.14) controls the ambient lighting level.
# ambient_occlusion_mode (integer, default: 0) Controls which method is used to draw ambient occlusion. 0=disabled, 1=atom-based occlusion, 2=triangle-based occlusion
# ambient_occlusion_scale (float, default: 25.0) The scale by which ambient occlusion values are modified. The larger this value the more hinting is applied.
# ambient_occlusion_smooth (int, default: 10) Controls whether or not ambient occlusion uses smoothing of nearby values.
# cgo_lighting (boolean, default: 1) controls whether or not PyMOL lights CGOs.
# direct (float 0.0-1.0, default: 0.45) is the amount of light being emitted from the camera.
# edit_light (integer 1-8, default: 1) This setting controls which light may be moved by the mouse.
# light (vector, default: [ -0.4, -0.4, -1.0]) is the direction of movable light source 1.
# light2 (vector, default: [ -0.55, -0.7, 0.15]) is the direction of movable light source 2.
# light3 (vector, default: [ 0.3, -0.6, -0.2]) is the direction of movable light source 3.
# light4 (vector, default: [ -1.2, 0.3, -0.2]) is the direction of movable light source 4.
# light5 (vector, default: [ 0.3, 0.6, -0.75]) is the direction of movable light source 5.
# light6 (vector, default: [ -0.3, 0.5, 0.0]) is the direction of movable light source 6.
# light7 (vector, default: [ 0.9, -0.1, -0.15]) is the direction of movable light source 7.
# light8 (vector, default: [ 1.3, 2.0, 0.8]) is the direction of movable light source 8.
# light9 (vector, default: [ -1.7, -0.5, 1.2]) is the direction of movable light source 9.
# light_count (integer 1-10, default: 2) is the number of light sources including the camera source.
# power (float, default: 1.0) is the reflect exponent for light emitted by the camera.
# shininess (float, default: 55.0) is the specular exponent for the movable light sources.
# reflect (float 0-1.0, default: 0.45) controls the aggregate intensity of the movable light sources.
# reflect_power (float, default: 1.0) controls the reflective exponent for the movable light sources.
# spec_count (integer, default: -1) controls how many movable light sources are used when drawing specular reflections.
# spec_direct (float, default: 0.0) controls the specular intensity for the camera light source.
# spec_direct_power (float, default: 55.0) controls the specular exponent for camera light source.
# specular (float, default: 1.0) controls the specular intensity for movable light sources.
# specular_intensity (float, default: 0.5) controls the specular intensity for movable light sources, if specular is set to 1.0.
# two_sided_lighting (boolean, default: on) controls whether both faces of a triangle are lit or just the front face (as defined by convention).
#
# We can increase ambient light to compensate for loss of contrast with a 
# white background. On the other hand, choosing a more intense/higher saturation
# is usually the better choice.
# set ambient = 0.3
#
# Direct is the camera spotlight level (ambient light + camera light + other light sources if you increase light count). 
# Larger values of direct eliminate shadows. Ranges from 0.1-1.0.
# On the other hand, shadows help provide contrast and depth.
# set direct = 1.0
#
# Make everything almost as matte as possible.
# On the other hand, shinier objects are better for contrast with transparent objects
# and show better when viewed through transparent surfaces.
# set shininess, 10
# set specular_intensity, 0.2
#
# Shadows are attractive and help with perception of depth.
set ray_shadows, 1
set ambient_occlusion_mode, 1
set ambient_occlusion_scale, 10

# Simplified Color Settings
# -------------------------
#
# Here we turn off most of the settings that make molecule art beautiful.
# The problem is that these settings add extraneous information (e.g. extra color gradients)
# They are more appropriate as art and less appropriate for scientific figures, which 
# should be as simple as possible.
#
# Normal color
set ray_trace_mode, 0
#
# normal color + black outline: set ray_trace_mode,  1
# black outline only: #set ray_trace_mode,  2
# black outline with quantized color (comic book-like effect): set ray_trace_mode = 3
#
# cartoon_highlight_color will give a separate color to interior face of helices 
# and edges of strands, providing additional contrast.
# This is nice, but it becomes a problem when you also use multiple colors to communicate. 
# The extra gray looks confusing and muddy.
# set cartoon_highlight_color = grey50
#
# background alpha channel rather than white. 
set ray_opaque_background, off
# bg_color --set the background color
bg_color white
# Bring back fog if you want attention to foregrounded objects. We prefer just to make all distant objects transparent.
set ray_trace_fog, 0


# Rendering quality.
set antialias = 2
# Turn perspective off. This makes images less "realistic", which is actually what we want. Perspective causes chains that are identical by crystallographic symmetry to appear subtly different depending on your vantage point, which is confusing if you are trying to pay close attention to symmetry in a structure. For example, if you are paying close attention to a symmetry relationship along a screw axis.
# Note: turning off perspective (orthoscopic on) also improves rendering time.
set orthoscopic = on

set sphere_quality, 2

# Surfaces
python

cmd.set("surface_quality", quality_level - 1)

python end

set surface_proximity, off
