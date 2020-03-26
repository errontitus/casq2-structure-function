load ../filament/output/filament_deo_yb.pdb, "filament"
remove hetatm
@shared_make_filament_for_hollow.pml
save ./output/filament_deo_yb_pseudo_no_het.pdb, filament_plus_pseudo_no_het