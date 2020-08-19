import os
import sys
from math import sqrt
from matplotlib.backends.backend_pdf import PdfPages
import matplotlib.pyplot as plt
import matplotlib
import pandas as pd


from lib import BioTek

# Assay conditions:
# Buffer: Turbidity Assay Buffer (TAB, 15 mM Tris pH 7.4, 20 mM NaCl, 85 mM KCl)
# EDTA Dialysis: 10 mM in TAB
# Plate type: uClear, black or clear, half-area
# Calcium: 7 uL of 20 mM Ca added for final concentration of 1 mM
# EDTA: 7 uL of 20 mM EDTA added for final concentration of 1 mM

# Additional mutant D325A requested by reviewer because D325I was a too aggressive substitution.

xLabel = "Minutes after Calcium Addition"
yLabel = "Abs at 350 nm"

# For debugging
# background_offset = BioTek.background_mean_from_matrix(filename, background_matrix_header_row, background_matrix_nrows, "A", "4", "6")
# exit()

# For debugging
# import pandas as pd
# filename = filename
# #cols = ["Kinetic read", "A7", "A8", "A9"]
# header = 21
# nrows = 113
# raw = pd.read_csv(filepath_or_buffer=filename, header=header, sep="\t", nrows=nrows)
# print raw
# exit() 


matplotlib.rcParams.update({'font.size': 8})
matplotlib.rcParams.update({"legend.handlelength": 0.5})
matplotlib.rcParams.update({"legend.frameon": False})
golden = 1.61803398875

##################### Interface mutants

    # A NP
    # B WT
    # C D325I
    # D D325A

WT_Ca_85K_interface_clean = BioTek.clean_data_interface_mutant_D325A(["Kinetic read"], ["B1", "B2", "B3"], "WT")
D325I_Ca_85K_interface_clean = BioTek.clean_data_interface_mutant_D325A(["Kinetic read"], ["C1", "C2", "C3"], "D325I")

# There was a bug here in the submitted version of the paper where well D2 was listed twice (instead of D2 and D3). In that version of the code, the statistics were computed on D1 + D2 + D2. The bug made data quality look worse than it actually is (i.e. the error bars are much smaller now that all the replicates are included).
D325A_Ca_85K_interface_clean = BioTek.clean_data_interface_mutant_D325A(["Kinetic read"], ["D1", "D2", "D3"], "D325A")


WT_Ca_85K_interface = BioTek.normalize_for_plot(WT_Ca_85K_interface_clean)
D325I_Ca_85K_interface = BioTek.normalize_for_plot(D325I_Ca_85K_interface_clean)
D325A_Ca_85K_interface = BioTek.normalize_for_plot(D325A_Ca_85K_interface_clean)


# # D325I Turbidity After 1 mM Calcium (in 85 mM KCl)
# fig_D325I_Ca_85K_interface = BioTek.plot_vs_WT(WT_Ca_85K_interface, D325I_Ca_85K_interface, "D325I", xLabel, yLabel, 40, 0.13, "CASQ2 D325I Turbidity", "", "lower right", 1.75, golden)
# fig_D325I_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D325I_85mM_K.pgf")
# fig_D325I_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D325I_85mM_K.pdf")

# # D325A Turbidity After 1 mM Calcium (in 85 mM KCl)
# fig_D325A_Ca_85K_interface = BioTek.plot_vs_WT(WT_Ca_85K_interface, D325A_Ca_85K_interface, "D325A", xLabel, yLabel, 40, 0.13, "CASQ2 D325A Turbidity", "", "lower right", 1.75, golden)
# fig_D325A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D325A_85mM_K.pgf")
# fig_D325A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D325A_85mM_K.pdf")

# D325A and D325I Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_D325A_Ca_85K_interface = BioTek.plot_two_variants_vs_WT(WT_Ca_85K_interface, D325A_Ca_85K_interface, "D325A", D325I_Ca_85K_interface, "D325I", xLabel, yLabel, 40, 0.13, "CASQ2 D325A and D325I Turbidity", "", "upper left", 1.75, golden)
fig_D325A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D325A_D325I_85mM_K.pgf")
fig_D325A_Ca_85K_interface.savefig("./output/kinetics_interface_mutation_D325A_D325I_85mM_K.pdf")


########### Source data for journal.


writer = pd.ExcelWriter("./output/source_data_Fig_6d.xlsx",engine='xlsxwriter')

sheet_name_6d = "Fig_6d"

WT_Ca_85K_interface_clean.to_excel(writer, sheet_name=sheet_name_6d, columns = ["time_minutes","replicate_1","replicate_2","replicate_3"], index = False, startrow = 1)

D325A_Ca_85K_interface_clean.to_excel(writer, sheet_name=sheet_name_6d, columns = ["replicate_1","replicate_2","replicate_3"], index = False, startrow = 1, startcol = 4)

D325I_Ca_85K_interface_clean.to_excel(writer, sheet_name=sheet_name_6d, columns = ["replicate_1","replicate_2","replicate_3"], index = False, startrow = 1, startcol = 7)

workbook  = writer.book
worksheet = writer.sheets[sheet_name_6d]
worksheet.write(0, 0, "Fig 6d: Turbidity assays for CASQ2 variants D325A and D325I")

worksheet.write(1, 0, "time_minutes")
worksheet.write(1, 1, "WT")
worksheet.write(1, 2, "WT")
worksheet.write(1, 3, "WT")
worksheet.write(1, 4, "D325A")
worksheet.write(1, 5, "D325A")
worksheet.write(1, 6, "D325A")
worksheet.write(1, 7, "D325I")
worksheet.write(1, 8, "D325I")
worksheet.write(1, 9, "D325I")

writer.save()