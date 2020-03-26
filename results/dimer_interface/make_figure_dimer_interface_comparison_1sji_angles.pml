@shared_make_figure_dimer_interface_comparison_1sji.pml

# # align on chain A
# align dimer_deo_native & chain A, dimer_1sji & chain A

# # measure rotation and displacement of chain B
# angle_between_domains dimer_deo_native & chain B, dimer_1sji & chain B

# align on chain B, mobile to target
align dimer_1sji & chain B, dimer_deo_native & chain B

# measure rotation and displacement of chain A
angle_between_domains dimer_deo_native & chain A, dimer_1sji & chain A

# align on chains A and B
#align dimer_deo_native & (chain A or chain B), dimer_1sji & (chain A or chain B)

# measure rotation and displacement of chain A
#angle_between_domains dimer_deo_native & chain A, dimer_1sji & chain A
