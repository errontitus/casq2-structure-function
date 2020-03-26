import shlex

sep = " & "
terminator = " \\\\\n"
base_path = "../../data/structure_other/"
hline = "\hline\n"
    
def get_protein_description(pdb):
    if pdb == "1a8y":
        return "CASQ1 (Oryctolagus)"
    elif pdb == "1sji":
        return "CASQ2 (Canis)"
    elif pdb == "2vaf":
        return "CASQ2 (Homo)"
    elif pdb == "3trp":
        return "CASQ1 (Oryctolagus)"
    elif pdb == "3trq":
        return "CASQ1 (Oryctolagus)"
    elif pdb == "3uom":
        return "CASQ1 (Homo)"
    elif pdb == "3us3":
        return "CASQ1 (Oryctolagus)"
    elif pdb == "3v1w":
        return "CASQ1 (Oryctolagus)"
    elif pdb == "5crd":
        return "CASQ1 (Homo)"
    elif pdb == "5cre":
        return "CASQ1 (Homo)"
    elif pdb == "5crg":
        return "CASQ1 (Homo)"
    elif pdb == "5crh":
        return "CASQ1 (Homo)" 
    elif pdb == "5kn0":
        return "CASQ1 (Bos)"
    elif pdb == "5kn1":
        return "CASQ1 (Bos)"
    elif pdb == "5kn2":
        return "CASQ1 (Bos)"
    elif pdb == "5kn3":
        return "CASQ1 (Bos)"

def get_cif_tex(pdb):
    tex = ""
    sg = ""
    cell = ""
    angles = ""
    year = ""
    with open (base_path + pdb + "_updated.cif", 'rt') as in_file:
        for line in in_file: 
            values = shlex.split(line)
            if len(values) > 0:
                # Assumes that cell edges are listed in order.
                if "_cell.length_a" == values[0]:
                    cell = values[1]
                if "_cell.length_b" == values[0]:
                    cell = cell + ", " + values[1]
                if "_cell.length_c" == values[0]:
                    cell = cell + ", " + values[1]
                
                # Assumes that angles are listed in order.
                if "_cell.angle_alpha" == values[0]:
                    angles = values[1]
                if "_cell.angle_beta" == values[0]:
                    angles = angles + ", " + values[1]
                if "_cell.angle_gamma" == values[0]:
                    angles = angles + ", " + values[1]
                
                # Assumes that this comes after all other items.
                if "_symmetry.space_group_name_H-M" == values[0]:
                    sg = values[1]
                    break
                if "_citation.year" == values[0]:
                    if pdb == "5kn1":
                        year = "2015"
                    elif pdb == "3v1w":
                        year = "2012"
                    else:
                        year = values[1]
    
    pdb_clean = pdb.upper()
    if pdb == "deo_native":
        pdb_clean = "6OWV"        
    if pdb == "deo_yb":
        pdb_clean = "6OWW"        
    tex = pdb_clean + sep + year + sep + get_protein_description(pdb) + sep + sg + sep + cell + sep + angles + terminator
    return tex

def write_table(content):
    table = "\\begin{tabular}{ cccccc }\n" + hline # |c|c|c|c|c|c|
    table = table + "PDB Code" + sep + "Year" + sep + "Protein" + sep + "Space Group" + sep + "Unit Cell Edges" + sep + "Unit Cell Angles" + terminator + hline

    # Our structures. Replace this with data from cif file when available.
    table = table + "6OWV" + sep + "2019" + sep + "CASQ2 (Homo)" + sep + "P 43 2 2" + sep + "62.52, 62.52, 213.15" + sep + "90, 90, 90" + terminator # + hline

    table = table + "6OWW" + sep + "2019" + sep + "CASQ2 (Homo)" + sep + "P 1 21 1" + sep + "85.8318, 86.0152, 214.34" + sep + "90, 89.9072, 90" + terminator # + hline

    # Other structures.
    for pdb in all_pdbs:
        table = table + get_cif_tex(pdb)
        table = table # + hline
    table = table + "\\end{tabular}\n"
    print table
    with open("./output/table_xtal_comparison.tex", "w+") as f:
        f.write(table)

all_pdbs = ["1a8y","1sji","2vaf","3trp","3trq","3uom","3us3","3v1w","5crd","5cre","5crg","5crh","5kn0","5kn1","5kn2","5kn3"]

write_table(all_pdbs)
