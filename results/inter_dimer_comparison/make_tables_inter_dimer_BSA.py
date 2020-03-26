#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import xml.etree.ElementTree as et
import pandas as pd

class pisa_xml_to_dataframe:

    def __init__(self, filename):
        # self.root = ET.XML(xml_data)
        self.root = et.parse(filename).getroot()

    def _parse_interfaces(self, root):
        cols = ['ID', 'Monomer1', 'Monomer2', 'Area', 'Pvalue', 'DeltaG', 'Nhb', 'Nsb', 'Nds']
        interfaces = pd.DataFrame(columns=cols)
        for interface in root.findall('interface'):
            id = interface.find("id").text
            int_area = str(round(float(interface.find("int_area").text),0))
            int_solv_en = str(round(float(interface.find("int_solv_en").text),1))
            pvalue = interface.find("pvalue").text

            h_bonds = interface.find("h-bonds")
            n_h_bonds = h_bonds.find("n_bonds").text

            salt_bridges = interface.find("salt-bridges")
            n_salt_bridges = salt_bridges.find("n_bonds").text

            ss_bonds = interface.find("ss-bonds")
            n_ss_bonds = ss_bonds.find("n_bonds").text

            for molecule in interface.findall('molecule'):
                mol_id = molecule.find("id").text
                if mol_id == "1":
                    mol1 = molecule.find("chain_id").text
                if mol_id == "2":
                    mol2 = molecule.find("chain_id").text

            # print id, mol1, mol2, int_area, int_solv_en, pvalue, n_h_bonds, n_salt_bridges, n_ss_bonds
            interfaces = interfaces.append(
                    pd.Series([id, mol1, mol2, int_area, pvalue, int_solv_en,
                              n_h_bonds, n_salt_bridges, n_ss_bonds], index=cols),
                             ignore_index=True)
        return interfaces

    # Fully recursive parser. Hot helpful here.
    #    def parse_root(self, root):
    #        return [self.parse_element(child) for child in iter(root)]
    #
    #    def parse_element(self, element, parsed=None):
    #        if parsed is None:
    #            parsed = dict()
    #        for key in element.keys():
    #            parsed[key] = element.attrib.get(key)
    #        if element.text:
    #            parsed[element.tag] = element.text
    #        for child in list(element):
    #            self.parse_element(child, parsed)
    #        return parsed

    def get_interfaces(self):
        return self._parse_interfaces(self.root)

################

base_path = "../shared_pdb/pisa/output/tetramer_"

sep = " & "
terminator = " \\\\\n"
hline = "\hline\n"
tableTerminator = "\\end{tabular}\n"
longTableTerminator = "\\end{longtable}\n"

# def get_pisa_tex_dimer(pdb):
#     dimer_tex = ""
#     pdb_clean = pdb.upper()
#     casq2 = ["deo_native","deo_yb","1sji","2vaf"]
#     compact_dimers = ["deo_native","deo_yb","2vaf","3uom","5crg","5crh","5kn1","5kn2"]
#     rowCount = 0

#     if pdb == "deo_native":
#         pdb_clean = "6OWV"        
#     if pdb == "deo_yb":
#         pdb_clean = "6OWW"

#     casq2vscasq1 = "CASQ1"
#     if pdb in casq2:
#         casq2vscasq1 = "CASQ2"

#     dimerClass = "Loose"
#     if pdb in compact_dimers:
#         dimerClass = "Tight"
#     # Columns for dimer table
#     #   PDB
#     #   CASQ2/CASQ1
#     #   Dimer Conformational Class
#     #   BSA (PISA)
#     #   DeltaG (PISA)
#     xml2df = pisa_xml_to_dataframe(base_path + pdb + "_no_het_pisa.xml")
#     df = xml2df.get_interfaces()
#     for index, row in df.iterrows():
#         if (row['Monomer1'] == "A" and row['Monomer2'] == "B"):
#             # Dimer
#             dimer_tex = pdb_clean + sep + casq2vscasq1 + sep + dimerClass + sep + row['Area'] + sep + row['DeltaG'] + terminator + hline
#             break

#     print pdb
#     print df
#     return dimer_tex;

def translate_to_prime_notation(chain_letter):
    if chain_letter == "C":
        return "A'"
    if chain_letter == "D":
        return "B'"
    return chain_letter

# def get_pisa_tex_tetramer_old(pdb):
#     tetramer_tex = ""
#     tetramer_interfaces = []
#     pdb_clean = pdb.upper()
#     equivs = ""
#     casq2 = ["deo_native","deo_yb","1sji","2vaf"]
#     rowCount = 0

