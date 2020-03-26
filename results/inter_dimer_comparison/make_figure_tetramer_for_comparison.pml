run ../../bin/structure/pymol/color_blind_friendly.py
run ../../bin/structure/pymol/casq2_base.py
run ../../bin/structure/pymol/interface_residues.py
@../../bin/structure/pymol/pub_graphics_base.pml

cmd.load("../shared_pdb/dimer_and_tetramer/output/tetramer_1a8y.pdb", "tetramer_1a8y") 
# "

# Get the other pdb.
pdb = get_arg1()
path = "../shared_pdb/dimer_and_tetramer/output/tetramer_" + pdb + "." + "pdb"
print path
cmd.load(path, "tetramer")

remove hetatm

apply_standard_colors_tetramer_spheres("tetramer", 1)

myInterfaceResiduesBC = interfaceResidues("tetramer", "(chain B)", "(chain C)", 0.75, "interface_tetramer_BC")
myInterfaceResiduesAD = interfaceResidues("tetramer", "(chain A)", "(chain D)", 0.75, "interface_tetramer_AD")
myInterfaceResiduesAC = interfaceResidues("tetramer", "(chain A)", "(chain C)", 0.75, "interface_tetramer_AC")
myInterfaceResiduesBD = interfaceResidues("tetramer", "(chain B)", "(chain D)", 0.75, "interface_tetramer_BD")

select all_interface_residues, interface_tetramer_BC or interface_tetramer_AD \
      or interface_tetramer_AC or interface_tetramer_BD

# Get an oriented view, and the oriented view should be the same as the 1a8y oriented view for tetramers that are the same as 1a8y.
orient tetramer 

python

zoom_tetramer_any("tetramer")

if pdb == "deo_native":
  cmd.rotate("y", 180)
if pdb == "2vaf":
  cmd.rotate("y", 180)
if pdb == "1a8y":
  cmd.rotate("y", 180)
if pdb == "5cre":
  cmd.rotate("y", 180)

python end

hide everything
show cartoon, tetramer
set sphere_scale, 1.0
cmd.set("cartoon_transparency", default_cartoon_transparency(), "tetramer")
show spheres, all_interface_residues
save_image_tetramer("tetramer_" + pdb + "_oriented")

