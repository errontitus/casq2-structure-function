run ../../bin/structure/pymol/casq2_base.py
run ../../bin/structure/pymol/interface_residues.py

pdb = get_arg1()
path = "../shared_pdb/dimer_and_tetramer/output/tetramer_" + pdb + "." + "pdb"
print path
cmd.load(path, pdb)

# This naming convention is dictated by the limitations of texshade.
new_name = get_arg2() + "." + pdb.replace("_",".")
cmd.set_name(pdb, new_name)

remove hetatm

myInterfaceResiduesBC = interfaceResidues(new_name, "(chain B)", "(chain C)", 1.0, "interface_tetramer_BC")
myInterfaceResiduesAD = interfaceResidues(new_name, "(chain A)", "(chain D)", 1.0, "interface_tetramer_AD")
myInterfaceResiduesAC = interfaceResidues(new_name, "(chain A)", "(chain C)", 1.0, "interface_tetramer_AC")
myInterfaceResiduesBD = interfaceResidues(new_name, "(chain B)", "(chain D)", 1.0, "interface_tetramer_BD")

write_interface_residue_list_to_file(myInterfaceResiduesBC, "./output/tetramer_interface_residues_" + new_name + "_BC.p")
write_interface_residue_list_to_file(myInterfaceResiduesAD, "./output/tetramer_interface_residues_" + new_name + "_AD.p")
write_interface_residue_list_to_file(myInterfaceResiduesAC, "./output/tetramer_interface_residues_" + new_name + "_AC.p")
write_interface_residue_list_to_file(myInterfaceResiduesBD, "./output/tetramer_interface_residues_" + new_name + "_BD.p")

myInterfaceResiduesAB = interfaceResidues(new_name, "(chain A)", "(chain B)", 1.0, "interface_dimer_AB")

write_interface_residue_list_to_file(myInterfaceResiduesAB, "./output/dimer_interface_residues_" + new_name + "_AB.p")

fasta = cmd.get_fastastr(selection="chain A", state=-1, quiet=1)
write_fasta_file(fasta, "./output/" + new_name + ".fasta")