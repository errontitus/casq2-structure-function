import os
import sys
from math import sqrt
import matplotlib.pyplot as plt
import matplotlib
import pandas as pd


from lib import BioTek

# Assay conditions slightly different:
# Buffer: Turbidity Assay Buffer (TAB, 15 mM Tris pH 7.2, 20 mM NaCl, 0 mM KCl)
# EDTA Dialysis: 5 mM in TAB
# Plate type: uClear, black
# Calcium: 7 uL of 20 mM Ca added for final concentration of 1 mM
# EDTA: 7 uL of 20 mM EDTA added for final concentration of 1 mM

xLabel = "Seconds after Calcium Addition"
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

##################### This was done in a batch with some of Jason's mutants. Ignore those.

    # A7-9 NP, A10-12 D325E
    # B7-9 WT, B10-12 R251H
    # C7-9 Y55C, C10-12 S173I
    # D7-9 F189L, D10-12 K180R
    # E7-9 P308L, E10-12 R33Q

WT_EDTA_clean = BioTek.clean_data_WT_EDTA(["Kinetic read"], ["B1", "B2", "B3"], "WT")

WT_EDTA = BioTek.normalize_for_plot(WT_EDTA_clean)

fig_WT_EDTA = BioTek.plot_WT_EDTA(WT_EDTA, "WT", xLabel, yLabel, 750, 0.025, "WT Turbidity After 1 mM Calcium,\n then 1 mM EDTA (in 0 mM KCl)", "0 mM KCl", "upper left",1.75, golden)
fig_WT_EDTA.savefig("./output/kinetics_WT_EDTA.pgf")
fig_WT_EDTA.savefig("./output/kinetics_WT_EDTA.pdf")


########### Source data for journal.

writer = pd.ExcelWriter("./output/source_data_Ext_Data_Fig_1a.xlsx",engine='xlsxwriter')

sheet_name_ext_1a = "Ext_Data_Fig_1a"

WT_EDTA_clean.to_excel(writer, sheet_name=sheet_name_ext_1a, columns = ["time_seconds","replicate_1","replicate_2","replicate_3"], index = False, startrow = 1)

workbook  = writer.book
worksheet = writer.sheets[sheet_name_ext_1a]
worksheet.write(0, 0, "Ext Data Fig 1a: Turbidity assay for WT CASQ2 with EDTA reversal")

worksheet.write(1, 0, "time_seconds")
worksheet.write(1, 1, "WT")
worksheet.write(1, 2, "WT")
worksheet.write(1, 3, "WT")

writer.save()
