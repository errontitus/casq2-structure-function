import os
import sys
from math import sqrt
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
less_golden = 1.4


##################### CPVT mutants

    # This was done in a batch with the  mutants. Not using those data in this paper.
    # 85 mM KCl
    # A7-9 NP, A10-12 D325E
    # B7-9 WT, B10-12 R251H
    # C7-9 Y55C, C10-12 S173I
    # D7-9 F189L, D10-12 K180R
    # E7-9 P308L, E10-12 R33Q

WT_Ca_85K_clean = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["B7", "B8", "B9"], "WT")
S173I_Ca_85K_clean = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["C10", "C11", "C12"], "S173I")
K180R_Ca_85K_clean = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["D10", "D11", "D12"], "K180R")

WT_Ca_85K = BioTek.normalize_for_plot(WT_Ca_85K_clean)
S173I_Ca_85K = BioTek.normalize_for_plot(S173I_Ca_85K_clean)
K180R_Ca_85K = BioTek.normalize_for_plot(K180R_Ca_85K_clean)

# S173I Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_S173I_85K = BioTek.plot_vs_WT(WT_Ca_85K, S173I_Ca_85K, "S173I", xLabel, yLabel, 40, 0.13, "CASQ2 S173I Turbidity", "", "upper left",1.75, golden)
fig_S173I_85K.savefig("./output/kinetics_CPVT_mutation_S173I_85mM_K.pgf")
fig_S173I_85K.savefig("./output/kinetics_CPVT_mutation_S173I_85mM_K.pdf")

# K180R Turbidity After 1 mM Calcium (in 85 mM KCl)
fig_K180R_85K = BioTek.plot_vs_WT(WT_Ca_85K, K180R_Ca_85K, "K180R", xLabel, yLabel, 40, 0.13, "CASQ2 K180R Turbidity", "", "upper left",1.75, golden)
fig_K180R_85K.savefig("./output/kinetics_CPVT_mutation_K180R_85mM_K.pgf")
fig_K180R_85K.savefig("./output/kinetics_CPVT_mutation_K180R_85mM_K.pdf")


##########################


WT_Ca_0K_clean = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["F7", "F8", "F9"], "WT")
S173I_Ca_0K_clean = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["F4", "F5", "F6"], "S173I")
K180R_Ca_0K_clean = BioTek.clean_data_CPVT_varying_K(["Kinetic read"], ["G4", "G5", "G6"], "K180R")

WT_Ca_0K = BioTek.normalize_for_plot(WT_Ca_0K_clean)
S173I_Ca_0K = BioTek.normalize_for_plot(S173I_Ca_0K_clean)
K180R_Ca_0K = BioTek.normalize_for_plot(K180R_Ca_0K_clean)


# Smaller size to match the size of the EDTA turbidity panel.
fig_S173I_0K = BioTek.plot_vs_WT(WT_Ca_0K, S173I_Ca_0K, "S173I", xLabel, yLabel, 40, 0.13, "CASQ2 S173I Turbidity (0 mM KCl)", "0 mM KCl", "upper left", 1.75, golden)
fig_S173I_0K.savefig("./output/kinetics_CPVT_mutation_S173I_0mM_K.pgf")
fig_S173I_0K.savefig("./output/kinetics_CPVT_mutation_S173I_0mM_K.pdf")

# Not using these data in the manuscript. Not informative.
# fig_K180R_0K = BioTek.plot_vs_WT(WT_Ca_0K, K180R_Ca_0K, "K180R", xLabel, yLabel, 40, 0.13, "CASQ2 K180R Turbidity (0 mM KCl)", "0 mM KCl", "upper left", 2.25, golden)
# fig_K180R_0K.savefig("./output/kinetics_CPVT_mutation_K180R_0mM_K.pgf")
# fig_K180R_0K.savefig("./output/kinetics_CPVT_mutation_K180R_0mM_K.pdf")


########### Source data for journal.


writer = pd.ExcelWriter("./output/source_data_Fig_1bc.xlsx",engine='xlsxwriter')

sheet_name_1bc = "Fig_1bc"

WT_Ca_85K_clean.to_excel(writer, sheet_name=sheet_name_1bc, columns = ["time_minutes","replicate_1","replicate_2","replicate_3"], index = False, startrow = 1)

S173I_Ca_85K_clean.to_excel(writer, sheet_name=sheet_name_1bc, columns = ["replicate_1","replicate_2","replicate_3"], index = False, startrow = 1, startcol = 4)

K180R_Ca_85K_clean.to_excel(writer, sheet_name=sheet_name_1bc, columns = ["replicate_1","replicate_2","replicate_3"], index = False, startrow = 1, startcol = 7)

workbook  = writer.book
worksheet = writer.sheets[sheet_name_1bc]
worksheet.write(0, 0, "Fig 1b,c: Turbidity assays for CASQ2 variants S173I and K180R")

worksheet.write(1, 0, "time_minutes")
worksheet.write(1, 1, "WT")
worksheet.write(1, 2, "WT")
worksheet.write(1, 3, "WT")
worksheet.write(1, 4, "S173I")
worksheet.write(1, 5, "S173I")
worksheet.write(1, 6, "S173I")
worksheet.write(1, 7, "K180R")
worksheet.write(1, 8, "K180R")
worksheet.write(1, 9, "K180R")


writer.save()


########### Source data for journal.


writer = pd.ExcelWriter("./output/source_data_Ext_Data_Fig_1b.xlsx",engine='xlsxwriter')

sheet_name_ext_1b = "Ext_Data_Fig_1b"

WT_Ca_0K_clean.to_excel(writer, sheet_name=sheet_name_ext_1b, columns = ["time_minutes","replicate_1","replicate_2","replicate_3"], index = False, startrow = 1)

S173I_Ca_0K_clean.to_excel(writer, sheet_name=sheet_name_ext_1b, columns = ["replicate_1","replicate_2","replicate_3"], index = False, startrow = 1, startcol = 4)

workbook  = writer.book
worksheet = writer.sheets[sheet_name_ext_1b]
worksheet.write(0, 0, "Ext Data Fig 1b: Turbidity assay for CASQ2 variant S173I in 0 mM KCl")

worksheet.write(1, 0, "time_minutes")
worksheet.write(1, 1, "WT")
worksheet.write(1, 2, "WT")
worksheet.write(1, 3, "WT")
worksheet.write(1, 4, "S173I")
worksheet.write(1, 5, "S173I")
worksheet.write(1, 6, "S173I")

writer.save()