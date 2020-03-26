@shared_make_figure_cavity.pml

extract obj_dimer_yb_contacts, dimer_yb_contacts

orient dimer_cavity
zoom dimer_chains, 4
rotate y, -70

# Structures that do not have a pore in surface view (note: largely meaningless way of measuring whether a pore is there or not):
# 1sji (but a residue is incorrectly assigned, Q164 should be Y164)
# 5crd (but there is a tiny pore)
# 5kn0 (bovine, K253 substitution in skeletal calsequestrin blocks pore)
# 5kn1 (bovine, K253 substitution in skeletal calsequestrin blocks pore)
# 5kn3 (bovine, K253 substitution in skeletal calsequestrin blocks pore)

cmd.set("transparency", default_surface_transparency())

hide everything
remove filament_short and not dimer_chains
# show cartoon, monomer 
set_bond stick_radius, 0.3, obj_dimer_yb_contacts 
side_chain_helper("obj_dimer_yb_contacts")
show surface, dimer_chains 
# and not resi 143-144
save_image_default("dimer_cavity_axial")
