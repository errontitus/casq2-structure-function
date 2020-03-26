@shared_make_figure_overview.pml

orient filament_short and polymer
zoom_complete("tetramer")

hide everything
show cartoon, filament_short and polymer and (tetramer)
save_image_tetramer("overview_tetramer")

# Because we orient the filament so that the central dimer is centered, the rotation to our preferred dimer view is easy. But for the tetramer it's more difficult. The axis of the filament goes into or out of the screen at an oblique angle, so returning the principal components of the tetramer to the plane of the screen/page is not a simple, intuitive transformation. This comes close:
# rotate x, 45
# rotate y, -22.5
# rotate z, 3
# So instead we just do this:
orient tetramer

hide everything
show cartoon, filament_short and polymer and (tetramer)
save_image_tetramer("overview_tetramer_oriented")

# cool tricks for labels in stereo: https://sourceforge.net/p/pymol/mailman/message/5223218/



