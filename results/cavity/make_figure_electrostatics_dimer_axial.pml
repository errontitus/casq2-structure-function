@shared_make_figure_electrostatics.pml

orient dimer_native
zoom dimer_native, 9

hide everything

# Have to be careful here deciding how to show the entrance to the channel in the dimer.
# If we show the side that is open to solvent (i.e. end of filament), it is electronegative but not profoundly so. The side buried within the filament (i.e. contacting the next dimer) is much more electronegative, as would be expected, since there are two electronegative surfaces in contact instead of one. I think the reader would be implicitly expecting to view the side that is open to solvent. 
remove chain E and chain F
turn y, 127
set surface_color, elvl, dimer_native
show surface, dimer_native

save_image_dimer("dimer_cavity_apbs_axial")
