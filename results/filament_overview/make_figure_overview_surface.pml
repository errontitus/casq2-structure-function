@shared_make_figure_overview.pml

# This rotation allows ABCD to adopt the familiar appearance of the tetramer that we use everywhere else:
# rotate x, -45
# But it also makes the symmetry of the filament harder to see. Better to leave as is and introduce the rotation later.
hide everything
show surface, filament_short and polymer
save_image_filament("overview_surface")