#     if pdb == "deo_native":
#         pdb_clean = "6OWV"        
#         equivs = "6OWW"
#     if pdb == "deo_yb":
#         pdb_clean = "6OWW"
#     if pdb == "1a8y":
#         equivs = "3TRP, 3TRQ, 3US3, 3V1W, 5CRD, 5KN0, 5KN3"
#     if pdb == "5kn0":
#         equivs = "1A8Y"
#     if pdb == "5kn1":
#         equivs = "5KN2"

#     casq2vscasq1 = "CASQ1"
#     if pdb in casq2:
#         casq2vscasq1 = "CASQ2"

#     # Columns for tetramer table
#     #   PDB
#     #   CASQ2/CASQ1
#     #   Dimer Conformational Class
#     #   BSA (PISA)
#     #   DeltaG (PISA)
#     xml2df = pisa_xml_to_dataframe(base_path + pdb + "_no_het_pisa.xml")
#     df = xml2df.get_interfaces()
#     for index, row in df.iterrows():
#         if (row['Monomer1'] == "A" and row['Monomer2'] == "B"):
#             # Skip
#             print "Skipping dimer interface AB"
#         elif (row['Monomer1'] == "C" and row['Monomer2'] == "D"):
#             # Skip
#             print "Skipping dimer interface CD"
#         else:
# #            tetramerRow = "Tetramer (" + row['Monomer1'] + row['Monomer2'] + ")" + sep + row['Area'] 
#             monomer1 = translate_to_prime_notation(row['Monomer1'])
#             monomer2 = translate_to_prime_notation(row['Monomer2'])
#             tetramerRow = monomer1 + ", " + monomer2 + sep + row['Area'] 
#             tetramer_interfaces.append(tetramerRow)
#     print "tetramer"
#     print pdb
#     print df
#     rowCount = len(tetramer_interfaces)
#     for i in range(rowCount,4):
#         tetramerRow = sep
#         tetramer_interfaces.append(tetramerRow)

#     rowCount = len(tetramer_interfaces)
#     for i in range(rowCount):
#         if i == 0:
#             # First row gets the multirow operators
#             tetramer_tex = "\multirow{" + str(rowCount) + "}{*}{" + pdb_clean + "} " + sep + "\multirow{" + str(rowCount) + "}{*}{" + casq2vscasq1 + "} " + sep + tetramer_interfaces[i] + sep + "\\adjustbox{valign=c}{\multirow{" + str(rowCount) + "}{*}{\includegraphics[width=1.25in,keepaspectratio]{../../results/tetramer_comparison_structure/output/tetramer_" + pdb + "_oriented_cropped.png}}}" + sep + "\multirow{" + str(rowCount) + "}{2cm}{" + equivs + "} " 
#             # 
#         else:
#             tetramer_tex = tetramer_tex + terminator + " \\cline{3-4}\n" + sep + sep + tetramer_interfaces[i] + sep + sep
        
#         if i == (rowCount - 1):
#             tetramer_tex = tetramer_tex + terminator + hline 

#     return tetramer_tex

def write_pisa_tex_tetramer(pdb):
    tetramer_tex = ""
    tetramer_interfaces = []
    xml2df = pisa_xml_to_dataframe(base_path + pdb + "_no_het_pisa.xml")
    df = xml2df.get_interfaces()
    for index, row in df.iterrows():
        if (row['Monomer1'] == "A" and row['Monomer2'] == "B"):
            # Skip
            print "Skipping dimer interface AB"
        elif (row['Monomer1'] == "C" and row['Monomer2'] == "D"):
            # Skip
            print "Skipping dimer interface CD"
        else:
            monomer1 = translate_to_prime_notation(row['Monomer1'])
            monomer2 = translate_to_prime_notation(row['Monomer2'])
            tetramer_tex = tetramer_tex + monomer1 + ", " + monomer2 + sep + row['Area'] + terminator
    print "tetramer"
    print pdb
    print df
    rowCount = len(tetramer_interfaces)
    with open("./output/table_interface_comparison_tetramer_" + pdb + ".tex", "w+") as f:
        f.write(tetramer_tex)
    return

def write_table_dimer(pdb_list):
    dimerTable = ""
    for pdb in pdb_list:
        dimerTable = dimerTable + get_pisa_tex_dimer(pdb)

    with open("./output/table_interface_comparison_dimer.tex", "w+") as f:
        f.write(dimerTable)

def write_table_tetramer(pdb_list):
    for pdb in pdb_list:
        write_pisa_tex_tetramer(pdb)

# all_pdbs = ["deo_native","2vaf","3uom","5crg","5crh","5kn1","5kn2","1a8y","1sji","3trp","3trq","3us3","3v1w","5crd","5cre","5kn0","5kn3"]
# write_table_dimer(all_pdbs)

select_pdbs = ["deo_native","1a8y","1sji","2vaf","3uom","5cre","5crg","5kn1"]
write_table_tetramer(select_pdbs)
