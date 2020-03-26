# https://pymolwiki.org/index.php/PLoS
# Use ribbon for overall structure overlays

# Ribbon vs cartoon. Ribbon is nice for showing backbone displacement in an overlay, 
# but only works if the structure is small/simple/not busy.
# Otherwise use the overall fold graphics, optionally with cylinders 
# for helices, and color by displacement.
show ribbon
set ray_trace_mode = 0
set ribbon_radius = 0.3
set sphere_transparency = 0.5
set ray_shadow = off
