@shared_make_figure_overview.pml

orient filament_short and polymer
zoom_complete("filament_short")

hide everything

create_thioredoxin_domains("ABCDEFGHIJKLMN", "deo_native", "filament", 0)

hide everything
select outer_helix, filament_short and polymer and (A1 or B1 or C1 or D1 or E1 or F1 or G1 or H1 or I1 or J1 or K1 or L1 or M1 or N1)
select inner_helix, filament_short and polymer and not outer_helix 
