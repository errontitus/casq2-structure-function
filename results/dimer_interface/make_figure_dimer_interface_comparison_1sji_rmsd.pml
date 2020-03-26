@shared_make_figure_dimer_interface_comparison_1sji.pml

# Align on chain B and see how much rotation is applied to chain A.
align dimer_1sji & (chain A), dimer_deo_native & (chain A)
colorbyrmsd dimer_deo_native and chain B, dimer_1sji and chain B, doAlign=0

orient dimer_deo_native
zoom dimer_deo_native
# rotate y, 45

hide everything

color gray90, dimer_1sji

# This gray is a bit hard to see, so we will use less transparency than usual.
set cartoon_transparency, 0.4, dimer_1sji

show cartoon, (dimer_1sji and chain B) or (dimer_deo_native and chain B)

save_image_dimer("dimer_interface_overlay_1sji_rmsd")
