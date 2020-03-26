@shared_make_figure_electrostatics.pml

orient dimer_native
zoom dimer_native

hide everything
show cartoon, dimer_native
show surface, dimer_cavity

# Weird that there is no way (that I know of) to hide the color bar.
# cmd.delete("elvl")

save_image_dimer("dimer_cavity_apbs_side")

# cmd.set("cartoon_transparency", 0.7)
# # hide cartoon, dimer_native

# sele cavity_contacts, (resn GLU within 5 of dimer_cavity) or (resn ASP within 5 of dimer_cavity)

# set_bond stick_radius, 0.3, cavity_contacts 
# # set dot_radius, 0.5 
# # show dots, dimer_yb_contacts

# show sticks, cavity_contacts

# save_image_dimer("dimer_cavity_apbs_sticks")
