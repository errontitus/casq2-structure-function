run ../../bin/structure/pymol/color_blind_friendly.py
run ../../bin/structure/pymol/casq2_base.py
@../../bin/structure/pymol/pub_graphics_base.pml

filament = get_arg1()
pdb_code = get_arg2()
cmd.load("../shared_pdb/filament/output/" + filament + ".pdb", "filament") 
# "

python

if pdb_code == "deo_native":
    cmd.rotate("y", 90)
    
python end

sele filament_short, (chain A or chain B or chain C or chain D or chain E or chain F or chain G or chain H or chain I or chain J)

hide everything
orient filament_short and polymer
zoom_complete("filament_short")
