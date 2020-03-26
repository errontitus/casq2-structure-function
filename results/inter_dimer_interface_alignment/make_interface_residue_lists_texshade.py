import pickle
import itertools
import sys

def ranges(i):
    for a, b in itertools.groupby(enumerate(i), lambda (x, y): y - x):
        b = list(b)
        yield b[0][1], b[-1][1]

def get_sequence_label(pdb):
    if pdb == "casq2.deo.native": return "PDB.6OWV.Homo.CASQ2"
    if pdb == "casq1.1a8y": return "PDB.1A8Y.Oryct.CASQ1"
    if pdb == "casq2.1sji": return "PDB.1SJI.Canis.CASQ2"
    if pdb == "casq2.2vaf": return "PDB.2VAF.Homo.CASQ2"
    if pdb == "casq1.3trp": return "PDB.3TRP.Oryct.CASQ1"
    if pdb == "casq1.3trq": return "PDB.3TRQ.Oryct.CASQ1"
    if pdb == "casq1.3uom": return "PDB.3UOM.Homo.CASQ1"
    if pdb == "casq1.3us3": return "PDB.3US3.Oryct.CASQ1"
    if pdb == "casq1.3v1w": return "PDB.3V1W.Oryct.CASQ1"
    if pdb == "casq1.5crd": return "PDB.5CRD.Homo.CASQ1"
    if pdb == "casq1.5cre": return "PDB.5CRE.Homo.CASQ1.D210G"
    if pdb == "casq1.5crg": return "PDB.5CRG.Homo.CASQ1.D210G"
    if pdb == "casq1.5crh": return "PDB.5CRH.Homo.CASQ1.M53T"
    if pdb == "casq1.5kn0": return "PDB.5KN0.Bos.CASQ1"
    if pdb == "casq1.5kn1": return "PDB.5KN1.Bos.CASQ1"
    if pdb == "casq1.5kn2": return "PDB.5KN2.Bos.CASQ1"
    if pdb == "casq1.5kn3": return "PDB.5KN3.Bos.CASQ1"
    return ""    
    
def get_texshade_commands_pdb(pdb, chain_pairs, pickle_prefix):
    # Load interface residues from a pickle.
    interface_residues = []
    for interface in chain_pairs:
        filename = "./output/" + pickle_prefix + "_interface_residues_" + pdb + "_" + interface + ".p"
        residue_data = pickle.load(open(filename, "rb"))
        for residue in residue_data:
            interface_residues.append(int(residue[1]))
    
    # Make two texshade selections, one for interface residues and one for everything else.
    # The goal is produce tex that looks something like this:
    # \shaderegion{1}{13..13,20..20}{Red}{Green}
    # \tintregion{1}{}14..19}
    #
    # We will loop through the interface residues and add each 
    # residue to the shaderegion command.
    #
    # Sort and deduplicate. Texshade highlighting does not seem to work correctly otherwise.
    interface_residues_sorted = sorted(set(interface_residues),key=int)
    shade = "\\shaderegion{" + get_sequence_label(pdb) + "}{"
    first_residue = True
    for residue in interface_residues_sorted:
        if not first_residue:
            shade = shade + ","
        first_residue = False
        shade = shade + str(residue) + ".." + str(residue)

    other_residues = set(range(22, 371)) - set(interface_residues_sorted)
    # Group these into intervals, so that TeX can process the list efficiently.
    other_residues_grouped = ranges(other_residues)
    tint = "\\tintregion{" + get_sequence_label(pdb) + "}{"
    first_pair = True
    for pair in other_residues_grouped:
        if not first_pair:
            tint = tint + ","
        first_pair = False
        tint = tint + str(pair[0]) + ".." + str(pair[1])

    # Use a dark color for background (argument 2) and a light color for text.
    # shade = shade + "}{Yellow}{Purple}"
    # out_tex = out_tex + shade + "\n"
    # Currently trying to convey both hydropathy and interface residues in a single figure by coloring only on hydropathy and tinting only on non-interface residues.
    tint = tint + "}"
    print interface_residues
    print interface_residues_sorted
    print other_residues
    print shade
    print pdb
    print tint
    return tint

def write_texshade_commands(pdb_list, out_file, chain_pairs, pickle_prefix):
    out_tex = ""

    for pdb in pdb_list:
        tint = get_texshade_commands_pdb(pdb, chain_pairs, pickle_prefix)
        out_tex = out_tex + tint + "\n"

    with open(out_file, "wb") as f:
        f.write(out_tex)


# Omitted some mutants: "casq1.5cre","casq1.5crg","casq1.5crh"
all_pdbs = ["casq2.deo.native","casq1.1a8y","casq2.1sji","casq2.2vaf","casq1.3trp","casq1.3trq","casq1.3uom","casq1.3us3","casq1.3v1w","casq1.5crd","casq1.5kn0","casq1.5kn1","casq1.5kn2","casq1.5kn3"]

# chain_pairs = ["BC","AD","AC","BD"]
# out_file_all = "./output/pdb_tetramer_interface_texshade_regions_all.tex"
# write_texshade_commands(all_pdbs, out_file_all, chain_pairs, "tetramer")

chain_pairs = ["AB"]
out_file_all = "./output/pdb_dimer_interface_texshade_tints.tex"
write_texshade_commands(all_pdbs, out_file_all, chain_pairs, "dimer")

# "casq1.3trp","casq1.3trq","casq1.3us3","casq1.5crd","casq1.5kn0",,"casq1.5kn2","casq1.5kn3"
select_pdbs = ["casq2.deo.native","casq1.1a8y","casq2.1sji","casq2.2vaf","casq1.3uom","casq1.5cre","casq1.5crg","casq1.5crh","casq1.5kn1"]

chain_pairs = ["BC","AD","AC","BD"]
out_file_all = "./output/pdb_tetramer_interface_texshade_tints.tex"
write_texshade_commands(select_pdbs, out_file_all, chain_pairs, "tetramer")

# chain_pairs = ["AB"]
# out_file_all = "./output/pdb_dimer_interface_texshade_regions_all.tex"
# write_texshade_commands(all_pdbs, out_file_all, chain_pairs, "dimer")



